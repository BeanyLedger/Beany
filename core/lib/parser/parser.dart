import 'package:antlr4/antlr4.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/custom_statement.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/query_statement.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';

import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/balance_statement.dart';
import 'package:beany_core/core/close_statement.dart';
import 'package:beany_core/core/commodity_statement.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/document_statement.dart';
import 'package:beany_core/core/event_statement.dart';
import 'package:beany_core/core/note_statement.dart';
import 'package:beany_core/core/open_statement.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_statement.dart';
import 'package:beany_core/core/statements.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/parser/BeancountLexer.dart';
import 'package:beany_core/parser/BeancountParser.dart';

class InputStreamWithSourceName extends InputStream {
  final String sourceName;

  InputStreamWithSourceName.fromString(String input, this.sourceName)
      : super.fromString(input);
}

BeancountParser parse(String text, {String? filePath}) {
  if (!text.endsWith('\n\n')) text += '\n\n';
  final inputStream = filePath != null
      ? InputStreamWithSourceName.fromString(text, filePath)
      : InputStream.fromString(text);
  final lexer = BeancountLexer(inputStream);
  final tokens = CommonTokenStream(lexer);
  final parser = BeancountParser(tokens);

  // parser.errorHandler = BailErrorStrategy();
  parser.addErrorListener(DiagnosticErrorListener());

  return parser;
}

class ParsingException implements Exception {
  final String message;
  final ParsingInfo parsingInfo;

  ParsingException(this.message, this.parsingInfo);

  @override
  String toString() {
    return 'ParsingException{message: $message, parsingInfo: ${parsingInfo.toJson()}}';
  }
}

ParsingInfo _buildParsingInfo(ParserRuleContext ctx) {
  return ParsingInfo(
    filePath: ctx.start!.inputStream!.sourceName,
    startLine: ctx.start!.line!,
    endLine: ctx.stop!.line!,
    startCol: ctx.start!.charPositionInLine,
    endCol: ctx.stop!.charPositionInLine,
  );
}

extension DateParsing on DateContext {
  Date val() {
    var parts = DATE()!.text!.split('-');
    if (parts.length != 3) {
      throw ParsingException(
          "Date must be in the format YYYY-MM-DD", _buildParsingInfo(this));
    }

    var year = int.parse(parts[0]);
    var month = int.parse(parts[1]);
    var day = int.parse(parts[2]);
    return Date(year, month, day);
  }
}

extension NumberParsing on NumberContext {
  Decimal val() {
    return Decimal.parse(text.replaceAll(',', ''));
  }
}

extension AmountParsing on AmountContext {
  Amount val() {
    var c = currency()!.val();
    return Amount(number()!.val(), c);
  }
}

extension QuotedStringParsing on Quoted_stringContext {
  String val() => text.substring(1, text.length - 1);
}

extension AcountParsing on AccountContext {
  Account val() => Account(ACCOUNT()!.text!);
}

extension PriceStatementParsing on PriceStatementContext {
  PriceStatement val() => PriceStatement(
        date()!.val(),
        currency()!.val(),
        amount()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension QueryStatementParsing on QueryStatementContext {
  QueryStatement val() => QueryStatement(
        date()!.val(),
        name!.val(),
        value!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension OpenParsing on OpenStatementContext {
  OpenStatement val() => OpenStatement(
        date()!.val(),
        account()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension CloseParsing on CloseStatementContext {
  CloseStatement val() => CloseStatement(
        date()!.val(),
        account()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension NoteParsing on NoteStatementContext {
  NoteStatement val() => NoteStatement(
        date()!.val(),
        account()!.val(),
        quoted_string()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension EventParsing on EventStatementContext {
  EventStatement val() => EventStatement(
        date()!.val(),
        name!.val(),
        value!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension BalanceParsing on BalanceStatementContext {
  BalanceStatement val() => BalanceStatement(
        date()!.val(),
        account()!.val(),
        amount()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension CurrencyParsing on CurrencyContext {
  String val() {
    return CURRENCY()!.text!;
  }
}

extension CommodityParsing on CommodityStatementContext {
  CommodityStatement val() => CommodityStatement(
        date()!.val(),
        currency()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension DocumentParsing on DocumentStatementContext {
  DocumentStatement val() => DocumentStatement(
        date()!.val(),
        account()!.val(),
        quoted_string()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension TagParsing on TagsContext {
  Iterable<String> val() {
    return TAGs().map((e) => e.text!.substring(1));
  }
}

extension PostingSpecAccountOnlyParsing on PostingSpecAccountOnlyContext {
  PostingSpec val() {
    return PostingSpec(
      account()!.val(),
      null,
      comment: comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension CommentParsing on CommentContext {
  String val() {
    var x = text;
    assert(x.startsWith(';'), "`$x` does not start with a ;");
    return x.substring(1).trim();
  }
}

extension PostingSpecAccountAmountParsing on PostingSpecAccountAmountContext {
  PostingSpec val() {
    return PostingSpec(
      account()!.val(),
      amount()!.val(),
      comment: comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension PriceSpecParsing on PriceSpecContext {
  PriceSpec val() {
    if (priceSpecPer() != null) return priceSpecPer()!.val();
    if (priceSpecTotal() != null) return priceSpecTotal()!.val();

    throw ParsingException("Unknown price spec", _buildParsingInfo(this));
  }
}

extension PriceSpecPerParsing on PriceSpecPerContext {
  PriceSpec val() {
    return PriceSpec(
      amountPer: amountSpec()!.val(),
    );
  }
}

extension PriceSpecTotalParsing on PriceSpecTotalContext {
  PriceSpec val() {
    return PriceSpec(
      amountTotal: amountSpec()!.val(),
    );
  }
}

extension AmountSpecParsing on AmountSpecContext {
  AmountSpec val() {
    var n = number();
    var c = currency();

    if (n == null && c == null) {
      throw ParsingException(
          "AmountSpec has no number or currency", _buildParsingInfo(this));
    }
    return AmountSpec(n?.val(), c?.val());
  }
}

extension PostingSpecWithPriceParsing on PostingSpecWithPriceContext {
  PostingSpec val() {
    return PostingSpec(
      account()!.val(),
      amount()!.val(),
      priceSpec: priceSpec()!.val(),
      comment: comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension PostingSpecWithCostParsing on PostingSpecWithCostContext {
  PostingSpec val() {
    return PostingSpec(
      account()!.val(),
      amount()!.val(),
      costSpec: costSpec()!.val(),
      comment: comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension PostingSpecWithCostAndPriceParsing
    on PostingSpecWithCostAndPriceContext {
  PostingSpec val() {
    return PostingSpec(
      account()!.val(),
      amount()!.val(),
      costSpec: costSpec()!.val(),
      priceSpec: priceSpec()!.val(),
      comment: comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension CostSpecParsing on CostSpecContext {
  CostSpec val() {
    if (costSpecPer() != null) return costSpecPer()!.val();
    if (costSpecTotal() != null) return costSpecTotal()!.val();
    throw ParsingException("Unknown cost spec", _buildParsingInfo(this));
  }
}

extension CostSpecPerParsing on CostSpecPerContext {
  CostSpec val() {
    var (amount, date, label) = costSpecExpr()!.val();
    return CostSpec(amountPer: amount, date: date, label: label);
  }
}

extension CostSpecTotalParsing on CostSpecTotalContext {
  CostSpec val() {
    var (amount, date, label) = costSpecExpr()!.val();
    return CostSpec(amountTotal: amount, date: date, label: label);
  }
}

extension CostSpecExprParsing on CostSpecExprContext {
  (Amount, Date?, String?) val() {
    if (costSpecExprAmountOnly() != null)
      return costSpecExprAmountOnly()!.val();
    if (costSpecExprAmountAndDate() != null)
      return costSpecExprAmountAndDate()!.val();
    if (costSpecExprAmountAndLabel() != null)
      return costSpecExprAmountAndLabel()!.val();
    if (costSpecExprAmountDateAndLabel() != null)
      return costSpecExprAmountDateAndLabel()!.val();

    throw ParsingException("Unknown cost spec expr", _buildParsingInfo(this));
  }
}

extension CostSpecExprAmountOnlyParing on CostSpecExprAmountOnlyContext {
  (Amount, Date?, String?) val() {
    return (amount()!.val(), null, null);
  }
}

extension CostSpecExprAmountDateParsing on CostSpecExprAmountAndDateContext {
  (Amount, Date?, String?) val() {
    return (amount()!.val(), date()!.val(), null);
  }
}

extension CostSpecExprAmountLabelParsing on CostSpecExprAmountAndLabelContext {
  (Amount, Date?, String?) val() {
    return (amount()!.val(), null, quoted_string()!.val());
  }
}

extension CostSpecExprAmountDateLabelParsing
    on CostSpecExprAmountDateAndLabelContext {
  (Amount, Date?, String?) val() {
    return (amount()!.val(), date()!.val(), quoted_string()!.val());
  }
}

extension TrFlagParsing on TrFlagContext {
  TransactionFlag val() {
    switch (text) {
      case '*':
      case 'txn':
        return TransactionFlag.Okay;
      case '!':
        return TransactionFlag.Warning;
      default:
        throw ParsingException(
            "Unknown transaction flag - $text", _buildParsingInfo(this));
    }
  }
}

extension MetadataValueParsing on MetadataValueContext {
  MetaValue val() {
    if (number() != null) {
      return MetaValue(numberValue: number()!.val());
    }
    if (account() != null) {
      return MetaValue(accountValue: account()!.val());
    }
    if (amount() != null) {
      return MetaValue(amountValue: amount()!.val());
    }
    if (quoted_string() != null) {
      return MetaValue(stringValue: quoted_string()!.val());
    }
    if (TAG() != null) {
      return MetaValue(tagValue: TAG()!.text!.substring(1));
    }
    if (date() != null) {
      return MetaValue(dateValue: date()!.val());
    }

    throw ParsingException(
        "Couldn't parse metadata value", _buildParsingInfo(this));
  }
}

extension MetadaataParsing on MetadataContext {
  Map<String, MetaValue> val() {
    var m = <String, MetaValue>{};

    var keys = metadataKeys();
    var values = metadataValues();

    assert(keys.length == values.length);
    for (var i = 0; i < keys.length; i++) {
      var key = keys[i].text;
      assert(key.endsWith(':'), "Key $key does not end with :");
      key = key.substring(0, key.length - 1);
      m[key] = values[i].val();
    }

    return m;
  }
}

extension TransactionHeaderParsing on TrHeaderContext {
  TransactionSpec val() {
    return TransactionSpec(
      date()!.val(),
      trFlag()!.val(),
      narration!.val(),
      payee: payee?.val(),
      tags: tags()?.val(),
      parsingInfo: _buildParsingInfo(this),
    );
  }
}

extension PostingSpecWithCommentsParsing on PostingSpecWithCommentsContext {
  PostingSpec val() {
    var preComments = comments().map((c) => c.val());
    return postingSpec()!.val().copyWith(preComments: preComments);
  }
}

extension PostingSpecParsing on PostingSpecContext {
  PostingSpec val() {
    var p0 = postingSpecAccountAmount();
    if (p0 != null) return p0.val();

    var p1 = postingSpecAccountOnly();
    if (p1 != null) return p1.val();

    var p2 = postingSpecWithPrice();
    if (p2 != null) return p2.val();

    var p3 = postingSpecWithCost();
    if (p3 != null) return p3.val();

    var p4 = postingSpecWithCostAndPrice();
    if (p4 != null) return p4.val();

    throw ParsingException("Unknown posting spec", _buildParsingInfo(this));
  }
}

extension TransactionParsing on TrStatementContext {
  TransactionSpec val() {
    var tr = trHeader()!.val();

    return tr.copyWith(
      postings: postingSpecWithCommentss().map((p) => p.val()),
      meta: metadata()?.val(),
      // The ParsingInfo is already present in the header
    );
  }
}

extension CustomStatementParsing on CustomStatementContext {
  CustomStatement val() => CustomStatement(
        date()!.val(),
        quoted_strings().map((e) => e.val()).toList(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension DirectiveParsing on DirectiveContext {
  Directive val() {
    if (balanceStatement() != null) return balanceStatement()!.val();
    if (closeStatement() != null) return closeStatement()!.val();
    if (openStatement() != null) return openStatement()!.val();
    if (priceStatement() != null) return priceStatement()!.val();
    if (queryStatement() != null) return queryStatement()!.val();
    if (commodityStatement() != null) return commodityStatement()!.val();
    if (documentStatement() != null) return documentStatement()!.val();
    if (eventStatement() != null) return eventStatement()!.val();
    if (noteStatement() != null) return noteStatement()!.val();
    if (trStatement() != null) return trStatement()!.val();
    if (customStatement() != null) return customStatement()!.val();

    throw ParsingException("Unknown Directive", _buildParsingInfo(this));
  }
}

extension CommentStatementParsing on CommentStatementContext {
  CommentStatement val() {
    var c = comment()!.val();
    return CommentStatement(c);
  }
}

extension OptionStatementParsing on OptionStatementContext {
  OptionStatement val() => OptionStatement(
        key!.val(),
        value!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension PluginStatementParsing on PluginStatementContext {
  PluginStatement val() {
    return PluginStatement(
      name!.val(),
      value != null ? value!.val() : null,
      parsingInfo: _buildParsingInfo(this),
    );
  }
}

extension IncludeStatementParsing on IncludeStatementContext {
  IncludeStatement val() => IncludeStatement(
        quoted_string()!.val(),
        parsingInfo: _buildParsingInfo(this),
      );
}

extension StatementParsing on StatementContext {
  Statement val() {
    var d = directive();
    if (d != null) return d.val();

    var c = commentStatement();
    if (c != null) return c.val();

    var o = optionStatement();
    if (o != null) return o.val();

    var i = includeStatement();
    if (i != null) return i.val();

    var p = pluginStatement();
    if (p != null) return p.val();

    throw ParsingException("Unknown Statement", _buildParsingInfo(this));
  }
}

extension AllParsing on AllContext {
  Iterable<Statement> val() {
    return statements().map((s) => s.val());
  }
}

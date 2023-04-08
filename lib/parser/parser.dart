import 'package:antlr4/antlr4.dart';
import 'package:beany/core/cost_spec.dart';
import 'package:beany/core/meta_value.dart';
import 'package:decimal/decimal.dart';

import 'package:beany/core/account.dart';
import 'package:beany/core/balance.dart';
import 'package:beany/core/close.dart';
import 'package:beany/core/commodity.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/document.dart';
import 'package:beany/core/event.dart';
import 'package:beany/core/note.dart';
import 'package:beany/core/open.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/price.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/parser/BeancountLexer.dart';
import 'package:beany/parser/BeancountParser.dart';

BeancountParser parse(String text) {
  if (!text.endsWith('\n')) text += '\n';
  final inputStream = InputStream.fromString(text);
  final lexer = BeancountLexer(inputStream);
  final tokens = CommonTokenStream(lexer);
  final parser = BeancountParser(tokens);

  // parser.errorHandler = BailErrorStrategy();
  parser.addErrorListener(DiagnosticErrorListener());

  return parser;
}

extension DateParsing on DateContext {
  DateTime val() {
    if (exception != null) {
      print("WTF  $exception#");
    }

    return DateTime.parse(DATE()!.text!);
  }
}

extension AmountParsing on AmountContext {
  Amount val() {
    var c = currency()!.text;
    var n = Decimal.parse(NUMBER()!.text!);
    return Amount(n, c);
  }
}

extension QuotedStringParsing on Quoted_stringContext {
  String val() => text.substring(1, text.length - 1);
}

extension AcountParsing on AccountContext {
  Account val() => Account(ACCOUNT()!.text!);
}

extension PriceStatementParsing on PriceStatementContext {
  Price val() => Price(date()!.val(), currency()!.text, amount()!.val());
}

extension OpenParsing on OpenStatementContext {
  Open val() => Open(date()!.val(), account()!.val());
}

extension CloseParsing on CloseStatementContext {
  Close val() => Close(date()!.val(), account()!.val());
}

extension NoteParsing on NoteStatementContext {
  Note val() => Note(date()!.val(), account()!.val(), quoted_string()!.val());
}

extension EventParsing on EventStatementContext {
  Event val() => Event(date()!.val(), name!.val(), value!.val());
}

extension BalanceParsing on BalanceStatementContext {
  Balance val() => Balance(date()!.val(), account()!.val(), amount()!.val());
}

extension CurrencyParsing on CurrencyContext {
  String val() => WORD()!.text!;
}

extension CommodityParsing on CommodityStatementContext {
  Commodity val() => Commodity(date()!.val(), currency()!.val());
}

extension DocumentParsing on DocumentStatementContext {
  Document val() =>
      Document(date()!.val(), account()!.val(), quoted_string()!.val());
}

extension TagParsing on TagsContext {
  Iterable<String> val() {
    return TAGs().map((e) => e.text!.substring(1));
  }
}

extension PostingSpecAccountOnlyParsing on Posting_spec_account_onlyContext {
  Posting val() {
    return Posting(
      account()!.val(),
      null,
      comment: inline_comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension InlineCommentParsing on Inline_commentContext {
  String val() {
    var x = text;
    assert(x.startsWith(';'), "`$x` does not start with a ;");
    return x.substring(1);
  }
}

extension PostingSpecAccountAmountParsing
    on Posting_spec_account_amountContext {
  Posting val() {
    return Posting(
      account()!.val(),
      amount()!.val(),
      comment: inline_comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension CostSpecParsing on Cost_specContext {
  CostSpec val() {
    if (cost_spec_per() != null) return cost_spec_per()!.val();
    if (cost_spec_total() != null) return cost_spec_total()!.val();

    throw Exception("Unknown cost spec");
  }
}

extension CostSpecPerParsing on Cost_spec_perContext {
  CostSpec val() {
    return CostSpec(
      amountPer: amount_spec()!.val(),
    );
  }
}

extension CostSpecTotalParsing on Cost_spec_totalContext {
  CostSpec val() {
    return CostSpec(
      amountTotal: amount_spec()!.val(),
    );
  }
}

extension AmountSpecParsing on Amount_specContext {
  AmountSpec val() {
    var n = NUMBER();
    var c = currency();

    if (n == null && c == null) {
      throw Exception("AmountSpec has no number or currency");
    }

    Decimal? number;
    if (n != null) {
      number = Decimal.parse(NUMBER()!.text!);
    }
    return AmountSpec(number, currency()?.val());
  }
}

extension PostingSpecWithCostParsing on Posting_spec_with_costContext {
  Posting val() {
    return Posting(
      account()!.val(),
      amount()!.val(),
      costSpec: cost_spec()!.val(),
      comment: inline_comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension TrCommentParsing on Tr_commentContext {
  String val() => inline_comment()!.val();
}

extension TrFlagParsing on Tr_flagContext {
  TransactionFlag val() {
    switch (text) {
      case '*':
      case 'txn':
        return TransactionFlag.Okay;
      case '!':
        return TransactionFlag.Warning;
      default:
        throw Exception("Unknown transaction flag - $text");
    }
  }
}

extension Metadaata_valueParsing on Metadata_valueContext {
  MetaValue val() {
    if (NUMBER() != null) {
      return MetaValue(numberValue: Decimal.parse(NUMBER()!.text!));
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

    throw Exception("Couldn't parse metadata value");
  }
}

extension MetadaataParsing on MetadataContext {
  Map<String, MetaValue> val() {
    var m = <String, MetaValue>{};

    var keys = metadata_keys();
    var values = metadata_values();

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

extension TransactionParsing on TrStatementContext {
  Transaction val() {
    var header = tr_header()!;

    return Transaction(
      header.date()!.val(),
      header.tr_flag()!.val(),
      header.narration!.val(),
      payee: header.payee?.val(),
      tags: header.tags()?.val(),
      postings: children!
          .map((c) {
            if (c is Posting_spec_account_onlyContext) return c.val();
            if (c is Posting_spec_account_amountContext) return c.val();
            if (c is Posting_spec_with_costContext) return c.val();

            return null;
          })
          .where((x) => x != null)
          .map((e) => e!),
      comments: tr_comments().map((e) => e.val()),
      meta: metadata()?.val(),
    );
  }
}

extension DirectiveParsing on DirectiveContext {
  Directive val() {
    if (balanceStatement() != null) return balanceStatement()!.val();
    if (closeStatement() != null) return closeStatement()!.val();
    if (openStatement() != null) return openStatement()!.val();
    if (priceStatement() != null) return priceStatement()!.val();
    if (commodityStatement() != null) return commodityStatement()!.val();
    if (documentStatement() != null) return documentStatement()!.val();
    if (eventStatement() != null) return eventStatement()!.val();
    if (noteStatement() != null) return noteStatement()!.val();
    if (trStatement() != null) return trStatement()!.val();

    throw Exception("Unknown Directive");
  }
}

extension CommentStatementParsing on CommentStatementContext {
  Comment val() {
    assert(childCount > 1);
    return Comment(children![1].text!);
  }
}

extension OptionStatementParsing on OptionStatementContext {
  Option val() => Option(key!.val(), value!.val());
}

extension IncludeStatementParsing on IncludeStatementContext {
  Include val() => Include(quoted_string()!.val());
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

    throw Exception("Unknown Statement");
  }
}

extension AllParsing on AllContext {
  Iterable<Statement> val() {
    return statements().map((s) => s.val());
  }
}

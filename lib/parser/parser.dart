import 'package:decimal/decimal.dart';
import 'package:gringotts/core/account.dart';
import 'package:gringotts/core/balance.dart';
import 'package:gringotts/core/close.dart';
import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/document.dart';
import 'package:gringotts/core/event.dart';
import 'package:gringotts/core/note.dart';
import 'package:gringotts/core/open.dart';
import 'package:gringotts/core/posting.dart';
import 'package:gringotts/core/price.dart';
import 'package:gringotts/core/statements.dart';
import 'package:gringotts/core/transaction.dart';

import 'package:gringotts/parser/GringottsLexer.dart';
import 'package:gringotts/parser/GringottsParser.dart';
import 'package:antlr4/antlr4.dart';

GringottsParser parse(String text) {
  if (!text.endsWith('\n')) text += '\n';
  final inputStream = InputStream.fromString(text);
  final lexer = GringottsLexer(inputStream);
  final tokens = CommonTokenStream(lexer);
  final parser = GringottsParser(tokens);
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
  Account val() => Account(WORDs().join(':'));
}

extension PriceParsing on PriceStatementContext {
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

extension CostParsing on CostContext {
  Cost val() {
    var amt = amount()!.val();
    return Cost(amt.number, amt.currency, null);
  }
}

extension PostingSpecExplicitPerCostParsing
    on Posting_spec_explicit_per_costContext {
  Posting val() {
    return Posting(
      account()!.val(),
      amount()!.val(),
      cost: cost()!.val(),
      comment: inline_comment()?.val(),
      tags: tags()?.val(),
    );
  }
}

extension TrCommentParsing on Tr_commentContext {
  String val() => inline_comment()!.val();
}

extension TransactionParsing on TrStatementContext {
  Transaction val() {
    var header = tr_header()!;
    var flag = TransactionFlag(header.TR_FLAG()!.text!);

    return Transaction(
      header.date()!.val(),
      flag,
      header.narration!.val(),
      payee: header.payee?.val(),
      tags: header.tags()?.val(),
      postings: children!
          .where((c) =>
              c is Posting_spec_account_onlyContext ||
              c is Posting_spec_account_amountContext ||
              c is Posting_spec_explicit_per_costContext)
          .map((c) {
        if (c is Posting_spec_account_onlyContext) return c.val();
        if (c is Posting_spec_account_amountContext) return c.val();
        if (c is Posting_spec_explicit_per_costContext) return c.val();
        throw new Exception("Unknown Posting Type??");
      }),
      comments: tr_comments().map((e) => e.val()),
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

    throw new Exception("Unknown Directive");
  }
}

extension CommentStatementParsing on CommentStatementContext {
  Comment val() {
    return Comment(text.substring(1, text.length - 1));
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

    throw new Exception("Unknown Statement");
  }
}

extension AllParsing on AllContext {
  Iterable<Statement> val() {
    return statements().map((s) => s.val());
  }
}

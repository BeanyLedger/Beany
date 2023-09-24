import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
import 'package:beany/core/balance_statement.dart';
import 'package:beany/core/close_statement.dart';
import 'package:beany/core/commodity_statement.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/cost_spec.dart';
import 'package:beany/core/custom_statement.dart';
import 'package:beany/core/document_statement.dart';
import 'package:beany/core/event_statement.dart';
import 'package:beany/core/note_statement.dart';
import 'package:beany/core/open_statement.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/price_spec.dart';
import 'package:beany/core/price_statement.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/render/prettier.dart';
import 'package:decimal/decimal.dart';
import 'package:quiver/iterables.dart';
import 'package:collection/collection.dart';

abstract class RendererInterface {
  void renderAmountSpec(StringSink sink, AmountSpec amountSpec);
  void renderAccount(StringSink sink, Account account);

  void renderCostSpec(StringSink sink, CostSpec costSpec);
  void renderPriceSpec(StringSink sink, PriceSpec priceSpec);
  void renderPostingSpec(
      StringSink sink, PostingSpec posting, TransactionSpec? tr);
  void renderTransactionSpec(StringSink sink, TransactionSpec transaction);

  void renderPriceDirective(StringSink sink, PriceStatement price);
  void renderOpenDirective(StringSink sink, OpenStatement open);
  void renderCloseDirective(StringSink sink, CloseStatement close);
  void renderNoteDirective(StringSink sink, NoteStatement note);
  void renderDocumentDirective(StringSink sink, DocumentStatement document);
  void renderEventDirective(StringSink sink, EventStatement event);
  void renderBalanceDirective(StringSink sink, BalanceStatement balance);
  void renderCommodityDirective(StringSink sink, CommodityStatement commodity);
  void renderCustomDirective(StringSink sink, CustomStatement custom);

  void renderIncludeStatement(StringSink sink, IncludeStatement include);
  void renderOptionStatement(StringSink sink, OptionStatement option);
  void renderCommentStatement(StringSink sink, CommentStatement comment);
}

class DisplayContext {
  final sb = StringBuffer();
}

String renderNumber(Decimal d) {
  if (d.scale < 2) return d.toStringAsFixed(2);
  return d.toString();
}

const _tab = "  ";

String render(Statement st) {
  var sb = StringBuffer();
  var renderer = BeancountRenderer();
  renderer.renderStatement(sb, st);
  return sb.toString();
}

String renderPretty(Iterable<Statement> statements) {
  return statements.map((st) {
    if (st is Transaction) return render(st.pretty());
    return render(st);
  }).join("\n");
}

String renderPosting(PostingSpec p) {
  var sb = StringBuffer();
  var renderer = BeancountRenderer();
  renderer.renderPostingSpec(sb, p, null);
  return sb.toString();
}

class BeancountRenderer implements RendererInterface {
  void renderStatement(StringSink sink, Statement st) {
    if (st is OpenStatement) {
      renderOpenDirective(sink, st);
    } else if (st is CloseStatement) {
      renderCloseDirective(sink, st);
    } else if (st is NoteStatement) {
      renderNoteDirective(sink, st);
    } else if (st is DocumentStatement) {
      renderDocumentDirective(sink, st);
    } else if (st is EventStatement) {
      renderEventDirective(sink, st);
    } else if (st is BalanceStatement) {
      renderBalanceDirective(sink, st);
    } else if (st is CommodityStatement) {
      renderCommodityDirective(sink, st);
    } else if (st is CustomStatement) {
      renderCustomDirective(sink, st);
    } else if (st is PriceStatement) {
      renderPriceDirective(sink, st);
    } else if (st is TransactionSpec) {
      renderTransactionSpec(sink, st);
    } else if (st is IncludeStatement) {
      renderIncludeStatement(sink, st);
    } else if (st is OptionStatement) {
      renderOptionStatement(sink, st);
    } else if (st is CommentStatement) {
      renderCommentStatement(sink, st);
    } else {
      throw Exception("Unknown statement type: ${st.runtimeType}");
    }
  }

  @override
  void renderAccount(StringSink sink, Account account) {
    sink.write(account.value);
  }

  @override
  void renderAmountSpec(StringSink sink, AmountSpec amountSpec) {
    if (amountSpec.number != null) {
      sink.write(renderNumber(amountSpec.number!));
    }
    if (amountSpec.currency != null) {
      if (amountSpec.number != null) sink.write(' ');
      sink.write(amountSpec.currency);
    }
  }

  @override
  void renderCostSpec(StringSink sink, CostSpec costSpec) {
    var per = costSpec.amountPer != null;
    sink.write(per ? '{' : '{{');
    renderAmountSpec(sink, per ? costSpec.amountPer! : costSpec.amountTotal!);
    if (costSpec.date != null) {
      sink.write(', ');
      sink.write(costSpec.date!.toIso8601String().substring(0, 10));
    }
    if (costSpec.label != null) {
      sink.write(', ');
      sink.write('"${costSpec.label}"');
    }
    sink.write(per ? '}' : '}}');
  }

  @override
  void renderPriceSpec(StringSink sink, PriceSpec priceSpec) {
    if (priceSpec.amountPer != null) {
      sink.write('@ ');
      renderAmountSpec(sink, priceSpec.amountPer!);
    }
    if (priceSpec.amountTotal != null) {
      sink.write('@@ ');
      renderAmountSpec(sink, priceSpec.amountTotal!);
    }
  }

  @override
  void renderPostingSpec(
    StringSink sink,
    PostingSpec posting,
    TransactionSpec? tr,
  ) {
    for (var comment in posting.preComments) {
      sink.write(_tab);
      sink.write('; ');
      sink.writeln(comment);
    }

    sink.write(_tab);
    if (posting.amount == null) {
      renderAccount(sink, posting.account);
    } else {
      renderAccount(sink, posting.account);
      sink.write(_accountPadRight(tr, posting));
      sink.write(_amountPadLeft(tr, posting.amount!));
      renderAmountSpec(sink, posting.amount!);
    }

    if (posting.costSpec != null) {
      sink.write(' ');
      renderCostSpec(sink, posting.costSpec!);
    }
    if (posting.priceSpec != null) {
      sink.write(' ');
      renderPriceSpec(sink, posting.priceSpec!);
    }

    for (var tag in posting.tags) {
      sink.write(' #');
      sink.write(tag);
    }
    if (posting.comment != null && posting.comment!.isNotEmpty) {
      sink.write(' ; ');
      sink.write(posting.comment);
    }
  }

  @override
  void renderTransactionSpec(StringSink sink, TransactionSpec tr) {
    sink.write(tr.date.toIso8601String().substring(0, 10));
    sink.write(' ${tr.flag} ');
    sink.write('"${tr.narration}"');
    if (tr.payee != null) {
      sink.write(' "${tr.payee}"');
    }
    if (tr.tags.isNotEmpty) {
      sink.write(' ');
      sink.write(tr.tags.map((t) => '#$t').join(' '));
    }
    sink.writeln();

    if (tr.meta.isNotEmpty) {
      for (var m in tr.meta.entries) {
        sink.write(_tab);
        sink.writeln('${m.key}: ${m.value}');
      }
    }

    if (tr.postings.isNotEmpty) {
      for (var posting in tr.postings) {
        renderPostingSpec(sink, posting, tr);
        sink.writeln();
      }
    }
  }

  @override
  void renderBalanceDirective(StringSink sink, BalanceStatement balance) {
    sink.write(balance.date.toIso8601String().substring(0, 10));
    sink.write(' balance ');
    renderAccount(sink, balance.account);
    sink.write('  ');
    renderAmountSpec(sink, balance.amount);
    sink.writeln();
  }

  @override
  void renderOpenDirective(StringSink sink, OpenStatement open) {
    sink.write(open.date.toIso8601String().substring(0, 10));
    sink.write(' open ');
    renderAccount(sink, open.account);
    sink.writeln();
  }

  @override
  void renderCloseDirective(StringSink sink, CloseStatement close) {
    sink.write(close.date.toIso8601String().substring(0, 10));
    sink.write(' close ');
    renderAccount(sink, close.account);
    sink.writeln();
  }

  @override
  void renderCommodityDirective(StringSink sink, CommodityStatement st) {
    sink.write(st.date.toIso8601String().substring(0, 10));
    sink.write(' commodity ');
    sink.write(st.commodity);
    sink.writeln();
  }

  @override
  void renderDocumentDirective(StringSink sink, DocumentStatement st) {
    sink.write(st.date.toIso8601String().substring(0, 10));
    sink.write(' document ');
    renderAccount(sink, st.account);
    sink.write(' "${st.path}"');
    sink.writeln();
  }

  @override
  void renderEventDirective(StringSink sink, EventStatement st) {
    sink.write(st.date.toIso8601String().substring(0, 10));
    sink.write(' event "${st.type}" "${st.value}"');
    sink.writeln();
  }

  @override
  void renderNoteDirective(StringSink sink, NoteStatement st) {
    sink.write(st.date.toIso8601String().substring(0, 10));
    sink.write(' note ');
    renderAccount(sink, st.account);
    sink.write(' "${st.comment}"');
    sink.writeln();
  }

  @override
  void renderPriceDirective(StringSink sink, PriceStatement st) {
    sink.write(st.date.toIso8601String().substring(0, 10));
    sink.write(' price ');
    sink.write(st.currency);
    sink.write('  ');
    renderAmountSpec(sink, st.amount);
    sink.writeln();
  }

  @override
  void renderCustomDirective(StringSink sink, CustomStatement st) {
    sink.write(st.date.toIso8601String().substring(0, 10));
    sink.write(' custom');
    for (var value in st.values) {
      sink.write(' "$value"');
    }
    sink.writeln();
  }

  @override
  void renderIncludeStatement(StringSink sink, IncludeStatement include) {
    sink.write('include "${include.path}"');
    sink.writeln();
  }

  @override
  void renderCommentStatement(StringSink sink, CommentStatement comment) {
    sink.write('; ${comment.value}');
    sink.writeln();
  }

  @override
  void renderOptionStatement(StringSink sink, OptionStatement option) {
    sink.write('option "${option.key}" "${option.value}"');
    sink.writeln();
  }
}

String _accountPadRight(TransactionSpec? tr, PostingSpec posting) {
  var minSpacing = 2;
  if (tr == null) return "".padRight(minSpacing);

  var accountLengths = (tr.postings.map((e) => e.account.value.length));
  var maxAccountLength = max<int>(accountLengths) ?? 0;

  if (maxAccountLength == 0) {
    return "".padRight(minSpacing);
  }

  var accountDiff = maxAccountLength - posting.account.value.length;
  return "".padRight(accountDiff + minSpacing);
}

String _amountPadLeft(TransactionSpec? tr, AmountSpec amount) {
  if (tr == null) return "";

  var num = amount.number;
  if (num == null) return "";

  var numbers = tr.postings.map((e) => e.amount?.number).whereNotNull();
  var numberLengths = numbers.map((n) => renderNumber(n).length);
  var maxNumberLength = max<int>(numberLengths) ?? 0;

  var isPositive = num.signum >= 0;
  var allPositive = numbers.every((n) => n.signum >= 0);
  var spacingForMinusSign = allPositive ? 0 : 1;

  var diff = maxNumberLength - (renderNumber(num).length + 1);
  return isPositive ? "".padLeft(diff + spacingForMinusSign) : "".padLeft(diff);
}

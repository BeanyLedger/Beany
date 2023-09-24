test:
	cd core && dart test

parser:
	cd core/lib/parser && antlr -Werror -Dlanguage=Dart Beancount.g4 -o .
	dart format --fix core/lib/parser

clean:
	rm -rf core/lib/parser/Beancount.interp core/lib/parser/Beancount.tokens core/lib/parser/BeancountLexer.dart core/lib/parser/BeancountLexer.tokens core/lib/parser/BeancountParser.dart core/lib/parser/BeancountBaseListener.dart core/lib/parser/BeancountListener.dart core/lib/parser/BeancountBaseVisitor.dart core/lib/parser/BeancountVisitor.dart

.PHONY: list test
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
help: list

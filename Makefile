test:
	dart test

parser:
	cd lib/parser && antlr -Werror -Dlanguage=Dart Beancount.g4 -o .
	dart format --fix lib/parser

clean:
	rm -rf lib/parser/Beancount.interp lib/parser/Beancount.tokens lib/parser/BeancountLexer.dart lib/parser/BeancountLexer.tokens lib/parser/BeancountParser.dart lib/parser/BeancountBaseListener.dart lib/parser/BeancountListener.dart lib/parser/BeancountBaseVisitor.dart lib/parser/BeancountVisitor.dart

.PHONY: list test
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
help: list

test:
	dart test

antlr:
	cd lib/parser && antlr -Werror -Dlanguage=Dart Beancount.g4 -o .
	dart format --fix lib/parser

.PHONY: list test
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
help: list

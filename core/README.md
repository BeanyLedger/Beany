
## Limitations

1. Beancount silently ignores lines it does not understand, Beany does not yet do this, and will abort.
   https://beancount.github.io/docs/beancount_language_syntax.html#comments

2. It's currently only handles Metadata for transactions, and fails for any other kind of statement.

3. Probably things relating to Cost Specs

4. Resolving Postings might fail in some cases, especially those with specific precision requirements.

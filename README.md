# Gringotts

The parser has been derived from exclusively looking at the [documentation](https://github.com/beancount/docs) which is MIT licensed.

- The developer experience matters
  - How easy it is to install?
  - Where can I find the documentation?
  - Clear examples
  - Cheat sheets
  - How to easily extend it?
    - How to install Dart?
    - How to write a custom script?
    - How to render a custom widget?
      - Flutter
      - React
      - Normal HTML
    - How to use it with another system?
      - Excel sheets?
      - Command line tools - jq, csv, awk
    - How to use this with Python?
      - Pandas
    - How to use this with Javascript?
    - GoLang?
    - Rust?
    - R?
    - Julia?
  - How to diagnose an error?
  - How to report a bug? And provide all the required information?
  - How to figure out Beancount incompatibility?

  - How easy is it to contribute changes?
  - VS Code integration
    - Via an LSP
      - Actions to rename an account
      - Fix mispelled accounts
      - Add an action to add an account
  - Linter
    - Open accounts at the start of the financial year
    - Or just before they are used
  - How to integrate it with GNU Plot?

- How to migrate?
  - From YNAB?
  - From HLedger?
  - From Ledger?
  - From GNU Cash?

- How to get started
  - Spanish accounts
  - EU accounts

- More info
  - Beancount
  - Plain Text Accounting

## Misc

* Mark every transaction with a unique ID
  - Either derived from the CSV
  - or the sha1 hash of the input csv line which caused it

## Why start another project?

- Beancount is GPL licensed - so shipping it on Apply devices is impossible
- It's written in Python which isn't very portable for the Web / Mobile apps.

# Beany

The parser has been derived from exclusively looking at the [documentation](https://github.com/beancount/docs) which is MIT licensed.

  - How to figure out Beancount incompatibility?

## Misc

* Mark every transaction with a unique ID
  - Either derived from the CSV
  - or the sha1 hash of the input csv line which caused it

## Why start another project?

- Beancount is GPL licensed - so shipping it on Apply devices is impossible
- It's written in Python which isn't very portable for the Web / Mobile apps.

import 'dart:collection';

import 'package:beany_core/core/account.dart';
import 'package:collection/collection.dart';

class AccountsTree<T> {
  final _Node<T> _root;
  final T defaultValue;

  AccountsTree.empty(T defaultValue)
      : _root = _Node(),
        defaultValue = defaultValue;

  AccountsTree(Iterable<Account> iterable, T val)
      : _root = _Node(),
        defaultValue = val {
    for (var account in iterable) {
      addAccount(account, val);
    }
  }

  AccountsTree._internal(this._root, this.defaultValue);

  // Does not contain the account itself
  AccountsTree<T>? subTree(Account account) {
    final node = find(account);
    if (node == null) return null;

    return AccountsTree<T>._internal(node, defaultValue);
  }

  void addAccount(Account account, T val, {bool overwrite = false}) {
    final parts = account.parts();

    var parent = _root;
    for (var i = 0; i < parts.length; i++) {
      var part = parts[i];
      var atDestination = i == parts.length - 1;

      final child = parent.children.firstWhereOrNull(
        (e) => e.accountPart == part,
      );
      if (child == null) {
        final newChild = AccountNode._(
          accountPart: part,
          parent: parent,
          val: atDestination ? val : defaultValue,
        );

        // Insert so that the children are sorted
        var inserted = false;
        for (var i = 0; i < parent.children.length; i++) {
          var comp = part.compareTo(parent.children[i].accountPart);
          if (comp == 0) {
            if (overwrite) {
              parent.children[i].val = val;
            } else {
              throw ArgumentError('Account already exists: $account');
            }
          }
          if (comp < 0) {
            parent.children.insert(i, newChild);
            inserted = true;
            break;
          }
        }
        if (!inserted) parent.children.add(newChild);

        parent = newChild;
      } else {
        parent = child;
        if (atDestination) {
          if (overwrite || child.val == defaultValue) {
            child.val = val;
          } else {
            throw ArgumentError('Account already exists: $account');
          }
        }
      }
    }
  }

  AccountNode<T>? find(Account account) {
    final parts = account.parts();

    _Node<T> parent = _root;
    for (var part in parts) {
      final child = parent.children.firstWhereOrNull(
        (e) => e.accountPart == part,
      );
      if (child == null) return null;

      parent = child;
    }

    return parent as AccountNode<T>;
  }

  Iterable<AccountNode<T>> iterBfs() sync* {
    final stack = Queue<_Node>();
    stack.add(_root);

    while (stack.isNotEmpty) {
      final node = stack.removeFirst();

      stack.addAll(node.children);
      if (node is AccountNode<T>) {
        yield node;
      }
    }
  }

  Iterable<AccountNode<T>> iterDfs() sync* {
    final stack = ListQueue<_Node>();
    stack.add(_root);

    while (stack.isNotEmpty) {
      final node = stack.removeLast();

      stack.addAll(node.children.reversed);
      if (node is AccountNode<T>) {
        yield node;
      }
    }
  }

  // Goes for the lowest depth first
  Iterable<AccountNode<T>> iterByDepth() sync* {
    var values = <int, List<AccountNode<T>>>{};

    for (var node in iterBfs()) {
      values.putIfAbsent(node.depth, () => []).add(node);
    }

    for (var i = values.length; i > 0; i--) {
      for (var node in values[i]!) {
        yield node;
      }
    }
  }
}

class _Node<T> {
  final List<AccountNode<T>> children = [];
  bool get isRoot => true;
}

class AccountNode<T> implements _Node<T> {
  final String accountPart;
  final _Node _parent;
  final int depth;

  T val;

  @override
  List<AccountNode<T>> children = [];

  AccountNode._({
    required this.accountPart,
    required _Node<T> parent,
    required this.val,
  })  : depth = parent is AccountNode<T> ? parent.depth + 1 : 1,
        _parent = parent;

  bool get isLeaf => children.isEmpty;

  Account account() {
    final parts = <String>[];
    var node = this;
    while (true) {
      parts.add(node.accountPart);
      if (node._parent.isRoot) break;
      node = node._parent as AccountNode<T>;
    }

    return Account(parts.reversed.join(':'));
  }

  @override
  bool get isRoot => false;

  @override
  String toString() {
    return "AccountNode($accountPart, $children, $val)";
  }

  AccountNode<T>? get parent => _parent is AccountNode<T> ? _parent : null;
}

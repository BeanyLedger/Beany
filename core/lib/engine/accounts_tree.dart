import 'dart:collection';

import 'package:beany_core/core/account.dart';
import 'package:collection/collection.dart';

class AccountsTree {
  final _Node _root;

  AccountsTree(Iterable<Account> iterable) : _root = _Node() {
    for (var account in iterable) {
      _addAccount(account);
    }
  }

  AccountsTree._internal(this._root);

  // Does not contain the account itself
  AccountsTree? subTree(Account account) {
    final node = _find(account);
    if (node == null) return null;

    return AccountsTree._internal(node);
  }

  void _addAccount(Account account) {
    final parts = account.parts();

    _Node parent = _root;
    for (var part in parts) {
      final child = parent.children.firstWhereOrNull((e) => e.val == part);
      if (child == null) {
        final newChild = AccountNode(val: part, parent: parent);

        // Insert so that the children are sorted
        var inserted = false;
        for (var i = 0; i < parent.children.length; i++) {
          if (part.compareTo(parent.children[i].val) < 0) {
            parent.children.insert(i, newChild);
            inserted = true;
            break;
          }
        }
        if (!inserted) parent.children.add(newChild);

        parent = newChild;
      } else {
        parent = child;
      }
    }
  }

  AccountNode? _find(Account account) {
    final parts = account.parts();

    _Node parent = _root;
    for (var part in parts) {
      final child = parent.children.firstWhereOrNull((e) => e.val == part);
      if (child == null) return null;

      parent = child;
    }

    return parent as AccountNode;
  }

  Iterable<AccountNode> iterBfs() sync* {
    final stack = Queue<_Node>();
    stack.add(_root);

    while (stack.isNotEmpty) {
      final node = stack.removeFirst();

      stack.addAll(node.children);
      if (node is AccountNode) {
        yield node;
      }
    }
  }

  Iterable<AccountNode> iterDfs() sync* {
    final stack = ListQueue<_Node>();
    stack.add(_root);

    while (stack.isNotEmpty) {
      final node = stack.removeLast();

      stack.addAll(node.children.reversed);
      if (node is AccountNode) {
        yield node;
      }
    }
  }

  // Goes for the lowest depth first
  Iterable<AccountNode> iterByDepth() sync* {
    var values = <int, List<AccountNode>>{};

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

class _Node {
  final List<AccountNode> children = [];
  bool get isRoot => true;
}

class AccountNode implements _Node {
  final String val;
  final _Node parent;
  final int depth;

  @override
  List<AccountNode> children = [];

  AccountNode({
    required this.val,
    required this.parent,
  }) : depth = parent is AccountNode ? parent.depth + 1 : 1;

  bool get isLeaf => children.isEmpty;

  Account account() {
    final parts = <String>[];
    var node = this;
    while (true) {
      parts.add(node.val);
      if (node.parent.isRoot) break;
      node = node.parent as AccountNode;
    }

    return Account(parts.reversed.join(':'));
  }

  @override
  bool get isRoot => false;

  @override
  String toString() {
    return "AccountNode($val, $children)";
  }
}

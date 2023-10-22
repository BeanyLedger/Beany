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
        final newChild = _AccountNode(val: part, parent: parent);

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

  _AccountNode? _find(Account account) {
    final parts = account.parts();

    _Node parent = _root;
    for (var part in parts) {
      final child = parent.children.firstWhereOrNull((e) => e.val == part);
      if (child == null) return null;

      parent = child;
    }

    return parent as _AccountNode;
  }

  Iterable<Account> iterBfs() {
    return _iterBfs().map((e) => e.account());
  }

  Iterable<_AccountNode> _iterBfs() sync* {
    final stack = Queue<_Node>();
    stack.add(_root);

    while (stack.isNotEmpty) {
      final node = stack.removeFirst();

      stack.addAll(node.children);
      if (node is _AccountNode) {
        yield node;
      }
    }
  }

  Iterable<Account> iterDfs() sync* {
    final stack = ListQueue<_Node>();
    stack.add(_root);

    while (stack.isNotEmpty) {
      final node = stack.removeLast();

      stack.addAll(node.children.reversed);
      if (node is _AccountNode) {
        yield node.account();
      }
    }
  }

  // Goes for the lowest depth first
  Iterable<Account> iterByDepth() sync* {
    var values = <int, List<_AccountNode>>{};

    for (var node in _iterBfs()) {
      values.putIfAbsent(node.depth, () => []).add(node);
    }

    for (var i = values.length; i > 0; i--) {
      for (var node in values[i]!) {
        yield node.account();
      }
    }
  }
}

class _Node {
  final List<_AccountNode> children = [];
  bool get isRoot => true;
}

class _AccountNode implements _Node {
  final String val;
  final _Node parent;

  @override
  List<_AccountNode> children = [];

  _AccountNode({
    required this.val,
    required this.parent,
  });

  bool get isLeaf => children.isEmpty;

  Account account() {
    final parts = <String>[];
    var node = this;
    while (true) {
      parts.add(node.val);
      if (node.parent.isRoot) break;
      node = node.parent as _AccountNode;
    }

    return Account(parts.reversed.join(':'));
  }

  @override
  bool get isRoot => false;

  @override
  String toString() {
    return "AccountNode($val, $children)";
  }

  // FIXME: This can probably be memorized
  int get depth {
    if (parent is _AccountNode) return (parent as _AccountNode).depth + 1;
    return 1;
  }
}

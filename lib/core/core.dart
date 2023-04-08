import 'package:fast_immutable_collections/fast_immutable_collections.dart';

abstract class Statement {}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}

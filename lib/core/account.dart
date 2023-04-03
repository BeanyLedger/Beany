import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Account extends Equatable {
  final String value;
  Account(this.value);

  String toString() {
    return value;
  }

  @override
  List<Object?> get props => [value];
}

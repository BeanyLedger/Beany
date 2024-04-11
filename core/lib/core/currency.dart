import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'currency.g.dart';

@immutable
@JsonSerializable()
class Currency extends Equatable {
  final String value;

  Currency(this.value);

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

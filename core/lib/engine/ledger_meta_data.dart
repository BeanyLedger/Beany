import 'package:beany_core/core/account.dart';
import 'package:beany_core/misc/date.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'ledger_meta_data.g.dart';

@immutable
@JsonSerializable()
class LedgerMetaData {
  final Date? earliestDate;
  final Date? latestDate;

  final IList<String> files;
  final IList<Account> accounts;

  LedgerMetaData({
    required this.earliestDate,
    required this.latestDate,
    required this.files,
    required this.accounts,
  });

  factory LedgerMetaData.fromJson(Map<String, dynamic> json) =>
      _$LedgerMetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$LedgerMetaDataToJson(this);
}

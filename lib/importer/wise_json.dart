// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Welcome {
  Welcome({
    required this.accountHolder,
    // required this.issuer,
    required this.transactions,
    // required this.startOfStatementBalance,
    // required this.endOfStatementBalance,
    this.endOfStatementUnrealisedGainLoss,
    this.balanceAssetConfiguration,
    required this.query,
    // required this.request,
  });

  final AccountHolder accountHolder;
  // final Issuer issuer;
  final List<WiseTransaction> transactions;
  // final EndOfStatementBalance startOfStatementBalance;
  // final EndOfStatementBalance endOfStatementBalance;
  final dynamic endOfStatementUnrealisedGainLoss;
  final dynamic balanceAssetConfiguration;
  final Query query;
  // final Request request;

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        accountHolder: AccountHolder.fromJson(json["accountHolder"]),
        // issuer: Issuer.fromJson(json["issuer"]),
        transactions: List<WiseTransaction>.from(
            json["transactions"].map((x) => WiseTransaction.fromJson(x))),
        // startOfStatementBalance:
        // EndOfStatementBalance.fromJson(json["startOfStatementBalance"]),
        // endOfStatementBalance:
        // EndOfStatementBalance.fromJson(json["endOfStatementBalance"]),
        endOfStatementUnrealisedGainLoss:
            json["endOfStatementUnrealisedGainLoss"],
        balanceAssetConfiguration: json["balanceAssetConfiguration"],
        query: Query.fromJson(json["query"]),
        // request: Request.fromJson(json["request"]),
      );

  Map<String, dynamic> toJson() => {
        "accountHolder": accountHolder.toJson(),
        // "issuer": issuer.toJson(),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
        // "startOfStatementBalance": startOfStatementBalance.toJson(),
        // "endOfStatementBalance": endOfStatementBalance.toJson(),
        "endOfStatementUnrealisedGainLoss": endOfStatementUnrealisedGainLoss,
        "balanceAssetConfiguration": balanceAssetConfiguration,
        "query": query.toJson(),
        // "request": request.toJson(),
      };
}

class AccountHolder {
  AccountHolder({
    required this.type,
    required this.address,
    required this.firstName,
    required this.lastName,
  });

  final String type;
  final AccountHolderAddress address;
  final String firstName;
  final String lastName;

  factory AccountHolder.fromRawJson(String str) =>
      AccountHolder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountHolder.fromJson(Map<String, dynamic> json) => AccountHolder(
        type: json["type"],
        address: AccountHolderAddress.fromJson(json["address"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "address": address.toJson(),
        "firstName": firstName,
        "lastName": lastName,
      };
}

class AccountHolderAddress {
  AccountHolderAddress({
    required this.addressFirstLine,
    required this.city,
    required this.postCode,
    this.stateCode,
    required this.countryName,
  });

  final String addressFirstLine;
  final String city;
  final String postCode;
  final dynamic stateCode;
  final String countryName;

  factory AccountHolderAddress.fromRawJson(String str) =>
      AccountHolderAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountHolderAddress.fromJson(Map<String, dynamic> json) =>
      AccountHolderAddress(
        addressFirstLine: json["addressFirstLine"],
        city: json["city"],
        postCode: json["postCode"],
        stateCode: json["stateCode"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toJson() => {
        "addressFirstLine": addressFirstLine,
        "city": city,
        "postCode": postCode,
        "stateCode": stateCode,
        "countryName": countryName,
      };
}

class BankDetail {
  BankDetail({
    required this.address,
    required this.accountNumbers,
    required this.bankCodes,
    required this.deprecated,
  });

  final BankDetailAddress address;
  final List<AccountNumber> accountNumbers;
  final List<BankCode> bankCodes;
  final bool deprecated;

  factory BankDetail.fromRawJson(String str) =>
      BankDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
        address: BankDetailAddress.fromJson(json["address"]),
        accountNumbers: List<AccountNumber>.from(
            json["accountNumbers"].map((x) => AccountNumber.fromJson(x))),
        bankCodes: List<BankCode>.from(
            json["bankCodes"].map((x) => BankCode.fromJson(x))),
        deprecated: json["deprecated"],
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "accountNumbers":
            List<dynamic>.from(accountNumbers.map((x) => x.toJson())),
        "bankCodes": List<dynamic>.from(bankCodes.map((x) => x.toJson())),
        "deprecated": deprecated,
      };
}

class AccountNumber {
  AccountNumber({
    required this.accountType,
    required this.accountNumber,
  });

  final String accountType;
  final String accountNumber;

  factory AccountNumber.fromRawJson(String str) =>
      AccountNumber.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountNumber.fromJson(Map<String, dynamic> json) => AccountNumber(
        accountType: json["accountType"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "accountType": accountType,
        "accountNumber": accountNumber,
      };
}

class BankDetailAddress {
  BankDetailAddress({
    required this.firstLine,
    required this.secondLine,
    required this.postCode,
    required this.stateCode,
    required this.city,
    required this.country,
  });

  final String firstLine;
  final String secondLine;
  final String postCode;
  final String stateCode;
  final String city;
  final String country;

  factory BankDetailAddress.fromRawJson(String str) =>
      BankDetailAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankDetailAddress.fromJson(Map<String, dynamic> json) =>
      BankDetailAddress(
        firstLine: json["firstLine"],
        secondLine: json["secondLine"],
        postCode: json["postCode"],
        stateCode: json["stateCode"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "firstLine": firstLine,
        "secondLine": secondLine,
        "postCode": postCode,
        "stateCode": stateCode,
        "city": city,
        "country": country,
      };
}

class BankCode {
  BankCode({
    required this.scheme,
    required this.value,
  });

  final String scheme;
  final String value;

  factory BankCode.fromRawJson(String str) =>
      BankCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankCode.fromJson(Map<String, dynamic> json) => BankCode(
        scheme: json["scheme"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "scheme": scheme,
        "value": value,
      };
}

class EndOfStatementBalance {
  EndOfStatementBalance({
    required this.value,
    required this.currency,
    // required this.zero,
  });

  final double value;
  final String currency;
  // final bool zero;

  factory EndOfStatementBalance.fromRawJson(String str) =>
      EndOfStatementBalance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EndOfStatementBalance.fromJson(Map<String, dynamic> json) =>
      EndOfStatementBalance(
        value: json["value"]?.toDouble(),
        currency: json["currency"],
        // zero: json["zero"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
        // "zero": zero,
      };
}

class Issuer {
  Issuer({
    required this.name,
    required this.firstLine,
    required this.city,
    required this.postCode,
    this.stateCode,
    required this.countryCode,
    required this.country,
  });

  final String name;
  final String firstLine;
  final String city;
  final String postCode;
  final dynamic stateCode;
  final String countryCode;
  final String country;

  factory Issuer.fromRawJson(String str) => Issuer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        name: json["name"],
        firstLine: json["firstLine"],
        city: json["city"],
        postCode: json["postCode"],
        stateCode: json["stateCode"],
        countryCode: json["countryCode"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "firstLine": firstLine,
        "city": city,
        "postCode": postCode,
        "stateCode": stateCode,
        "countryCode": countryCode,
        "country": country,
      };
}

class Query {
  Query({
    required this.intervalStart,
    required this.intervalEnd,
    // required this.type,
    required this.addStamp,
    required this.currency,
    // required this.profileId,
    required this.timezone,
  });

  final DateTime intervalStart;
  final DateTime intervalEnd;
  // final String type;
  final bool addStamp;
  final String currency;
  // final int profileId;
  final String timezone;

  factory Query.fromRawJson(String str) => Query.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        intervalStart: DateTime.parse(json["intervalStart"]),
        intervalEnd: DateTime.parse(json["intervalEnd"]),
        // type: json["type"],
        addStamp: json["addStamp"] ?? false,
        currency: json["currency"],
        // profileId: json["profileId"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "intervalStart": intervalStart.toIso8601String(),
        "intervalEnd": intervalEnd.toIso8601String(),
        // "type": type,
        "addStamp": addStamp,
        "currency": currency,
        // "profileId": profileId,
        "timezone": timezone,
      };
}

class Request {
  Request({
    required this.id,
    required this.creationTime,
    required this.profileId,
    required this.currency,
    required this.balanceId,
    this.balanceName,
    required this.intervalStart,
    required this.intervalEnd,
  });

  final String id;
  final DateTime creationTime;
  final int profileId;
  final String currency;
  final int balanceId;
  final dynamic balanceName;
  final DateTime intervalStart;
  final DateTime intervalEnd;

  factory Request.fromRawJson(String str) => Request.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        creationTime: DateTime.parse(json["creationTime"]),
        profileId: json["profileId"],
        currency: json["currency"],
        balanceId: json["balanceId"],
        balanceName: json["balanceName"],
        intervalStart: DateTime.parse(json["intervalStart"]),
        intervalEnd: DateTime.parse(json["intervalEnd"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "creationTime": creationTime.toIso8601String(),
        "profileId": profileId,
        "currency": currency,
        "balanceId": balanceId,
        "balanceName": balanceName,
        "intervalStart": intervalStart.toIso8601String(),
        "intervalEnd": intervalEnd.toIso8601String(),
      };
}

class WiseTransaction {
  WiseTransaction({
    required this.type,
    required this.date,
    required this.amount,
    required this.totalFees,
    required this.details,
    this.exchangeDetails,
    required this.runningBalance,
    required this.referenceNumber,
    this.attachment,
    // required this.activityAssetAttributions,
  });

  final Type type;
  final DateTime date;
  final EndOfStatementBalance amount;
  final EndOfStatementBalance totalFees;
  final Details details;
  final ExchangeDetails? exchangeDetails;
  final EndOfStatementBalance runningBalance;
  final String referenceNumber;
  final dynamic attachment;
  // final List<dynamic> activityAssetAttributions;

  factory WiseTransaction.fromRawJson(String str) =>
      WiseTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WiseTransaction.fromJson(Map<String, dynamic> json) =>
      WiseTransaction(
        type: typeValues.map[json["type"]]!,
        date: DateTime.parse(json["date"]),
        amount: EndOfStatementBalance.fromJson(json["amount"]),
        totalFees: EndOfStatementBalance.fromJson(json["totalFees"]),
        details: Details.fromJson(json["details"]),
        exchangeDetails: json["exchangeDetails"] == null
            ? null
            : ExchangeDetails.fromJson(json["exchangeDetails"]),
        runningBalance: EndOfStatementBalance.fromJson(json["runningBalance"]),
        referenceNumber: json["referenceNumber"],
        attachment: json["attachment"],
        // activityAssetAttributions:
        // List<dynamic>.from(json["activityAssetAttributions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "date": date.toIso8601String(),
        "amount": amount.toJson(),
        "totalFees": totalFees.toJson(),
        "details": details.toJson(),
        "exchangeDetails": exchangeDetails?.toJson(),
        "runningBalance": runningBalance.toJson(),
        "referenceNumber": referenceNumber,
        "attachment": attachment,
        // "activityAssetAttributions":
        // List<dynamic>.from(activityAssetAttributions.map((x) => x)),
      };
}

class Details {
  Details({
    required this.type,
    required this.description,
    this.amount,
    this.originator,
    this.category,
    this.merchant,
    this.cardLastFourDigits,
    this.cardHolderFullName,
    this.sourceAmount,
    this.targetAmount,
    this.rate,
    this.senderName,
    this.senderAccount,
    this.paymentReference,
    this.recipientAccountNumber,
    this.recipientAccountDetailsId,
  });

  final String type;
  final String? originator;
  final String description;
  final EndOfStatementBalance? amount;
  final String? category;
  final Merchant? merchant;
  final String? cardLastFourDigits;
  final String? cardHolderFullName;
  final EndOfStatementBalance? sourceAmount;
  final EndOfStatementBalance? targetAmount;
  final double? rate;
  final String? senderName;
  final String? senderAccount;
  final String? paymentReference;
  final String? recipientAccountNumber;
  final int? recipientAccountDetailsId;

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        type: json["type"],
        description: json["description"],
        originator: json["originator"],
        amount: json["amount"] == null
            ? null
            : EndOfStatementBalance.fromJson(json["amount"]),
        category: json["category"],
        merchant: json["merchant"] == null
            ? null
            : Merchant.fromJson(json["merchant"]),
        cardLastFourDigits: json["cardLastFourDigits"],
        cardHolderFullName: json["cardHolderFullName"],
        sourceAmount: json["sourceAmount"] == null
            ? null
            : EndOfStatementBalance.fromJson(json["sourceAmount"]),
        targetAmount: json["targetAmount"] == null
            ? null
            : EndOfStatementBalance.fromJson(json["targetAmount"]),
        rate: json["rate"]?.toDouble(),
        senderName: json["senderName"],
        senderAccount: json["senderAccount"],
        paymentReference: json["paymentReference"],
        recipientAccountNumber: json["recipientAccountNumber"],
        recipientAccountDetailsId: json["recipientAccountDetailsId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "description": description,
        "originator": originator,
        "amount": amount?.toJson(),
        "category": category,
        "merchant": merchant?.toJson(),
        "cardLastFourDigits": cardLastFourDigits,
        "cardHolderFullName": cardHolderFullName,
        "sourceAmount": sourceAmount?.toJson(),
        "targetAmount": targetAmount?.toJson(),
        "rate": rate,
        "senderName": senderName,
        "senderAccount": senderAccount,
        "paymentReference": paymentReference,
        "recipientAccountNumber": recipientAccountNumber,
        "recipientAccountDetailsId": recipientAccountDetailsId,
      };
}

class Merchant {
  Merchant({
    required this.name,
    this.firstLine,
    required this.postCode,
    required this.city,
    this.state,
    required this.country,
    required this.category,
  });

  final String name;
  final dynamic firstLine;
  final String? postCode;
  final String city;
  final dynamic state;
  final String country;
  final String category;

  factory Merchant.fromRawJson(String str) =>
      Merchant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        name: json["name"],
        firstLine: json["firstLine"],
        postCode: json["postCode"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "firstLine": firstLine,
        "postCode": postCode,
        "city": city,
        "state": state,
        "country": country,
        "category": category,
      };
}

class ExchangeDetails {
  ExchangeDetails({
    required this.toAmount,
    required this.fromAmount,
    required this.rate,
  });

  final EndOfStatementBalance toAmount;
  final EndOfStatementBalance fromAmount;
  final double rate;

  factory ExchangeDetails.fromRawJson(String str) =>
      ExchangeDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExchangeDetails.fromJson(Map<String, dynamic> json) =>
      ExchangeDetails(
        toAmount: EndOfStatementBalance.fromJson(json["toAmount"]),
        fromAmount: EndOfStatementBalance.fromJson(json["fromAmount"]),
        rate: json["rate"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "toAmount": toAmount.toJson(),
        "fromAmount": fromAmount.toJson(),
        "rate": rate,
      };
}

enum Type { CREDIT, DEBIT }

final typeValues = EnumValues({"CREDIT": Type.CREDIT, "DEBIT": Type.DEBIT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

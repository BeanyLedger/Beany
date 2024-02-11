class Date implements DateTime {
  final DateTime _native;

  Date(int year, [int month = 1, int day = 1])
      : _native = DateTime.utc(year, month, day);

  Date.from(DateTime dt) : _native = DateTime.utc(dt.year, dt.month, dt.day) {
    if (dt.hour != 0 ||
        dt.minute != 0 ||
        dt.second != 0 ||
        dt.millisecond != 0 ||
        dt.microsecond != 0) {
      throw ArgumentError('Date.from() only accepts dates with time 00:00:00');
    }
  }

  Date.truncate(DateTime dt)
      : _native = DateTime.utc(dt.year, dt.month, dt.day);

  Date.fromIso8601String(String s) : _native = fromIso8601DateOnlyString(s);

  DateTime get nt => _native;

  @override
  DateTime add(Duration duration) => _native.add(duration);

  Date yesterday() => Date.from(add(Duration(days: -1)));

  @override
  int compareTo(DateTime other) => _native.compareTo(other);

  @override
  int get day => _native.day;

  @override
  Duration difference(DateTime other) => _native.difference(other);

  @override
  int get hour => _native.hour;

  @override
  bool isAfter(DateTime other) => _native.isAfter(other);

  @override
  bool isAtSameMomentAs(DateTime other) => _native.isAtSameMomentAs(other);

  @override
  bool isBefore(DateTime other) => _native.isBefore(other);

  @override
  bool get isUtc => _native.isUtc;

  @override
  int get microsecond => _native.microsecond;

  @override
  int get microsecondsSinceEpoch => _native.microsecondsSinceEpoch;

  @override
  int get millisecond => _native.millisecond;

  @override
  int get millisecondsSinceEpoch => _native.millisecondsSinceEpoch;

  @override
  int get minute => _native.minute;

  @override
  int get month => _native.month;

  @override
  int get second => _native.second;

  @override
  DateTime subtract(Duration duration) => _native.subtract(duration);

  @override
  String get timeZoneName => _native.timeZoneName;

  @override
  Duration get timeZoneOffset => _native.timeZoneOffset;

  @override
  String toIso8601String() => _native.toIso8601String().substring(0, 10);

  @override
  DateTime toLocal() => DateTime.utc(_native.year, _native.month, _native.day);

  @override
  DateTime toUtc() => DateTime.utc(_native.year, _native.month, _native.day);

  @override
  int get weekday => _native.weekday;

  @override
  int get year => _native.year;

  @override
  String toString() => toIso8601String();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Date) {
      return _native.year == other.year &&
          _native.month == other.month &&
          _native.day == other.day;
    }
    if (other is DateTime) {
      return _native.year == other.year &&
          _native.month == other.month &&
          _native.day == other.day &&
          other.hour == 0 &&
          other.minute == 0 &&
          other.second == 0 &&
          other.millisecond == 0 &&
          other.microsecond == 0;
    }
    return _native == other;
  }

  @override
  int get hashCode => _native.hashCode;

  bool operator <(Object other) {
    if (other is Date) {
      return _native.isBefore(other);
    }
    if (other is DateTime) {
      return _native.isBefore(other);
    }

    throw ArgumentError('Invalid argument for operator <');
  }

  bool operator >(Object other) {
    if (other is Date) {
      return _native.isAfter(other);
    }
    if (other is DateTime) {
      return _native.isAfter(other);
    }

    throw ArgumentError('Invalid argument for operator >');
  }

  static Date today() {
    final dt = DateTime.now();
    return Date(dt.year, dt.month, dt.day);
  }

  String toJson() => toIso8601String();
  factory Date.fromJson(String value) => Date.fromIso8601String(value);
}

DateTime fromIso8601DateOnlyString(String s) {
  var parts = s.split('-');
  if (parts.length != 3) {
    throw ArgumentError('Date must be in the format YYYY-MM-DD');
  }
  if (s.length != 10) {
    throw ArgumentError('Invalid date format');
  }

  var year = int.parse(parts[0]);
  var month = int.parse(parts[1]);
  var day = int.parse(parts[2]);

  return DateTime.utc(year, month, day);
}

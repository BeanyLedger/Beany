class Date implements DateTime {
  final DateTime _native;

  Date(int year, int month, int day) : _native = DateTime.utc(year, month, day);

  Date.from(DateTime dt) : _native = DateTime.utc(dt.year, dt.month, dt.day) {
    if (dt.hour != 0 ||
        dt.minute != 0 ||
        dt.second != 0 ||
        dt.millisecond != 0 ||
        dt.microsecond != 0) {
      throw ArgumentError('Date.from() only accepts dates with time 00:00:00');
    }
  }

  @override
  DateTime add(Duration duration) => _native.add(duration);

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
  DateTime toLocal() => DateTime(_native.year, _native.month, _native.day);

  @override
  DateTime toUtc() => DateTime.utc(_native.year, _native.month, _native.day);

  @override
  int get weekday => _native.weekday;

  @override
  int get year => _native.year;

  @override
  String toString() => toIso8601String();

  @override
  bool operator ==(Object other) => _native == other;

  @override
  int get hashCode => _native.hashCode;
}

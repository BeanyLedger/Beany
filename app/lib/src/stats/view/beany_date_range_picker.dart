import 'package:beany_backend/beany_backend.dart' as bb;
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

class BeanyDateRangePicker extends StatelessWidget {
  final bb.DateRange dateRange;
  final void Function(DateRange?) onDateRangeChanged;

  const BeanyDateRangePicker({
    required this.dateRange,
    required this.onDateRangeChanged,
    super.key,
  });

  DateRange? _range() {
    var start = dateRange.startDate;
    var end = dateRange.endDate;

    if (start == null || end == null) {
      return null;
    }
    return DateRange(
      DateTime(start.year, start.month, start.day),
      DateTime(end.year, end.month, end.day),
    );
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return DateRangePickerWidget(
      doubleMonth: false,
      initialDateRange: _range(),
      maxDate: now,
      onDateRangeChanged: onDateRangeChanged,
      quickDateRanges: [
        QuickDateRange(
          label: "This Month",
          dateRange: DateRange(
            DateTime(now.year, now.month),
            DateTime.now(),
          ),
        ),
        QuickDateRange(
          label: "Last Month",
          dateRange: DateRange(
            DateTime(now.year, now.month - 1),
            DateTime(now.year, now.month, 0),
          ),
        ),
        QuickDateRange(
          label: "Last 3 Months",
          dateRange: DateRange(
            DateTime(now.year, now.month - 3),
            DateTime.now(),
          ),
        ),
        QuickDateRange(
          label: "This Year",
          dateRange: DateRange(
            DateTime(now.year),
            DateTime.now(),
          ),
        ),
      ],
    );
  }
}

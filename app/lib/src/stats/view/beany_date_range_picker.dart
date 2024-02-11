import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

class BeanyDateRangePicker extends StatelessWidget {
  final DateRange dateRange;
  final void Function(DateRange?) onDateRangeChanged;

  const BeanyDateRangePicker({
    required this.dateRange,
    required this.onDateRangeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return DateRangePickerWidget(
      doubleMonth: false,
      initialDateRange: dateRange,
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

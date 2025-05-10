enum Range { W, M, Y }

class ActivityFilter {
  final Range range; // 'W' | 'M' | 'Y'
  final DateTime startDate;
  final DateTime endDate;

  const ActivityFilter({
    required this.range,
    required this.startDate,
    required this.endDate,
  });

  ActivityFilter copyWith({
    Range range = Range.W,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ActivityFilter(
      range: range,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

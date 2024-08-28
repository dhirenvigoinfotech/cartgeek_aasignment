class CurrentBooking {
  final String title;
  final String fromDate;
  final String fromTime;
  final String toDate;
  final String toTime;

  CurrentBooking({
    required this.title,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
  });

  factory CurrentBooking.fromJson(Map<String, dynamic> json) {
    return CurrentBooking(
      title: json['title'],
      fromDate: json['from_date'],
      fromTime: json['from_time'],
      toDate: json['to_date'],
      toTime: json['to_time'],
    );
  }
}

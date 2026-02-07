class NotificationModel {
  final String id;
  final String title;
  final String subTitle;
  final String time;
  final bool isRead;
  final String type; // Optional: 'emergency', 'info', 'reward'

  NotificationModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.time,
    this.isRead = false,
    this.type = 'info',
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      subTitle: subTitle,
      time: time,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}

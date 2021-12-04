class ReceiveNotificationEntity {
  int? id;
  final String title;
  final String body;
  final String? payload;

  ReceiveNotificationEntity(
      {this.id, required this.title, required this.body, this.payload});
}

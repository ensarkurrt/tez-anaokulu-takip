class Announcement {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  factory Announcement.empty() {
    return Announcement(
      id: 0,
      title: '',
      content: '',
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };

  String get parseDate {
    return "${createdAt.day}.${createdAt.month}.${createdAt.year}";
  }
}

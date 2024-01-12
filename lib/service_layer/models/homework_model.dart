class HomeWork {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  bool isDone = false;

  HomeWork({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.isDone = false,
  });

  factory HomeWork.fromJson(Map<String, dynamic> json) {
    return HomeWork(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  factory HomeWork.empty() {
    return HomeWork(
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

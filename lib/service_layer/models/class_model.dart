class ClassModel {
  final int id;
  final String name;
  final String schoolId;
  final String? teacherId;
  final DateTime? createdAt;

  ClassModel({
    required this.id,
    required this.name,
    required this.schoolId,
    this.teacherId,
    this.createdAt,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'],
      schoolId: json['school_id'].toString(),
      teacherId: json['teacher_id'].toString(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  factory ClassModel.empty() {
    return ClassModel(
      id: 0,
      name: '',
      schoolId: '',
      teacherId: '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'schoolId': schoolId,
        'teacherId': teacherId,
      };

  String get parseDate {
    return "${createdAt?.day}.${createdAt?.month}.${createdAt?.year}";
  }
}

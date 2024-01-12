class Student {
  final int id;

  final String? userId;
  final String? name;
  final int schoolId;
  final int classId;

  Student({
    required this.id,
    this.userId,
    this.name,
    required this.schoolId,
    required this.classId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      userId: json['user_id'],
      schoolId: json['school_id'],
      classId: json['class_id'],
      name: json['name'],
    );
  }

  factory Student.empty() {
    return Student(
      id: 0,
      userId: '',
      schoolId: 0,
      classId: 0,
      name: '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userId': userId,
        'schoolId': schoolId,
        'classId': classId,
      };
}

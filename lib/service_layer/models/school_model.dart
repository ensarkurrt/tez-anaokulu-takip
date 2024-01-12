import 'package:kindergarden_mobile/service_layer/models/class_model.dart';

class School {
  final int id;
  final String name;
  final String ownerId;
  final List<ClassModel>? classes;

  School({
    required this.id,
    required this.name,
    required this.ownerId,
    this.classes,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      ownerId: json['owner_id'].toString(),
      classes: json['classes'] != null ? (json['classes'] as List).map((e) => ClassModel.fromJson(e)).toList() : null,
    );
  }

  factory School.empty() {
    return School(
      id: 0,
      name: '',
      ownerId: '',
      classes: [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ownerId': ownerId,
        'classes': classes?.map((e) => e.toJson()).toList(),
      };
}

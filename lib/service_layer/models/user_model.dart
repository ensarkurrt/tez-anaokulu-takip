class User {
  final String id;
  String? name;
  final String email;

  User({
    required this.id,
    this.name,
    required this.email,
  });

  factory User.fromSupabase(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['user_metadata'] != null
          ? json['user_metadata']['name']
          : (json['raw_user_meta_data'] != null ? json['raw_user_meta_data']['name'] : "TEST"),
      email: json['email'],
    );
  }

  factory User.empty() {
    return User(
      id: '',
      name: '',
      email: '',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['user_metadata'] != null
          ? json['user_metadata']['name']
          : (json['raw_user_meta_data'] != null ? json['raw_user_meta_data']['name'] : "TEST"),
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}

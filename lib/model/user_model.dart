class User {
  final int? id;
  final String? email;
  final String? name;
  final String? nickname;
  final String? country;
  final String? region;
  final String? role;
  final String? gender;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.nickname,
    required this.country,
    required this.region,
    required this.role,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      nickname: json['nickname'],
      country: json['country'],
      region: json['region'],
      role: json['role'],
      gender: json['gender'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'nickname': nickname,
        'country': country,
        'region': region,
        'role': role,
        'gender': gender,
      };
}

// for request
class UserRequest {
  final String nickname;
  final int age;
  final String gender;
  final String country;
  final String region;

  UserRequest({
    required this.nickname,
    required this.age,
    required this.gender,
    required this.country,
    required this.region,
  });

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'age': age,
        'gender': gender,
        'country': country,
        'region': region,
      };
}

// response
class UserResponse {
  final int? id;
  final String? email;
  final String? nickname;
  final int? age;
  final String? country;
  final String? region;
  final String? role;
  final String? gender;

  UserResponse({
    required this.id,
    required this.email,
    required this.nickname,
    required this.age,
    required this.country,
    required this.region,
    required this.role,
    required this.gender,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      nickname: json['nickname'],
      age: json['age'],
      gender: json['gender'],
      country: json['country'],
      region: json['region'],
      role: json['role'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'nickname': nickname,
        'age': age,
        'gender': gender,
        'country': country,
        'region': region,
        'role': role,
      };
}

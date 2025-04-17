class UserRequest {
  final String jwt;

  UserRequest({
    required this.jwt,
  });

  Map<String, dynamic> toJson() => {
        'Authorization': jwt,
      };
}

// for profile initialization request
class PatchUserRequest {
  final String nickname;
  // final int age;
  final String gender;
  final String country;
  final String region;
  final DateTime dateOfBirth;

  final String difficulty;
  final String motivation;
  final List<String> locationPreferences;

  PatchUserRequest({
    required this.nickname,
    // required this.age,
    required this.gender,
    required this.country,
    required this.region,
    required this.dateOfBirth,
    required this.difficulty,
    required this.motivation,
    required this.locationPreferences,
  });

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        // 'age': age,
        'gender': gender,
        'country': country,
        'region': region,
        'date of birth': dateOfBirth,
        'difficulty': difficulty,
        'motivation': motivation,
        'location preferences': locationPreferences,
      };
}

// response
class UserResponse {
  final int? id;
  final String? nickname;
  final String? role;
  final String? profileImageUrl;

  UserResponse({
    required this.id,
    required this.nickname,
    required this.role,
    required this.profileImageUrl,
  });

  // TODO: edit by api
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      nickname: json['nickname'],
      role: json['role'],
      profileImageUrl: json['picture'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'role': role,
        'picture': profileImageUrl,
      };
}




class UserCredentials {
  final String userId;
  final String password;

  UserCredentials({required this.userId, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'matricula': userId,
      'password': password,
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      userId: json['user_id'],
      password: json['password'],
    );
  }

}
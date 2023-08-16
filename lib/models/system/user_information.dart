



import 'credit.dart';

class UserInformation {
  List<Credit> credits;
  UserInformation({required this.credits});


  static UserInformation fromMap(Map user) {
    return UserInformation(
      credits: user['credits'] ?? []
    );
  }
}
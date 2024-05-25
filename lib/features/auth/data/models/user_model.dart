import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.id,
  });
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(email: map["email"]?? '', id: map["id"] ?? '');
  }
}

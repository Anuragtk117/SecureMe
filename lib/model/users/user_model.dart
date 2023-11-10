import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class Usersmodel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String phone;

  Usersmodel(
      {required this.username, required this.password, required this.phone});

  @override
  String toString() {
    return '$username,$password,$phone';
  }
}

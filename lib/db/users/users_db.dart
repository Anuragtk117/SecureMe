import 'package:hive_flutter/hive_flutter.dart';
import 'package:miniproject/model/users/user_model.dart';

const USERS_DB_NAME = 'users_database';

abstract class UsersDbFunctions {
  Future<void> insertUser(Usersmodel value);
}

class UserDB implements UsersDbFunctions {
  @override
  Future<void> insertUser(Usersmodel value) async {
    final _usersDB = await Hive.openBox<Usersmodel>(USERS_DB_NAME);
    await _usersDB.put(value.username, value);
  }

  @override
  Future<List<Usersmodel>> getUsers() async {
    final _usersDB = await Hive.openBox<Usersmodel>(USERS_DB_NAME);
    return _usersDB.values.toList();
  }
}

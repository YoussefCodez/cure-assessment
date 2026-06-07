import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/user_model.dart';

@lazySingleton
class AuthLocalDataSource {
  static const String _boxName = 'user_box';
  static const String _userKey = 'cached_user';

  Future<void> cacheUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(_boxName);
    await box.put(_userKey, user);
  }

  Future<UserModel?> getUser() async {
    final box = await Hive.openBox<UserModel>(_boxName);
    return box.get(_userKey);
  }

  Future<void> clearUser() async {
    final box = await Hive.openBox<UserModel>(_boxName);
    await box.delete(_userKey);
  }
}

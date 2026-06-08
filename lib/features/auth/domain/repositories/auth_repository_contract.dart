import '../../../../config/network/base_response.dart';
import '../entities/user_entity.dart';

abstract class AuthRepositoryContract {
  Future<BaseResponse<UserEntity>> login(String email, String password);

  Future<BaseResponse<UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<BaseResponse<void>> logout();

  Future<BaseResponse<UserEntity?>> isLoggedIn();
}

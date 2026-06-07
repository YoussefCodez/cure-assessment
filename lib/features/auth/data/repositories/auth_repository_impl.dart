import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../../config/storage/token_storage.dart';
import '../../../../config/utils/auth_regx.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_mock_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthMockDataSource _authMockDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final TokenStorage _tokenStorage;

  const AuthRepositoryImpl({
    required AuthMockDataSource authMockDataSource,
    required AuthLocalDataSource authLocalDataSource,
    required TokenStorage tokenStorage,
  }) : _authMockDataSource = authMockDataSource,
       _authLocalDataSource = authLocalDataSource,
       _tokenStorage = tokenStorage;

  @override
  Future<BaseResponse<UserEntity>> login(String email, String password) async {
    try {
      if (!AuthRegx.isValidEmail(email)) {
        return FailedResponse('Invalid email format');
      }
      if (password.isEmpty) {
        return FailedResponse('Password cannot be empty');
      }
      if (password.length < 6) {
        return FailedResponse('Password must be at least 6 characters');
      }

      final user = await _authMockDataSource.login(email, password);
      await _tokenStorage.saveToken(user.token);
      await _authLocalDataSource.cacheUser(user);
      return SuccessResponse(
        UserEntity(
          id: user.id,
          name: user.name,
          email: user.email,
          token: user.token,
        ),
      );
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<BaseResponse<UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (name.trim().isEmpty) {
        return FailedResponse('Name cannot be empty');
      }
      if (!AuthRegx.isValidEmail(email)) {
        return FailedResponse('Invalid email format');
      }
      if (password.length < 6) {
        return FailedResponse('Password must be at least 6 characters');
      }

      final user = await _authMockDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      await _tokenStorage.saveToken(user.token);
      await _authLocalDataSource.cacheUser(user);
      return SuccessResponse(
        UserEntity(
          id: user.id,
          name: user.name,
          email: user.email,
          token: user.token,
        ),
      );
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<BaseResponse<void>> logout() async {
    try {
      await _authMockDataSource.logout();
      await _tokenStorage.clearToken();
      await _authLocalDataSource.clearUser();
      return SuccessResponse(null);
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<BaseResponse<UserEntity>> isLoggedIn() async {
    try {
      final hasToken = await _tokenStorage.hasToken();
      if (hasToken) {
        final user = await _authLocalDataSource.getUser();
        if (user == null) {
          return FailedResponse('No user found');
        }
        return SuccessResponse(
          UserEntity(
            id: user.id,
            name: user.name,
            email: user.email,
            token: user.token,
          ),
        );
      }
      return FailedResponse(
        'No user found',
      );
    } catch (e) {
      return FailedResponse(e.toString().replaceAll('Exception: ', ''));
    }
  }
}

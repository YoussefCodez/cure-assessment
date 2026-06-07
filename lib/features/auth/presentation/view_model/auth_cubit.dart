import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/is_logged_in_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required IsLoggedInUseCase isLoggedInUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _isLoggedInUseCase = isLoggedInUseCase,
        super(const AuthInitial());

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    final result = await _loginUseCase(email, password);
    if (result is SuccessResponse<UserEntity>) {
      emit(AuthSuccess(result.data));
    } else if (result is FailedResponse<UserEntity>) {
      emit(AuthFailure(result.message));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    final result = await _registerUseCase(
      name: name,
      email: email,
      password: password,
    );
    if (result is SuccessResponse<UserEntity>) {
      emit(AuthSuccess(result.data));
    } else if (result is FailedResponse<UserEntity>) {
      emit(AuthFailure(result.message));
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await _logoutUseCase();
    if (result is SuccessResponse<void>) {
      emit(const Unauthenticated());
    } else if (result is FailedResponse<void>) {
      emit(AuthFailure(result.message));
    }
  }

  Future<void> checkAuth() async {
    emit(const AuthLoading());
    final result = await _isLoggedInUseCase();
    if (result is SuccessResponse<UserEntity>) {
      emit(AuthSuccess(result.data));
    } else {
      emit(const Unauthenticated());
    }
  }
}

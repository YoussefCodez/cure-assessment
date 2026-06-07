import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class IsLoggedInUseCase {
  final AuthRepository _repository;

  const IsLoggedInUseCase(this._repository);

  Future<BaseResponse<UserEntity?>> call() {
    return _repository.isLoggedIn();
  }
}

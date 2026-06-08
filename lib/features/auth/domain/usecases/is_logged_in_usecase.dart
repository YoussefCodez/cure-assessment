import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository_contract.dart';

@injectable
class IsLoggedInUseCase {
  final AuthRepositoryContract _repository;

  const IsLoggedInUseCase(this._repository);

  Future<BaseResponse<UserEntity?>> call() {
    return _repository.isLoggedIn();
  }
}

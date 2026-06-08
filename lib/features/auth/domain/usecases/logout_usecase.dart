import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../repositories/auth_repository_contract.dart';

@injectable
class LogoutUseCase {
  final AuthRepositoryContract _repository;

  const LogoutUseCase(this._repository);

  Future<BaseResponse<void>> call() {
    return _repository.logout();
  }
}

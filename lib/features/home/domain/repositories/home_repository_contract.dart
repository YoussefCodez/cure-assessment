import '../../../../config/network/base_response.dart';
import '../../domain/entities/service_entity.dart';

abstract class HomeRepositoryContract {
  Future<BaseResponse<List<ServiceEntity>>> getServices();
}

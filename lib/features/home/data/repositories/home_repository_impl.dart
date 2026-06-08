import 'package:injectable/injectable.dart';
import '../../../../config/network/base_response.dart';
import '../../../../config/network/network_exceptions.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/home_repository_contract.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_mock_datasource.dart';

@LazySingleton(as: HomeRepositoryContract)
class HomeRepositoryImpl implements HomeRepositoryContract {
  final HomeMockDataSource _homeMockDataSource;
  final HomeLocalDataSource _homeLocalDataSource;

  const HomeRepositoryImpl({
    required HomeMockDataSource homeMockDataSource,
    required HomeLocalDataSource homeLocalDataSource,
  }) : _homeMockDataSource = homeMockDataSource,
       _homeLocalDataSource = homeLocalDataSource;

  @override
  Future<BaseResponse<List<ServiceEntity>>> getServices() async {
    try {
      // 1- check if cached existed and not empty or null if yes return it
      final cached = await _homeLocalDataSource.getCachedServices();
      if (cached.isNotEmpty) {
        return SuccessResponse(cached.map((e) => e.toEntity()).toList());
      }

      // 2- get the data from api and cache it
      final remote = await _homeMockDataSource.fetchServices();
      await _homeLocalDataSource.cacheServices(remote);

      // 3- return remote data
      return SuccessResponse(remote.map((e) => e.toEntity()).toList());
    } on NetworkException catch (e) {
      // 4- in catches show cache first if failed show failed response
      final cached = await _homeLocalDataSource.getCachedServices();
      if (cached.isEmpty) {
        return FailedResponse(ErrorHandler.handle(e));
      }
      return SuccessResponse(cached.map((e) => e.toEntity()).toList());
    } catch (e) {
      final cached = await _homeLocalDataSource.getCachedServices();
      if (cached.isEmpty) {
        return FailedResponse(ErrorHandler.handle(e));
      }
      return SuccessResponse(cached.map((e) => e.toEntity()).toList());
    }
  }
}

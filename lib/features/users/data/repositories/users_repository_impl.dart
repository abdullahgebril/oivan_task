import 'package:oivan_task/core/constants/endpoints_const.dart';
import 'package:oivan_task/features/users/data/model/api_response_model.dart';
import 'package:oivan_task/features/users/data/model/reputation_history_model.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';
import 'package:oivan_task/features/users/domain/repositories/i_users_repository.dart';
import 'package:oivan_task/network/remote_client.dart';

class UsersRepositoryImpl implements IUsersRepository {
  final RemoteClient remoteClient;
  final EndPoints endpoints;

  UsersRepositoryImpl({
    required this.remoteClient,
    required this.endpoints,
  });

  @override
  Future<ApiResponseModel<UserModel>> getUsers({
    required int page,
    required int pageSize,
  }) async {
    final response = await remoteClient.get(
      endpoints.usersEndpoint,
      queryParameters: {
        'page': page,
        'pagesize': pageSize,
        'site': endpoints.site,
      },
    );

    return ApiResponseModel<UserModel>.fromJson(
      response.data,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseModel<ReputationHistoryModel>> getUserReputationHistory({
    required int userId,
    required int page,
    required int pageSize,
  }) async {
    final response = await remoteClient.get(
      endpoints.userReputationHistory(userId),
      queryParameters: {
        'page': page,
        'pagesize': pageSize,
        'site': endpoints.site,
      },
    );

    return ApiResponseModel<ReputationHistoryModel>.fromJson(
      response.data,
      (json) => ReputationHistoryModel.fromJson(json as Map<String, dynamic>),
    );
  }
}

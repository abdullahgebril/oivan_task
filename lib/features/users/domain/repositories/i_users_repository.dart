import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/features/users/data/model/api_response_model.dart';
import 'package:oivan_task/features/users/data/model/reputation_history_model.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';
import 'package:oivan_task/features/users/data/repositories/users_repository_impl.dart';
import 'package:oivan_task/network/remote_client.dart';
import 'package:oivan_task/core/constants/endpoints_const.dart';

abstract class IUsersRepository {
  static final provider = Provider<IUsersRepository>(
    (ref) => UsersRepositoryImpl(
      remoteClient: ref.read(remoteClientProvider),
      endpoints: ref.read(EndPoints.provider),
    ),
  );

  Future<ApiResponseModel<UserModel>> getUsers({
    required int page,
    required int pageSize,
  });

  Future<ApiResponseModel<ReputationHistoryModel>> getUserReputationHistory({
    required int userId,
    required int page,
    required int pageSize,
  });
}

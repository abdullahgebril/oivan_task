import 'package:flutter_riverpod/flutter_riverpod.dart';

class EndPoints {
  static final provider = Provider<EndPoints>((ref) => EndPoints());

  String get apiUrl => 'https://api.stackexchange.com/2.2';

  String get usersEndpoint => '/users';

  String userReputationHistory(int userId) =>
      '/users/$userId/reputation-history';

  String get site => 'stackoverflow';
}

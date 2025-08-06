import 'package:oivan_task/features/users/data/model/user_model.dart';

class UsersState {
  final List<UserModel> users;
  final bool hasMore;
  final int currentPage;
  final bool isLoadingMore;

  const UsersState({
    this.users = const [],
    this.hasMore = true,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  UsersState copyWith({
    List<UserModel>? users,
    bool? hasMore,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return UsersState(
      users: users ?? this.users,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

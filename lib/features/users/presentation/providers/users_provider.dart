import 'package:event_bus/event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/events/app_events.dart';
import 'package:oivan_task/core/states/users_state.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';
import 'package:oivan_task/features/users/domain/repositories/i_users_repository.dart';
import 'package:oivan_task/core/states/general_state.dart';

final usersStateProvider =
    StateNotifierProvider<UsersStateNotifier, UsersState>(
  (ref) => UsersStateNotifier(),
);

class UsersStateNotifier extends StateNotifier<UsersState> {
  UsersStateNotifier() : super(const UsersState());

  void setUsers(List<UserModel> users) {
    state = state.copyWith(users: users);
  }

  void addUsers(List<UserModel> newUsers) {
    state = state.copyWith(users: [...state.users, ...newUsers]);
  }

  void updatePagination({int? currentPage, bool? hasMore}) {
    state = state.copyWith(
      currentPage: currentPage ?? state.currentPage,
      hasMore: hasMore ?? state.hasMore,
    );
  }

  void setLoadingMore(bool isLoadingMore) {
    state = state.copyWith(isLoadingMore: isLoadingMore);
  }

  void reset() {
    state = const UsersState();
  }
}

class UsersProvider extends StateNotifier<GeneralState> {
  static final provider =
      StateNotifierProvider.autoDispose<UsersProvider, GeneralState>(
    (ref) {
      final repository = ref.watch(IUsersRepository.provider);
      final eventBus = ref.watch(AppEvent.busProvider);
      final usersNotifier = ref.read(usersStateProvider.notifier);
      return UsersProvider(repository, eventBus, usersNotifier);
    },
  );

  final IUsersRepository _repository;
  final EventBus _eventBus;
  final UsersStateNotifier _usersNotifier;

  static const int _pageSize = 30;

  UsersProvider(this._repository, this._eventBus, this._usersNotifier)
      : super(GeneralState.idle);

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (state == GeneralState.loading && !isRefresh) return;

    final currentState = _usersNotifier.state;

    if (isRefresh) {
      state = GeneralState.loading;
      _usersNotifier.reset();
    } else if (currentState.users.isEmpty) {
      state = GeneralState.loading;
    } else {
      _usersNotifier.setLoadingMore(true);
    }

    try {
      final page = isRefresh ? 1 : currentState.currentPage;
      final response = await _repository.getUsers(
        page: page,
        pageSize: _pageSize,
      );

      if (isRefresh) {
        _usersNotifier.setUsers(response.items);
      } else {
        _usersNotifier.addUsers(response.items);
      }

      _usersNotifier.updatePagination(
        currentPage: page + 1,
        hasMore: response.hasMore,
      );
      _usersNotifier.setLoadingMore(false);

      state = GeneralState.success(response);
    } catch (e) {
      _eventBus.fire(ErrorEvent(message: e.toString()));

      if (currentState.users.isNotEmpty) {
        _usersNotifier.setLoadingMore(false);
      }

      state = GeneralState.error(e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = _usersNotifier.state;

    if (!currentState.hasMore || currentState.isLoadingMore) return;

    await fetchUsers();
  }
}

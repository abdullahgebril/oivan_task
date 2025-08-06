import 'package:event_bus/event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/events/app_events.dart';
import 'package:oivan_task/core/states/general_state.dart';
import 'package:oivan_task/core/states/reputation_state.dart';
import 'package:oivan_task/features/users/data/model/reputation_history_model.dart';
import 'package:oivan_task/features/users/domain/repositories/i_users_repository.dart';

final reputationStateProvider =
    StateNotifierProvider.family<ReputationStateNotifier, ReputationState, int>(
  (ref, userId) => ReputationStateNotifier(),
);

class ReputationStateNotifier extends StateNotifier<ReputationState> {
  ReputationStateNotifier() : super(const ReputationState());

  void setHistory(List<ReputationHistoryModel> history) {
    state = state.copyWith(history: history);
  }

  void addHistory(List<ReputationHistoryModel> newHistory) {
    state = state.copyWith(history: [...state.history, ...newHistory]);
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
    state = const ReputationState();
  }
}

class ReputationProvider extends StateNotifier<GeneralState> {
  static final provider = StateNotifierProvider.family
      .autoDispose<ReputationProvider, GeneralState, int>(
    (ref, userId) {
      final repository = ref.watch(IUsersRepository.provider);
      final eventBus = ref.watch(AppEvent.busProvider);
      final reputationNotifier =
          ref.read(reputationStateProvider(userId).notifier);
      return ReputationProvider(
          repository, eventBus, reputationNotifier, userId);
    },
  );

  final IUsersRepository _repository;
  final EventBus _eventBus;
  final ReputationStateNotifier _reputationNotifier;
  final int _userId;
  static const int _pageSize = 30;

  ReputationProvider(
      this._repository, this._eventBus, this._reputationNotifier, this._userId)
      : super(GeneralState.idle);

  Future<void> fetchReputationHistory({bool isRefresh = false}) async {
    if (state == GeneralState.loading && !isRefresh) return;

    final currentState = _reputationNotifier.state;

    if (isRefresh) {
      state = GeneralState.loading;
      _reputationNotifier.reset();
    } else if (currentState.history.isEmpty) {
      state = GeneralState.loading;
    } else {
      _reputationNotifier.setLoadingMore(true);
    }

    try {
      final page = isRefresh ? 1 : currentState.currentPage;
      final response = await _repository.getUserReputationHistory(
        userId: _userId,
        page: page,
        pageSize: _pageSize,
      );

      if (isRefresh) {
        _reputationNotifier.setHistory(response.items);
      } else {
        _reputationNotifier.addHistory(response.items);
      }

      _reputationNotifier.updatePagination(
        currentPage: page + 1,
        hasMore: response.hasMore,
      );
      _reputationNotifier.setLoadingMore(false);

      state = GeneralState.success(response);
    } catch (e) {
      _eventBus.fire(ErrorEvent(message: e.toString()));

      if (currentState.history.isNotEmpty) {
        _reputationNotifier.setLoadingMore(false);
      }

      state = GeneralState.error(e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = _reputationNotifier.state;

    if (!currentState.hasMore || currentState.isLoadingMore) return;

    await fetchReputationHistory();
  }
}

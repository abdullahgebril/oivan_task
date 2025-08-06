import 'package:oivan_task/features/users/data/model/reputation_history_model.dart';

class ReputationState {
  final List<ReputationHistoryModel> history;
  final bool hasMore;
  final int currentPage;
  final bool isLoadingMore;

  const ReputationState({
    this.history = const [],
    this.hasMore = true,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  ReputationState copyWith({
    List<ReputationHistoryModel>? history,
    bool? hasMore,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return ReputationState(
      history: history ?? this.history,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

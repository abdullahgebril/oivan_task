import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/features/users/presentation/providers/reputation_provider.dart';
import 'package:oivan_task/features/users/presentation/widgets/reputation_history_card.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/shared/widgets/empty_state_widget.dart';
import 'package:oivan_task/shared/widgets/error_state_widget.dart';
import 'package:oivan_task/shared/widgets/loading_widget.dart';
import 'package:oivan_task/core/states/general_state.dart';

class ReputationHistoryList extends ConsumerStatefulWidget {
  final int userId;

  const ReputationHistoryList({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<ReputationHistoryList> createState() =>
      _ReputationHistoryListState();
}

class _ReputationHistoryListState extends ConsumerState<ReputationHistoryList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(ReputationProvider.provider(widget.userId).notifier)
          .fetchReputationHistory();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(ReputationProvider.provider(widget.userId).notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ReputationProvider.provider(widget.userId));
    final reputationState = ref.watch(reputationStateProvider(widget.userId));

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(ReputationProvider.provider(widget.userId).notifier)
            .fetchReputationHistory(isRefresh: true);
      },
      color: AppColors.primaryColor,
      child: state.when(
        idle: () => const LoadingWidget(),
        loading: () => const LoadingWidget(),
        failure: () => const ErrorStateWidget(),
        onSuccess: (_) {
          if (reputationState.history.isEmpty) {
            return EmptyStateWidget(
              title: LocaleKeys.screens_reputation_empty_title.tr(),
              subtitle: LocaleKeys.screens_reputation_empty_subtitle.tr(),
              icon: Icons.history,
            );
          }

          return ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                top: AppDimensions.paddingS.h,
                bottom: AppDimensions.bottomNavHeight.h),
            itemCount: reputationState.history.length +
                (reputationState.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == reputationState.history.length) {
                return Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingL.h),
                  child: const LoadingWidget(),
                );
              }

              return ReputationHistoryCard(
                history: reputationState.history[index],
                index: index,
              );
            },
          );
        },
        onError: (message) => ErrorStateWidget(
          message: message,
          onRetry: () {
            ref
                .read(ReputationProvider.provider(widget.userId).notifier)
                .fetchReputationHistory(isRefresh: true);
          },
        ),
      ),
    );
  }
}

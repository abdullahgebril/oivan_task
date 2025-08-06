import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/features/bookmarks/presentation/providers/bookmark_provider.dart';
import 'package:oivan_task/features/users/presentation/providers/users_provider.dart';
import 'package:oivan_task/features/users/presentation/widgets/user_card.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/shared/widgets/empty_state_widget.dart';
import 'package:oivan_task/shared/widgets/error_state_widget.dart';
import 'package:oivan_task/shared/widgets/loading_widget.dart';
import 'package:oivan_task/core/states/general_state.dart';

class BookmarksContent extends ConsumerWidget {
  final ScrollController scrollController;

  const BookmarksContent({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkState = ref.watch(BookmarkProvider.provider);
    final bookmarkedIds = ref.watch(bookmarkedUserIdsProvider);
    final usersState = ref.watch(usersStateProvider);

    final bookmarkedUsers = usersState.users
        .where((user) => bookmarkedIds.contains(user.userId))
        .toList();

    return bookmarkState.when(
      idle: () => const LoadingWidget(),
      loading: () => const LoadingWidget(),
      failure: () => const ErrorStateWidget(),
      onSuccess: (_) => _buildSuccessContent(
        context,
        ref,
        bookmarkedIds,
        bookmarkedUsers,
      ),
      onError: (message) => ErrorStateWidget(
        message: message,
        onRetry: () {
          ref.read(BookmarkProvider.provider.notifier).loadBookmarks();
        },
      ),
    );
  }

  Widget _buildSuccessContent(
    BuildContext context,
    WidgetRef ref,
    List<int> bookmarkedIds,
    List<dynamic> bookmarkedUsers,
  ) {
    if (bookmarkedIds.isEmpty) {
      return EmptyStateWidget(
        title: LocaleKeys.screens_bookmarks_empty_title.tr(),
        subtitle: LocaleKeys.screens_bookmarks_empty_subtitle.tr(),
        icon: Icons.bookmark_border,
      );
    }

    if (bookmarkedUsers.isEmpty) {
      return EmptyStateWidget(
        title: LocaleKeys.screens_bookmarks_loading_title.tr(),
        subtitle: LocaleKeys.screens_bookmarks_loading_subtitle.tr(),
        icon: Icons.bookmark_border,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(BookmarkProvider.provider.notifier).loadBookmarks();
      },
      color: AppColors.primaryColor,
      child: ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        cacheExtent: 500,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        padding: EdgeInsets.only(
          top: AppDimensions.paddingS.h,
          bottom: AppDimensions.bottomNavHeight.h,
        ),
        itemCount: bookmarkedUsers.length,
        itemBuilder: (context, index) {
          return RepaintBoundary(
            child: UserCard(
              user: bookmarkedUsers[index],
              index: index,
            ),
          );
        },
      ),
    );
  }
}

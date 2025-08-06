import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/features/bookmarks/presentation/providers/bookmark_provider.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class BookmarksAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BookmarksAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarkedUserIdsProvider);

    return AppBar(
      title: Text(
        LocaleKeys.screens_bookmarks_title.tr(),
        style: AppTextTheme.appBarTitle,
      ),
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      actions: [
        if (bookmarkedIds.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: AppColors.white),
            onPressed: () => _showClearAllDialog(context, ref),
          ),
      ],
    );
  }

  void _showClearAllDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          LocaleKeys.screens_bookmarks_clear_all.tr(),
        ),
        content: Text(
          LocaleKeys.screens_bookmarks_clear_confirmation.tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              LocaleKeys.screens_bookmarks_cancel.tr(),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(BookmarkProvider.provider.notifier).clearAllBookmarks();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.errorColor,
            ),
            child: Text(
              LocaleKeys.screens_bookmarks_clear.tr(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

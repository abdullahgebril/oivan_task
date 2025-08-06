import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/features/bookmarks/presentation/providers/bookmark_provider.dart';
import 'package:oivan_task/features/bookmarks/presentation/widgets/bookmarks_app_bar.dart';
import 'package:oivan_task/features/bookmarks/presentation/widgets/bookmarks_content.dart';

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({super.key});

  @override
  ConsumerState<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(BookmarkProvider.provider.notifier).loadBookmarks();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: const BookmarksAppBar(),
      body: BookmarksContent(
        scrollController: _scrollController,
      ),
    );
  }
}

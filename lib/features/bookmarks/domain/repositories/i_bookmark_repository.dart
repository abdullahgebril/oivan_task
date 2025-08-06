import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/cache/local_cache_service.dart';
import 'package:oivan_task/features/bookmarks/data/repositories/bookmark_repository_impl.dart';

abstract class IBookmarkRepository {
  static final provider = Provider<IBookmarkRepository>(
    (ref) => BookmarkRepositoryImpl(
      localCacheService: ref.read(ILocalCacheService.provider),
    ),
  );

  Future<void> addBookmark(int userId);
  Future<void> removeBookmark(int userId);
  Future<bool> isBookmarked(int userId);
  Future<List<int>> getBookmarkedUserIds();
  Future<void> clearAllBookmarks();
}

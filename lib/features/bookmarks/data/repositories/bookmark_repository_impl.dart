import 'package:oivan_task/core/cache/local_cache_service.dart';
import 'package:oivan_task/core/constants/cache_keys.dart';
import 'package:oivan_task/features/bookmarks/domain/repositories/i_bookmark_repository.dart';

class BookmarkRepositoryImpl implements IBookmarkRepository {
  final ILocalCacheService localCacheService;

  BookmarkRepositoryImpl({
    required this.localCacheService,
  });

  @override
  Future<void> addBookmark(int userId) async {
    final bookmarks = await getBookmarkedUserIds();
    if (!bookmarks.contains(userId)) {
      bookmarks.add(userId);
      await localCacheService.saveList(CacheKeys.bookmarkedUsers, bookmarks);
    }
  }

  @override
  Future<void> removeBookmark(int userId) async {
    final bookmarks = await getBookmarkedUserIds();
    bookmarks.remove(userId);
    await localCacheService.saveList(CacheKeys.bookmarkedUsers, bookmarks);
  }

  @override
  Future<bool> isBookmarked(int userId) async {
    final bookmarks = await getBookmarkedUserIds();
    return bookmarks.contains(userId);
  }

  @override
  Future<List<int>> getBookmarkedUserIds() async {
    return await localCacheService.getList<int>(CacheKeys.bookmarkedUsers);
  }

  @override
  Future<void> clearAllBookmarks() async {
    await localCacheService.removeData(CacheKeys.bookmarkedUsers);
  }
}

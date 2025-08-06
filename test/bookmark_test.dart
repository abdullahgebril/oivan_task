import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/features/bookmarks/domain/repositories/i_bookmark_repository.dart';
import 'package:oivan_task/features/bookmarks/presentation/providers/bookmark_provider.dart';

class MockBookmarkRepository implements IBookmarkRepository {
  List<int> _bookmarks = [];
  bool shouldThrow = false;
  String? errorMessage;

  void setBookmarks(List<int> bookmarks) {
    _bookmarks = bookmarks;
  }

  void setShouldThrow(bool value, [String? message]) {
    shouldThrow = value;
    errorMessage = message;
  }

  void reset() {
    _bookmarks = [];
    shouldThrow = false;
    errorMessage = null;
  }

  @override
  Future<List<int>> getBookmarkedUserIds() async {
    if (shouldThrow) throw Exception(errorMessage ?? 'Repository error');
    return List.from(_bookmarks);
  }

  @override
  Future<void> addBookmark(int userId) async {
    if (shouldThrow) throw Exception(errorMessage ?? 'Add bookmark error');
    if (!_bookmarks.contains(userId)) {
      _bookmarks.add(userId);
    }
  }

  @override
  Future<void> removeBookmark(int userId) async {
    if (shouldThrow) throw Exception(errorMessage ?? 'Remove bookmark error');
    _bookmarks.removeWhere((id) => id == userId);
  }

  @override
  Future<void> clearAllBookmarks() async {
    if (shouldThrow) throw Exception(errorMessage ?? 'Clear bookmarks error');
    _bookmarks.clear();
  }

  @override
  Future<bool> isBookmarked(int userId) async {
    if (shouldThrow) throw Exception(errorMessage ?? 'Is bookmarked error');
    return _bookmarks.contains(userId);
  }
}

void main() {
  late MockBookmarkRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockBookmarkRepository();

    container = ProviderContainer(
      overrides: [
        IBookmarkRepository.provider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    mockRepository.reset();
  });

  group('BookmarkedUserIdsNotifier Tests', () {
    test('loadBookmarks updates state with bookmarked user ids', () async {
      final expectedBookmarks = [1, 2, 3];
      mockRepository.setBookmarks(expectedBookmarks);

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.loadBookmarks();

      expect(container.read(bookmarkedUserIdsProvider), expectedBookmarks);
    });

    test('loadBookmarks sets empty list on error', () async {
      mockRepository.setShouldThrow(true, 'Failed to load');

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.loadBookmarks();

      expect(container.read(bookmarkedUserIdsProvider), isEmpty);
    });

    test('addBookmark adds user id to state', () async {
      const userId = 123;

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.addBookmark(userId);

      expect(container.read(bookmarkedUserIdsProvider), contains(userId));
    });

    test('addBookmark does not duplicate existing user id', () async {
      const userId = 123;

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.addBookmark(userId);
      await notifier.addBookmark(userId);

      final bookmarks = container.read(bookmarkedUserIdsProvider);
      expect(bookmarks.where((id) => id == userId).length, 1);
    });

    test('addBookmark rethrows repository errors', () async {
      const userId = 123;
      mockRepository.setShouldThrow(true, 'Add failed');

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);

      expect(() => notifier.addBookmark(userId), throwsException);
    });

    test('removeBookmark removes user id from state', () async {
      const userId = 123;
      mockRepository.setBookmarks([userId]);

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.loadBookmarks();
      await notifier.removeBookmark(userId);

      expect(
          container.read(bookmarkedUserIdsProvider), isNot(contains(userId)));
    });

    test('removeBookmark rethrows repository errors', () async {
      const userId = 123;
      mockRepository.setShouldThrow(true, 'Remove failed');

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);

      expect(() => notifier.removeBookmark(userId), throwsException);
    });

    test('clearAllBookmarks empties the state', () async {
      mockRepository.setBookmarks([1, 2, 3]);

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.loadBookmarks();
      await notifier.clearAllBookmarks();

      expect(container.read(bookmarkedUserIdsProvider), isEmpty);
    });

    test('clearAllBookmarks rethrows repository errors', () async {
      mockRepository.setShouldThrow(true, 'Clear failed');

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);

      expect(() => notifier.clearAllBookmarks(), throwsException);
    });

    test('isBookmarked returns true for bookmarked users', () async {
      const userId = 123;

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);
      await notifier.addBookmark(userId);

      expect(notifier.isBookmarked(userId), isTrue);
    });

    test('isBookmarked returns false for non-bookmarked users', () {
      const userId = 123;
      final notifier = container.read(bookmarkedUserIdsProvider.notifier);

      expect(notifier.isBookmarked(userId), isFalse);
    });

    test('multiple bookmarks can be managed', () async {
      const userIds = [1, 2, 3, 4, 5];

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);

      for (final userId in userIds) {
        await notifier.addBookmark(userId);
      }

      final bookmarks = container.read(bookmarkedUserIdsProvider);
      expect(bookmarks.length, userIds.length);

      for (final userId in userIds) {
        expect(bookmarks, contains(userId));
        expect(notifier.isBookmarked(userId), isTrue);
      }
    });

    test('bookmarks can be selectively removed', () async {
      const userIds = [1, 2, 3, 4, 5];
      const toRemove = [2, 4];

      final notifier = container.read(bookmarkedUserIdsProvider.notifier);

      for (final userId in userIds) {
        await notifier.addBookmark(userId);
      }

      for (final userId in toRemove) {
        await notifier.removeBookmark(userId);
      }

      final bookmarks = container.read(bookmarkedUserIdsProvider);
      expect(bookmarks.length, userIds.length - toRemove.length);

      for (final userId in toRemove) {
        expect(bookmarks, isNot(contains(userId)));
        expect(notifier.isBookmarked(userId), isFalse);
      }
    });
  });
}

import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/events/app_events.dart';
import 'package:oivan_task/features/bookmarks/domain/repositories/i_bookmark_repository.dart';
import 'package:oivan_task/core/states/general_state.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

final bookmarkedUserIdsProvider =
    StateNotifierProvider<BookmarkedUserIdsNotifier, List<int>>(
  (ref) => BookmarkedUserIdsNotifier(ref.read(IBookmarkRepository.provider)),
);

class BookmarkedUserIdsNotifier extends StateNotifier<List<int>> {
  final IBookmarkRepository _repository;

  BookmarkedUserIdsNotifier(this._repository) : super([]);

  Future<void> loadBookmarks() async {
    try {
      final bookmarks = await _repository.getBookmarkedUserIds();
      state = bookmarks;
    } catch (e) {
      state = [];
    }
  }

  Future<void> addBookmark(int userId) async {
    try {
      await _repository.addBookmark(userId);
      if (!state.contains(userId)) {
        state = [...state, userId];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeBookmark(int userId) async {
    try {
      await _repository.removeBookmark(userId);
      state = state.where((id) => id != userId).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearAllBookmarks() async {
    try {
      await _repository.clearAllBookmarks();
      state = [];
    } catch (e) {
      rethrow;
    }
  }

  bool isBookmarked(int userId) {
    return state.contains(userId);
  }
}

class BookmarkProvider extends StateNotifier<GeneralState> {
  static final provider =
      StateNotifierProvider.autoDispose<BookmarkProvider, GeneralState>(
    (ref) {
      final eventBus = ref.watch(AppEvent.busProvider);
      final bookmarksNotifier = ref.read(bookmarkedUserIdsProvider.notifier);
      return BookmarkProvider(eventBus, bookmarksNotifier)..loadBookmarks();
    },
  );

  final EventBus _eventBus;
  final BookmarkedUserIdsNotifier _bookmarksNotifier;

  BookmarkProvider(this._eventBus, this._bookmarksNotifier)
      : super(GeneralState.idle);

  Future<void> loadBookmarks() async {
    state = GeneralState.loading;
    try {
      await _bookmarksNotifier.loadBookmarks();
      state = GeneralState.success(_bookmarksNotifier.state);
    } catch (e) {
      _eventBus.fire(ErrorEvent(message: e.toString()));
      state = GeneralState.error(e.toString());
    }
  }

  Future<void> toggleBookmark(int userId) async {
    try {
      final isBookmarked = _bookmarksNotifier.isBookmarked(userId);

      if (isBookmarked) {
        await _bookmarksNotifier.removeBookmark(userId);
        _eventBus.fire(
          SuccessEvent(
            message: LocaleKeys.screens_bookmarks_removed_from_bookmarks.tr(),
          ),
        );
      } else {
        await _bookmarksNotifier.addBookmark(userId);
        _eventBus.fire(
          SuccessEvent(
            message: LocaleKeys.screens_bookmarks_added_to_bookmarks.tr(),
          ),
        );
      }
    } catch (e) {
      _eventBus.fire(ErrorEvent(message: e.toString()));
    }
  }

  Future<bool> isBookmarked(int userId) async {
    return _bookmarksNotifier.isBookmarked(userId);
  }

  Future<void> clearAllBookmarks() async {
    try {
      await _bookmarksNotifier.clearAllBookmarks();
      _eventBus.fire(
        SuccessEvent(
          message: LocaleKeys.screens_bookmarks_all_bookmarks_cleared.tr(),
        ),
      );
    } catch (e) {
      _eventBus.fire(ErrorEvent(message: e.toString()));
    }
  }
}

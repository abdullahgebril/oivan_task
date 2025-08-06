import 'package:easy_localization/easy_localization.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class DateFormatter {
  DateFormatter._();

  static String formatTimestamp(int? timestamp, {String? format}) {
    if (timestamp == null) return LocaleKeys.date_unknown_date.tr();

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final dateFormat = DateFormat(format ?? 'MMM dd, yyyy - hh:mm a');
    return dateFormat.format(date);
  }

  static String formatShortDate(int? timestamp) {
    return formatTimestamp(timestamp, format: 'MMM dd, yyyy');
  }

  static String formatTime(int? timestamp) {
    return formatTimestamp(timestamp, format: 'hh:mm a');
  }

  static String formatRelativeTime(int? timestamp) {
    if (timestamp == null) return LocaleKeys.date_unknown_time.tr();

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return difference.inDays == 1
          ? LocaleKeys.date_days_ago
              .tr(namedArgs: {'count': '${difference.inDays}'})
          : LocaleKeys.date_days_ago_plural
              .tr(namedArgs: {'count': '${difference.inDays}'});
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? LocaleKeys.date_hours_ago
              .tr(namedArgs: {'count': '${difference.inHours}'})
          : LocaleKeys.date_hours_ago_plural
              .tr(namedArgs: {'count': '${difference.inHours}'});
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? LocaleKeys.date_minutes_ago
              .tr(namedArgs: {'count': '${difference.inMinutes}'})
          : LocaleKeys.date_minutes_ago_plural
              .tr(namedArgs: {'count': '${difference.inMinutes}'});
    } else {
      return LocaleKeys.date_just_now.tr();
    }
  }

  static String formatDetailedWithRelative(int? timestamp) {
    if (timestamp == null) return LocaleKeys.date_unknown_date.tr();

    final formatted = formatTimestamp(timestamp);
    final relative = formatRelativeTime(timestamp);
    return '$formatted ($relative)';
  }

  static String formatForList(int? timestamp) {
    if (timestamp == null) return LocaleKeys.date_unknown_date.tr();

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return formatShortDate(timestamp);
    } else if (difference.inDays > 0) {
      return formatRelativeTime(timestamp);
    } else {
      return formatTime(timestamp);
    }
  }
}

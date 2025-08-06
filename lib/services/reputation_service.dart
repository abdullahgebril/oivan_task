import 'package:flutter/material.dart';
import 'package:oivan_task/core/constants/app_colors.dart';

class ReputationService {
  ReputationService._();

  /// Gets the appropriate icon for a reputation history type
  static IconData getReputationIcon(String? type) {
    if (type == null) return Icons.trending_up;

    switch (type.toLowerCase()) {
      case 'post_upvoted':
      case 'answer_upvoted':
      case 'question_upvoted':
        return Icons.arrow_upward;

      case 'post_downvoted':
      case 'answer_downvoted':
      case 'question_downvoted':
        return Icons.arrow_downward;

      case 'answer_accepted':
        return Icons.check_circle;

      case 'bounty_earned':
      case 'bounty_won':
        return Icons.star;

      case 'bounty_given':
      case 'bounty_offered':
        return Icons.card_giftcard;

      case 'suggested_edit_approval_received':
      case 'edit_approved':
        return Icons.edit;

      case 'post_deleted':
      case 'answer_deleted':
        return Icons.delete;

      case 'post_flagged':
        return Icons.flag;

      case 'user_suspended':
        return Icons.pause_circle;

      case 'reputation_cap':
        return Icons.stop_circle;

      case 'vote_fraud_reversal':
        return Icons.undo;

      case 'association_bonus':
        return Icons.link;

      case 'privilege_earned':
        return Icons.verified_user;

      default:
        return Icons.trending_up;
    }
  }

  static Color getReputationColor(int? change) {
    if (change == null) return AppColors.mediumGrey;

    if (change > 0) return AppColors.successColor;
    if (change < 0) return AppColors.errorColor;
    return AppColors.mediumGrey;
  }

  static Color getReputationColorByType(String? type, int? change) {
    if (type == null || change == null) return getReputationColor(change);

    switch (type.toLowerCase()) {
      case 'bounty_earned':
      case 'bounty_won':
        return AppColors.orangeTheme;

      case 'answer_accepted':
        return AppColors.successColor;

      case 'association_bonus':
        return AppColors.blueTheme;

      case 'privilege_earned':
        return AppColors.tealTheme;

      case 'vote_fraud_reversal':
      case 'user_suspended':
        return AppColors.errorColor;

      default:
        return getReputationColor(change);
    }
  }

  static String formatReputationChange(int? change) {
    if (change == null) return '0';

    if (change > 0) return '+$change';
    return change.toString();
  }

  static String getReputationDescription(String? type) {
    if (type == null) return 'Unknown Activity';

    switch (type.toLowerCase()) {
      case 'post_upvoted':
        return 'Post Upvoted';
      case 'post_downvoted':
        return 'Post Downvoted';
      case 'answer_upvoted':
        return 'Answer Upvoted';
      case 'answer_downvoted':
        return 'Answer Downvoted';
      case 'question_upvoted':
        return 'Question Upvoted';
      case 'question_downvoted':
        return 'Question Downvoted';
      case 'answer_accepted':
        return 'Answer Accepted';
      case 'bounty_earned':
        return 'Bounty Earned';
      case 'bounty_won':
        return 'Bounty Won';
      case 'bounty_given':
        return 'Bounty Given';
      case 'bounty_offered':
        return 'Bounty Offered';
      case 'suggested_edit_approval_received':
        return 'Edit Approved';
      case 'edit_approved':
        return 'Edit Approved';
      case 'post_deleted':
        return 'Post Deleted';
      case 'answer_deleted':
        return 'Answer Deleted';
      case 'post_flagged':
        return 'Post Flagged';
      case 'user_suspended':
        return 'User Suspended';
      case 'reputation_cap':
        return 'Daily Reputation Cap';
      case 'vote_fraud_reversal':
        return 'Vote Fraud Reversal';
      case 'association_bonus':
        return 'Association Bonus';
      case 'privilege_earned':
        return 'Privilege Earned';
      default:
        return type
            .replaceAll('_', ' ')
            .split(' ')
            .map((word) => word.isNotEmpty
                ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                : '')
            .join(' ');
    }
  }

  static bool isSignificantChange(int? change) {
    if (change == null) return false;
    return change.abs() >= 10;
  }

  static IconData getReputationTrendIcon(int? change) {
    if (change == null) return Icons.horizontal_rule;

    if (change > 0) return Icons.trending_up;
    if (change < 0) return Icons.trending_down;
    return Icons.horizontal_rule;
  }
}

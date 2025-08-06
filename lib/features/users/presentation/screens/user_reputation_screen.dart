import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';
import 'package:oivan_task/features/users/presentation/providers/users_provider.dart';
import 'package:oivan_task/features/users/presentation/widgets/reputation_history_list.dart';
import 'package:oivan_task/features/users/presentation/widgets/user_profile_header.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class UserReputationScreen extends ConsumerWidget {
  final int userId;

  const UserReputationScreen({
    super.key,
    required this.userId,
  });

  UserModel? _getUserData(WidgetRef ref) {
    final usersState = ref.watch(usersStateProvider);
    try {
      return usersState.users.firstWhere((user) => user.userId == userId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = _getUserData(ref);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          LocaleKeys.screens_reputation_title.tr(),
          style: AppTextTheme.appBarTitle,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Column(
        children: [
          if (user != null) UserProfileHeader(user: user),
          Expanded(
            child: ReputationHistoryList(userId: userId),
          ),
        ],
      ),
    );
  }
}

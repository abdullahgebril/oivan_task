import 'package:flutter/material.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';

class UserAvatar extends StatelessWidget {
  final UserModel user;
  final double size;
  final String? heroTag;

  const UserAvatar({
    super.key,
    required this.user,
    required this.size,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.profilePlaceholder,
        image: user.profileImage != null
            ? DecorationImage(
                image: NetworkImage(user.profileImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: user.profileImage == null
          ? Center(
              child: Text(
                user.displayName.isNotEmpty
                    ? user.displayName[0].toUpperCase()
                    : '?',
                style: AppTextTheme.userProfileInitial,
              ),
            )
          : null,
    );

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: avatar,
      );
    }

    return avatar;
  }
}

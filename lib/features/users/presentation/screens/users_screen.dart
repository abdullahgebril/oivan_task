import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/features/users/presentation/providers/users_provider.dart';
import 'package:oivan_task/features/users/presentation/widgets/user_card.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/shared/widgets/empty_state_widget.dart';
import 'package:oivan_task/shared/widgets/error_state_widget.dart';
import 'package:oivan_task/shared/widgets/loading_widget.dart';
import 'package:oivan_task/core/states/general_state.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(UsersProvider.provider.notifier).fetchUsers();
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(UsersProvider.provider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(UsersProvider.provider);
    final usersState = ref.watch(usersStateProvider);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          LocaleKeys.screens_users_title.tr(),
          style: AppTextTheme.appBarTitle,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(UsersProvider.provider.notifier)
              .fetchUsers(isRefresh: true);
        },
        color: AppColors.primaryColor,
        child: state.when(
          idle: () => const LoadingWidget(),
          loading: () => const LoadingWidget(),
          failure: () => const ErrorStateWidget(),
          onSuccess: (_) {
            if (usersState.users.isEmpty) {
              return EmptyStateWidget(
                title: LocaleKeys.screens_users_empty_title.tr(),
                subtitle: LocaleKeys.screens_users_empty_subtitle.tr(),
                icon: Icons.people_outline,
              );
            }

            return ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              cacheExtent: 500,
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              padding: EdgeInsets.only(
                  top: AppDimensions.paddingS.h,
                  bottom: AppDimensions.bottomNavHeight.h),
              itemCount:
                  usersState.users.length + (usersState.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == usersState.users.length) {
                  return Padding(
                    padding: EdgeInsets.all(AppDimensions.paddingL.h),
                    child: const LoadingWidget(),
                  );
                }

                return RepaintBoundary(
                  child: UserCard(
                    user: usersState.users[index],
                    index: index,
                  ),
                );
              },
            );
          },
          onError: (message) => ErrorStateWidget(
            message: message,
            onRetry: () {
              ref
                  .read(UsersProvider.provider.notifier)
                  .fetchUsers(isRefresh: true);
            },
          ),
        ),
      ),
    );
  }
}

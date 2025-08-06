import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:oivan_task/core/constants/app_colors.dart';

class ToastNotificationService {
  const ToastNotificationService();

  void showSuccess(String message, {BuildContext? context}) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 2),
      primaryColor: AppColors.successColor,
      showProgressBar: true,
      dragToClose: true,
    );
  }

  void showError(String? message, {BuildContext? context}) {
    final displayMessage =
        message?.isNotEmpty == true ? message! : 'An error occurred';

    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(displayMessage),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 2),
      primaryColor: AppColors.errorColor,
      showProgressBar: true,
      dragToClose: true,
    );
  }

  void showInfo(String message, {BuildContext? context}) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      title: Text(message),
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 2),
      primaryColor: AppColors.infoColor,
      showProgressBar: true,
      dragToClose: true,
    );
  }
}

final toastNotificationService = ToastNotificationService();

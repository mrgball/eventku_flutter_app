import 'package:event_app/core/config/extension.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required BuildContext context,
  required String message,
  ToastificationType type = ToastificationType.info,
  Duration duration = const Duration(seconds: 4),
  ToastificationStyle style = ToastificationStyle.minimal,
}) {
  toastification.show(
    context: context,
    type: type,
    title: Text(message, style: context.text.bodyMedium),
    style: style,
    alignment: Alignment.topCenter,
    autoCloseDuration: duration,
    closeButtonShowType: CloseButtonShowType.onHover,
    borderRadius: BorderRadius.circular(12),
    animationDuration: const Duration(milliseconds: 300),
  );
}

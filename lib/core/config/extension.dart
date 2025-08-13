import 'dart:async';

import 'package:flutter/material.dart';

extension ScreenUtil on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;

  double get dw => MediaQuery.of(this).size.width;

  double get dh => MediaQuery.of(this).size.height;

  Color get primaryColor => Theme.of(this).colorScheme.primary;

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get inversePrimary => Theme.of(this).colorScheme.inversePrimary;

  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;

  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;

  Color get surface => Theme.of(this).colorScheme.surface;

  Color get surfaceVariant => Theme.of(this).colorScheme.surfaceVariant;

  Color get inverseSurface => Theme.of(this).colorScheme.inverseSurface;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  Color get background => Theme.of(this).colorScheme.background;

  Color get outline => Theme.of(this).colorScheme.outline;

  Color get hintColor => Theme.of(this).hintColor;

  Color get disableColor => Theme.of(this).disabledColor;

  // Text and Icon Color
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get onSecondaryContainer =>
      Theme.of(this).colorScheme.onSecondaryContainer;

  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;

  Color get onTertiaryContainer =>
      Theme.of(this).colorScheme.onTertiaryContainer;

  Color get onError => Theme.of(this).colorScheme.onError;

  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  Color get onBackground => Theme.of(this).colorScheme.onBackground;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;

  Color get onInverseSurface => Theme.of(this).colorScheme.onInverseSurface;
}

extension FlashDialogExtension on BuildContext {
  void showBlockDialog({String? message, required Completer completer}) {
    // Tampilkan full-screen blocking dialog
    showDialog(
      context: this,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder:
          (_) => WillPopScope(
            onWillPop: () async => false,
            child: const Center(child: CircularProgressIndicator()),
          ),
    );

    // Auto close saat completer selesai
    completer.future.whenComplete(() {
      if (Navigator.of(this, rootNavigator: true).canPop()) {
        Navigator.of(this, rootNavigator: true).pop();
      }
    });
  }
}

extension CurrencyExtension on num {
  String get displayRupiah {
    final str = toStringAsFixed(0);
    final buffer = StringBuffer();
    final reversed = str.split('').reversed.toList();

    for (var i = 0; i < reversed.length; i++) {
      if (i != 0 && i % 3 == 0) buffer.write('.');
      buffer.write(reversed[i]);
    }

    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }
}

import 'package:flutter/material.dart';
import 'package:event_app/core/config/extension.dart';

enum ButtonVariant { filled, outline }

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final ButtonVariant variant;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = variant == ButtonVariant.filled;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? Colors.deepPurple : Colors.transparent,
          foregroundColor: isFilled ? Colors.white : Colors.deepPurple,
          elevation: isFilled ? 2 : 0,
          side:
              isFilled
                  ? null
                  : const BorderSide(color: Colors.deepPurple, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: context.text.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isFilled ? Colors.white : Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}

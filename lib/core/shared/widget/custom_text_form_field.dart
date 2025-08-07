import 'package:event_app/core/config/extension.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLines;
  final IconData? prefixIcon;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.maxLines = 1,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    final obscureNotifier = ValueNotifier<bool>(isPassword);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: obscureNotifier,
          builder: (context, obscure, _) {
            return TextFormField(
              controller: controller,
              style: context.text.bodyMedium?.copyWith(
                color: context.onBackground,
              ),
              keyboardType: keyboardType,
              obscureText: (isPassword) ? obscure : false,
              validator: validator,
              maxLines: maxLines,
              textInputAction: textInputAction,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: context.text.bodySmall?.copyWith(
                  color: context.disableColor,
                ),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                suffixIcon:
                    isPassword
                        ? IconButton(
                          icon: Icon(
                            size: 18,
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            obscureNotifier.value = !obscureNotifier.value;
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/shared/widget/custom_button.dart';
import 'package:event_app/core/shared/widget/custom_text_form_field.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Login to your account!',
                    style: context.text.titleLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                _buildForm(controller: _emailCont, title: 'Email'),
                SizedBox(height: 16),
                _buildForm(
                  controller: _passwordCont,
                  title: 'Password',
                  isPassword: true,
                  isLast: true,
                ),
                SizedBox(height: 32),
                CustomButton(
                  title: 'Login Now',
                  onPressed:
                      () => context.read<AuthBloc>().add(
                        LoginAccountEvent(
                          email: _emailCont.text,
                          password: _passwordCont.text,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm({
    required TextEditingController controller,
    required String title,
    bool isLast = false,
    bool isPassword = false,
  }) {
    return CustomTextFormField(
      isPassword: isPassword,
      label: title,
      hintText: 'Input your ${title.toLowerCase()}',
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$title cannot be empty';
        }
        return null;
      },
      textInputAction: (isLast) ? TextInputAction.done : TextInputAction.next,
    );
  }
}

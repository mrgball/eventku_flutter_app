import 'package:event_app/core/config/constant.dart';
import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/shared/widget/custom_button.dart';
import 'package:event_app/core/shared/widget/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullnameCont = TextEditingController();
  final TextEditingController _usernameCont = TextEditingController();
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  final TextEditingController _confirmPassCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: context.dw * 0.2),
                Center(
                  child: Text(
                    'REGISTER YOUR ACCOUNT NOW!',
                    style: context.text.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: context.dw * 0.08),
                _buildForm(controller: _fullnameCont, title: 'Fullname'),
                SizedBox(height: 16),
                _buildForm(controller: _usernameCont, title: 'Username'),
                SizedBox(height: 16),
                _buildForm(controller: _emailCont, title: 'Email'),
                SizedBox(height: 16),
                _buildForm(
                  controller: _passwordCont,
                  title: 'Password',
                  isPassword: true,
                ),
                SizedBox(height: 16),
                _buildForm(
                  controller: _confirmPassCont,
                  title: 'Confirm Password',
                  isLast: true,
                  isPassword: true,
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      text: "Already have account? ",
                      style: context.text.bodySmall,
                      children: [
                        TextSpan(
                          text: "Login now",
                          style: context.text.bodySmall?.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => Navigator.of(
                                      context,
                                    ).pushNamed(Constant.routeLogin),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32),
                CustomButton(
                  title: 'Register Now',
                  variant: ButtonVariant.filled,
                  onPressed: () {},
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

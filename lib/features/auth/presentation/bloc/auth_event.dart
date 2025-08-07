part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterAccountEvent extends AuthEvent {
  final String fullname;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterAccountEvent({
    required this.fullname,
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    fullname,
    email,
    username,
    password,
    confirmPassword,
  ];
}

class LoginAccountEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginAccountEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

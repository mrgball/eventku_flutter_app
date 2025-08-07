part of 'auth_bloc.dart';

class AuthState extends Equatable with ErrorResponseState {
  final BlocStatus status;
  final User? user;

  @override
  final String message;
  @override
  final List<String>? errMessage;
  @override
  final String? errorCode;

  const AuthState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.errMessage = const [],
    this.errorCode,
    this.user,
  });

  AuthState copyWith({
    BlocStatus? status,
    String? message,
    List<String>? errMessage,
    String? errorCode,
    User? user,
  }) => AuthState(
    status: status ?? this.status,
    message: message ?? this.message,
    errMessage: errMessage,
    errorCode: errorCode,
    user: user,
  );

  @override
  List<Object?> get props => [status, message, errMessage, errorCode, user];
}

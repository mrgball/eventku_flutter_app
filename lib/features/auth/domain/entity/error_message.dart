import 'package:equatable/equatable.dart';

class ErrorMessage extends Equatable {
  final String field;
  final String message;

  const ErrorMessage({required this.field, required this.message});

  @override
  List<Object?> get props => [field, message];
}

import 'package:event_app/core/shared/base_usecase.dart';
import 'package:event_app/features/auth/domain/repository/auth_repository.dart';

class RegisterAccountUseCase
    implements BaseUsecase<Map<String, dynamic>, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  RegisterAccountUseCase(this._authRepository);

  @override
  Future<Map<String, dynamic>> call({Map<String, dynamic>? params}) {
    return _authRepository.registerAccount(params);
  }
}

class LoginAccountUseCase
    implements BaseUsecase<Map<String, dynamic>, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  LoginAccountUseCase(this._authRepository);

  @override
  Future<Map<String, dynamic>> call({Map<String, dynamic>? params}) {
    return _authRepository.loginAccount(params);
  }
}

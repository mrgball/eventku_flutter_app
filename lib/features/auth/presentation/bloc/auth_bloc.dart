import 'dart:async';

import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/config/global.dart';
import 'package:event_app/core/helper/storage_service.dart.dart';
import 'package:event_app/core/shared/mixin/error_response_state.dart';
import 'package:event_app/core/shared/widget/custom_toast.dart';
import 'package:event_app/core/utils/app_exceptions.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/auth/data/model/user_model.dart';
import 'package:event_app/features/auth/domain/entity/user.dart';
import 'package:event_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/config/enum.dart';
import 'package:toastification/toastification.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _storageService = locator<StorageService>();

  AuthBloc() : super(AuthState()) {
    on<RegisterAccountEvent>(_onRegisterAccount);
    on<LoginAccountEvent>(_onLoginAccount);
  }

  void _onLoginAccount(LoginAccountEvent event, Emitter<AuthState> emit) async {
    final completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      final response = await locator<LoginAccountUseCase>().call(
        params: {'identifier': event.email, 'password': event.password},
      );

      if (response.isEmpty) {
        throw DataException(message: 'Gagal login');
      }

      //  save accessToken
      await _storageService.saveAccessToken(response['accessToken']);

      // save refreshToken
      await _storageService.saveRefreshToken(response['refreshToken']);

      // 2. Simpan user ke model (opsional, tergantung kamu pakai bloc/cubit/state mgmt apa)
      emit(state.copyWith(user: UserModel.fromJson(response['user'])));

      // 3. Tampilkan toast sukses
      showToast(
        context: gNavigatorKey.currentContext!,
        message: 'Berhasil Login',
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
      );

      if (!completer.isCompleted) {
        completer.complete();
      }

      await Future.delayed(Duration(milliseconds: 100));

      // 4. Navigasi ke halaman utama
      Navigator.of(gNavigatorKey.currentContext!).pushReplacementNamed('/home');
    } on DataException catch (e, s) {
      print('error data except: $e \n $s');

      showToast(
        context: gNavigatorKey.currentContext!,
        message: e.message,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );
      emit(
        state.copyWith(
          message: e.message,
          errMessage: e.errMessage,
          errorCode: e.errorCode,
        ),
      );
    } catch (e, s) {
      print('error data except: $e \n $s');

      showToast(
        context: gNavigatorKey.currentContext!,
        message: e.toString(),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );
      emit(state.copyWith(message: 'Terjadi kesalahan Sistem.'));
    } finally {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }

  void _onRegisterAccount(
    RegisterAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    var completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      final response = await locator<RegisterAccountUseCase>().call(
        params: {
          'fullname': event.fullname,
          'username': event.username,
          'email': event.email,
          'password': event.password,
          'confirmPassword': event.confirmPassword,
        },
      );

      if (response.isEmpty) {
        throw DataException(message: 'Gagal register');
      }

      showToast(
        context: gNavigatorKey.currentContext!,
        message: 'Success Register',
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
      );
    } on DataException catch (e) {
      showToast(
        context: gNavigatorKey.currentContext!,
        message: e.message,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );

      emit(
        state.copyWith(
          message: e.message,
          errMessage: e.errMessage,
          errorCode: e.errorCode,
        ),
      );
    } catch (e) {
      showToast(
        context: gNavigatorKey.currentContext!,
        message: e.toString(),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );

      emit(state.copyWith(message: 'Terjadi kesalahan Sistem.'));
    } finally {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }
}

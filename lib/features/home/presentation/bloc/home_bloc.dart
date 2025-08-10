import 'dart:async';

import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/config/global.dart';
import 'package:event_app/core/shared/mixin/error_response_state.dart';
import 'package:event_app/core/shared/widget/custom_toast.dart';
import 'package:event_app/core/utils/app_exceptions.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/auth/domain/entity/user.dart';
import 'package:event_app/features/event/data/model/event_model.dart';
import 'package:event_app/features/event/domain/entity/event.dart';
import 'package:event_app/features/home/data/model/banner_model.dart';
import 'package:event_app/features/home/domain/entity/banner.dart';
import 'package:event_app/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/config/enum.dart';
import 'package:toastification/toastification.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Map<String, List<Banner>> _cacheListBanner = {};
  final Map<String, List<Event>> _cacheListPopularEvent = {};

  HomeBloc() : super(HomeState()) {
    on<FetchBannerEvent>(_onFetchBanner);
    on<FetchPopularEvent>(_onFetchPopularEvents);
    on<FetchHomeEndpointEvent>(_onFetchHomeEndpoint);
  }

  void _onFetchHomeEndpoint(
    FetchHomeEndpointEvent event,
    Emitter<HomeState> emit,
  ) async {
    var completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      add(FetchBannerEvent(user: event.user));
      add(FetchPopularEvent(user: event.user));
    } catch (e) {
      showToast(
        context: gNavigatorKey.currentContext!,
        message: e.toString(),
        style: ToastificationStyle.flatColored,
        type: ToastificationType.error,
      );

      if (!completer.isCompleted) {
        completer.complete();
      }
    } finally {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }

  void _onFetchPopularEvents(
    FetchPopularEvent event,
    Emitter<HomeState> emit,
  ) async {
    String key = event.user?.id ?? '';

    try {
      emit(state.copyWith(eventStatus: BlocStatus.loading));

      if (!event.isRefresh && _cacheListPopularEvent.containsKey(key)) {
        emit(
          state.copyWith(
            eventStatus: BlocStatus.success,
            listPopularEvent: _cacheListPopularEvent[key],
          ),
        );
        return;
      }

      final response = await locator<FetchPopularEventsUseCase>().call();

      if (response.isEmpty) {
        throw DataException(message: 'Data events tidak ditemukan');
      }

      _cacheListPopularEvent[key] =
          response.map((event) => EventModel.fromJson(event)).toList();

      emit(
        state.copyWith(
          eventStatus: BlocStatus.success,
          listPopularEvent: _cacheListPopularEvent[key],
        ),
      );
    } catch (e, s) {
      print('err fetch popular events: $e \n $s');
      emit(state.copyWith(eventStatus: BlocStatus.error, listPopularEvent: []));
    }
  }

  void _onFetchBanner(FetchBannerEvent event, Emitter<HomeState> emit) async {
    String key = event.user?.id ?? '';

    try {
      emit(state.copyWith(bannerStatus: BlocStatus.loading));

      if (!event.isRefresh && _cacheListBanner.containsKey(key)) {
        emit(
          state.copyWith(
            bannerStatus: BlocStatus.success,
            listBanner: _cacheListBanner[key],
          ),
        );
        return;
      }

      final response = await locator<FetchBannerUseCase>().call(
        params: {'limit': 10, 'page': 1},
      );

      if (response.isEmpty) {
        throw DataException(message: 'gagal fetch banner');
      }

      _cacheListBanner[key] =
          response.map<Banner>((item) => BannerModel.fromJson(item)).toList();

      emit(
        state.copyWith(
          bannerStatus: BlocStatus.success,
          listBanner: _cacheListBanner[key],
        ),
      );
    } on DataException catch (e, s) {
      print('error data except : $e \n $s');

      emit(
        state.copyWith(
          bannerStatus: BlocStatus.error,
          listBanner: [],
          errMessage: e.errMessage,
          errorCode: e.errorCode,
          message: e.message,
        ),
      );
    } catch (e, s) {
      print('error catch : $e \n $s');
      emit(state.copyWith(bannerStatus: BlocStatus.error, listBanner: []));
    }
  }
}

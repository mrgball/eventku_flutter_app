part of 'home_bloc.dart';

class HomeState extends Equatable with ErrorResponseState {
  // BANNER
  final BlocStatus bannerStatus;
  final List<Banner> listBanner;

  // POPULAR EVENTS
  final BlocStatus eventStatus;
  final List<Event> listPopularEvent;

  @override
  final String message;
  @override
  final List<String>? errMessage;
  @override
  final String? errorCode;

  const HomeState({
    this.bannerStatus = BlocStatus.initial,
    this.eventStatus = BlocStatus.initial,
    this.listBanner = const [],
    this.listPopularEvent = const [],
    this.errMessage = const [],
    this.errorCode,
    this.message = '',
  });

  HomeState copyWith({
    BlocStatus? bannerStatus,
    BlocStatus? eventStatus,
    List<Banner>? listBanner,
    List<Event>? listPopularEvent,
    List<String>? errMessage,
    String? message,
    String? errorCode,
  }) => HomeState(
    bannerStatus: bannerStatus ?? this.bannerStatus,
    eventStatus: eventStatus ?? this.eventStatus,
    listBanner: listBanner ?? this.listBanner,
    listPopularEvent: listPopularEvent ?? this.listPopularEvent,
    message: message ?? this.message,
    errMessage: errMessage,
    errorCode: errorCode,
  );

  @override
  List<Object?> get props => [
    bannerStatus,
    eventStatus,
    listBanner,
    listPopularEvent,
    message,
    errMessage,
    errorCode,
  ];
}

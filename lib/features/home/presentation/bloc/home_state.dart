part of 'home_bloc.dart';

class HomeState extends Equatable with ErrorResponseState {
  final BlocStatus bannerStatus;
  final List<Banner> listBanner;

  @override
  final String message;
  @override
  final List<String>? errMessage;
  @override
  final String? errorCode;

  const HomeState({
    this.bannerStatus = BlocStatus.initial,
    this.listBanner = const [],
    this.errMessage = const [],
    this.errorCode,
    this.message = '',
  });

  HomeState copyWith({
    BlocStatus? bannerStatus,
    List<Banner>? listBanner,
    List<String>? errMessage,
    String? message,
    String? errorCode,
  }) => HomeState(
    bannerStatus: bannerStatus ?? this.bannerStatus,
    listBanner: listBanner ?? this.listBanner,
    message: message ?? this.message,
    errMessage: errMessage,
    errorCode: errorCode,
  );

  @override
  List<Object?> get props => [
    bannerStatus,
    listBanner,
    message,
    errMessage,
    errorCode,
  ];
}

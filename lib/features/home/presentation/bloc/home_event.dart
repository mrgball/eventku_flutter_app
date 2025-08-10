part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchBannerEvent extends HomeEvent {
  final bool isRefresh;
  final User? user;

  const FetchBannerEvent({this.isRefresh = false, required this.user});

  @override
  List<Object?> get props => [isRefresh, user];
}

class FetchPopularEvent extends HomeEvent {
  final bool isRefresh;
  final User? user;

  const FetchPopularEvent({this.isRefresh = false, required this.user});

  @override
  List<Object?> get props => [isRefresh, user];
}

class FetchHomeEndpointEvent extends HomeEvent {
  final User? user;

  const FetchHomeEndpointEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

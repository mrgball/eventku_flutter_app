part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchBannerEvent extends HomeEvent {
  final bool isRefresh;
  final User? user;

  const FetchBannerEvent({this.isRefresh = false, this.user});

  @override
  List<Object?> get props => [isRefresh, user];
}

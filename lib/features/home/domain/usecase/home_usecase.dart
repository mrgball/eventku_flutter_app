import 'package:event_app/core/shared/base_usecase.dart';
import 'package:event_app/features/home/domain/repository/home_repository.dart';

class FetchBannerUseCase implements BaseUsecase<List, Map<String, dynamic>> {
  final HomeRepository _homeRepository;

  FetchBannerUseCase(this._homeRepository);

  @override
  Future<List> call({Map<String, dynamic>? params}) {
    return _homeRepository.fetchBanner(params);
  }
}

class FetchPopularEventsUseCase
    implements BaseUsecase<List, Map<String, dynamic>> {
  final HomeRepository _homeRepository;

  FetchPopularEventsUseCase(this._homeRepository);

  @override
  Future<List> call({Map<String, dynamic>? params}) {
    return _homeRepository.fetchPopularEvents(params);
  }
}

abstract class HomeRepository {
  Future<List> fetchBanner(Map<String, dynamic>? params);
  Future<List> fetchPopularEvents(Map<String, dynamic>? params);
}

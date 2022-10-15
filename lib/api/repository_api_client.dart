import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'repository_api_client.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class RepositoryApiClient {
  factory RepositoryApiClient(Dio dio, {String baseUrl}) = _RepositoryApiClient;

  @GET('/search/repositories')
  Future<dynamic> fetch(
    /// application/vnd.github+json
    @Header('accept') String accept,
    @Query('q') String query,
    @Query('sort') String? sort,
    @Query('order') String? order,
    @Query('page') int? page,
    @Query('per_page') int? perPage,
  );
}

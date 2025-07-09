import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';
import '../../constants/app_endpoints.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Endpoints.site_url)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;
 // @GET(Endpoints.getPost)
 // Future<List<PostModel>> getAllPost();
}
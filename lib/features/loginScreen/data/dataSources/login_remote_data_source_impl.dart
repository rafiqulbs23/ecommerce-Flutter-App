

import 'package:ecommerce_app/core/services/network/rest_client.dart';
import 'package:injectable/injectable.dart';

import '../model/login_response.dart';
import 'login_remote_data_source.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final RestClient restClient;

  LoginRemoteDataSourceImpl({required this.restClient});

  @override
  Future<LoginResponse> login(Map<String,dynamic> loginRequest) async {
    final response = await restClient.login(loginRequest);
    return response;
  }
}
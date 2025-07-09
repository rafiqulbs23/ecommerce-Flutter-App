import '../model/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(Map <String, dynamic> loginRequest);
}
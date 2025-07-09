

import 'package:ecommerce_app/features/loginScreen/data/model/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login(Map <String, dynamic> request);
}
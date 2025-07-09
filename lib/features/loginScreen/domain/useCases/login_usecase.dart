
import 'package:injectable/injectable.dart';
import '../../data/model/login_response.dart';
import '../repository/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository _loginRepository;
  LoginUseCase(this._loginRepository);

  Future<LoginResponse> call(Map<String,dynamic> requestBody) async {
    return await _loginRepository.login(requestBody);
  }
}
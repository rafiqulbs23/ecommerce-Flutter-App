

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../data/model/login_response.dart';
import '../../domain/useCases/login_usecase.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login{
  late LoginUseCase useCase;


  @override
  AsyncValue<LoginResponse>? build() {
    useCase = getIt<LoginUseCase>();
    return null;
  }


  Future<void> postLogin(String username, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      Map<String,dynamic> requestBody = {
      'username': username,
      'password': password,
    //  'expiresInMins': 30, // optional, defaults to 60
      };
      final result = await useCase.call(requestBody);
      return result;
    });
  }

}
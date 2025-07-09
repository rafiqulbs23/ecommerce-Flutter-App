
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/login_repository.dart';
import '../dataSources/login_remote_data_source.dart';
import '../model/login_response.dart';
@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});
  @override
  Future<LoginResponse> login(Map<String,dynamic> request) async {

    try {
      return await remoteDataSource.login(request);
    }on DioException catch (e){
      print("Error in login repository: ${e.error}");
      throw Exception(e.error.toString());
    }

  }
}
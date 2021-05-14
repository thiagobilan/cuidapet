import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthInterceptorWrapper extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;
    if (DotEnv().env['profile'] == 'dev') {}
  }

  @override
  Future onResponse(Response response) async {
    if (DotEnv().env['profile'] == 'dev') {}
  }

  @override
  Future onError(DioError err) async {
    //Verificarse deu erro 403 ou 401
    return err;
  }
}

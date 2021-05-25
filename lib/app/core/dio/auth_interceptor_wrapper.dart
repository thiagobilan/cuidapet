import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/repository/security_storage_repository.dart';
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
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await _refreshToken();
      final req = err.request;
      return CustomDio.authInstance.request(req.path, options: req);
    }

    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();
    try {
      final refreshToken = await security.refreshToken;
      final accessToekn = prefs.accessToken;

      var refreshResut = await CustomDio.instance.put('/login/refresh', data: {
        'token': accessToekn,
        'refresh_token': refreshToken,
      });

      await prefs.registerAccessToken(refreshResut.data['access_token']);
      await security.registerRefreshToken(refreshResut.data['refresh_token']);
    } catch (e) {
      print(e);
      await prefs.logout();
    }
  }
}

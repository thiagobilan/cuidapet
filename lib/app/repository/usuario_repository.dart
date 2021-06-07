import 'dart:io';
import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/models/access_token_model.dart';
import 'package:cuida_pet/app/models/confirm_login_model.dart';
import 'package:cuida_pet/app/models/usuario_model.dart';
import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email,
      {String password, bool facebookLogin = false, String avatar = ''}) {
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': password,
      'facebookLogin': facebookLogin,
      'avatar': avatar
    }).then((value) => AccessTokenModel.fromJson(value.data));
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;

    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null
    }).then((value) => ConfirmLoginModel.fromJson(value.data));
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() {
    return CustomDio.authInstance
        .get('/usuario')
        .then((value) => UsuarioModel.fromJson(value.data));
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await CustomDio.instance
        .post('/login/cadastrar', data: {'email': email, 'senha': senha});
  }

  Future<UsuarioModel> updateImage(String urlImage) async {
    return CustomDio.authInstance.put('/usuario/avatar', data: {
      'url_avatar': urlImage
    }).then((res) => UsuarioModel.fromJson(res.data));
  }
}

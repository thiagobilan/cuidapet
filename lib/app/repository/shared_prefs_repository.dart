import 'dart:convert';

import 'package:cuida_pet/app/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN';
  static const _DEVICE_ID = '/DEVICE_ID';
  static const _DADOS_USUARIO = '/DADOS_USUARIO';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  void registerAccessToken(String token) {
    prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  void registerDeviceId(String deviceID) {
    prefs.setString(_DEVICE_ID, deviceID);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  void registerDadosUsuario(UsuarioModel usuario) {
    prefs.setString(_DADOS_USUARIO, jsonEncode(usuario));
  }

  UsuarioModel get dadosUsuario {
    return UsuarioModel.fromJson(jsonDecode(prefs.getString(_DADOS_USUARIO)));
  }
}

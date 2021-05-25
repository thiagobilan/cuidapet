import 'dart:convert';

import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/models/usuario_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN';
  static const _DEVICE_ID = '/DEVICE_ID';
  static const _DADOS_USUARIO = '/DADOS_USUARIO';
  static const _ENDERECO_SELECIONADO = '/ENDERECO';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
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

  Future<void> logout() async {
    await prefs.clear();
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }

  Future<void> registrarEnderecoSelecionado(EnderecoModel enderecoModel) async {
    await prefs.setString(_ENDERECO_SELECIONADO, enderecoModel.toJson());
  }

  Future<EnderecoModel> get enderecoSelecionado async {
    var enderecoJson = await prefs.getString(_ENDERECO_SELECIONADO);
    if (enderecoJson != null) {
      return EnderecoModel.fromJson(enderecoJson);
    }
    return null;
  }
}

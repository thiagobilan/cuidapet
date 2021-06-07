import 'package:cuida_pet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuida_pet/app/models/access_token_model.dart';
import 'package:cuida_pet/app/models/usuario_model.dart';
import 'package:cuida_pet/app/repository/facebook_repository.dart';
import 'package:cuida_pet/app/repository/security_storage_repository.dart';
import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:cuida_pet/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuarioServices {
  final UsuarioRepository _repository;
  UsuarioServices(
    this._repository,
  );
  Future<void> login({
    @required bool facebookLogin,
    String email,
    String password,
  }) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;
      if (!facebookLogin) {
        accessTokenModel = await _repository.login(
          email,
          password: password,
          avatar: '',
          facebookLogin: facebookLogin,
        );

        await fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        var facebookModel = await FacebookRepository().login();
        if (facebookModel != null) {
          accessTokenModel = await _repository.login(
            facebookModel.email,
            password: password,
            avatar: facebookModel.picture,
            facebookLogin: facebookLogin,
          );
          final facebookCredencial = FacebookAuthProvider.getCredential(
              accessToken: facebookModel.token);
          fireAuth.signInWithCredential(facebookCredencial);
        } else {
          throw AcessoNegadoException('Acesso Negado');
        }
      }
      prefs.registerAccessToken(accessTokenModel.accessToken);
      final confirmModel = await _repository.confirmLogin();
      prefs.registerAccessToken(confirmModel.accessToken);
      SecurityStorageRepository()
          .registerRefreshToken(confirmModel.refreshToken);
      final dadosUsuario = await _repository.recuperaDadosUsuarioLogado();
      prefs.registerDadosUsuario(dadosUsuario);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no Firebase $e');
      rethrow;
    } on DioError catch (e) {
      if (e.response.statusCode == 403) {
        throw AcessoNegadoException(e.response.data['message'], exception: e);
      } else {
        rethrow;
      }
    } catch (e) {
      print('Erro ao logar $e');
      rethrow;
    }
  }

  Future<void> cadastraUsuario(String email, String senha) async {
    var fireAuth = FirebaseAuth.instance;
    await fireAuth.createUserWithEmailAndPassword(
        email: email, password: senha);
    await _repository.cadastrarUsuario(email, senha);
  }

  Future<UsuarioModel> atualizarImagem(String urlImage) {
    return _repository.updateImage(urlImage);
  }
}

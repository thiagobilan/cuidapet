import 'package:cuida_pet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuida_pet/app/services/usuario_services.dart';
import 'package:cuida_pet/app/shared/components/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioServices _service;
  GlobalKey<FormState> formKey = GlobalKey();
  @observable
  bool mostrarSenha = false;
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  _LoginControllerBase(this._service);

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(
            facebookLogin: false,
            email: loginController.text,
            password: senhaController.text);
        Loader.hide();
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', e.msg);
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Error ao realizar Login');
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _service.login(facebookLogin: true);
      Loader.hide();
      Modular.to.pushReplacementNamed('/');
    } on AcessoNegadoException catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Erro', 'Login ou senha inválidos');
    } catch (e) {
      Loader.hide();
      print('ERRO AQUI É $e');
      Get.snackbar('Erro', 'Erro ao realizar login');
    }
  }

  @action
  void mostraSenha() {
    mostrarSenha = !mostrarSenha;
  }
}

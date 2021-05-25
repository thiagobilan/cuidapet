import 'package:cuida_pet/app/services/usuario_services.dart';
import 'package:cuida_pet/app/shared/components/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioServices _services;
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool esconderSenha = false;

  @observable
  bool esconderConfirmaSenha = false;

  _CadastroControllerBase(this._services);

  @action
  void mostrarSenha() => esconderSenha = !esconderSenha;
  @action
  void mostrarConfirmaSenha() => esconderConfirmaSenha = !esconderConfirmaSenha;

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        await _services.cadastraUsuario(
            loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } catch (e) {
        Loader.hide();
        Get.snackbar('Erro', 'Erro ao cadastrar Usuario');
        print(e);
      }
    }
  }
}

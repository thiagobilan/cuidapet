import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/services/enderecos_services.dart';
import 'package:cuida_pet/app/shared/components/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'detalhe_controller.g.dart';

class DetalheController = _DetalheControllerBase with _$DetalheController;

abstract class _DetalheControllerBase with Store {
  TextEditingController complementoController = TextEditingController();
  final EnderecosServices _service;

  _DetalheControllerBase(this._service);

  Future<void> salvarEndereco(EnderecoModel model) async {
    try {
      Loader.show();
      model.complemento = complementoController.text;
      await _service.salvarEndereco(model);
      Loader.hide();
      Modular.to.pop();
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Erro ao savar endereço');
    }
  }
}

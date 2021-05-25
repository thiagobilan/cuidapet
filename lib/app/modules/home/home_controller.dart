import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/services/enderecos_services.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  EnderecosServices _enderecosServices;
  _HomeControllerBase(
    this._enderecosServices,
  );

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
    print('Esperando Endereço');
  }

  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecosServices.existeEnderecoCadastrado();
    if (!temEndereco) {
      await Modular.link.pushNamed('/enderecos');
    }
  }
}

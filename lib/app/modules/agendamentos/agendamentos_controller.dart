import 'package:cuida_pet/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:cuida_pet/app/services/agendamento_service.dart';
import 'package:cuida_pet/app/shared/viewsModels/agendamento_vm.dart';

part 'agendamentos_controller.g.dart';

class AgendamentosController = _AgendamentosControllerBase
    with _$AgendamentosController;

abstract class _AgendamentosControllerBase with Store {
  final AgendamentoService _agendamentoService;
  _AgendamentosControllerBase(
    this._agendamentoService,
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController petController = TextEditingController();

  @observable
  DateTime dataSelecionada = DateTime.now();
  @observable
  TimeOfDay horarioSelecionada = TimeOfDay.now();

  @action
  void alterarData(DateTime data) {
    dataSelecionada = data;
  }

  @action
  void alterarHorario(TimeOfDay horarios) {
    horarioSelecionada = horarios;
  }

  @action
  Future<void> salvarAgendamento(
      {int estabelecimento, List<FornecedorServicosModel> servicos}) async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        var viewModel = AgendamentoVM(
            fornecedorID: estabelecimento,
            dataHora: DateTime(
              dataSelecionada.year,
              dataSelecionada.month,
              dataSelecionada.day,
              horarioSelecionada.hour,
              horarioSelecionada.minute,
              0,
            ),
            nomeReserva: nomeController.text,
            nomePet: petController.text,
            servicos: servicos);
        await _agendamentoService.salvarAgendamento(viewModel);
        Loader.hide();
        Get.snackbar('Sucesso',
            'Agendamento realizado com sucesso, Aguarde a confirmação');

        Future.delayed(
            Duration(seconds: 3),
            () async => await Modular.to
                .pushNamedAndRemoveUntil('/', ModalRoute.withName('/')));
      } on Exception catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao salvar agendamento');
      }
    }
  }
}

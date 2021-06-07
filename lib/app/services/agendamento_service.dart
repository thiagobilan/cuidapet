import 'package:cuida_pet/app/models/agendamento_model.dart';
import 'package:cuida_pet/app/repository/agendamento_repository.dart';
import 'package:cuida_pet/app/shared/viewsModels/agendamento_vm.dart';
import 'package:flutter/cupertino.dart';

class AgendamentoService {
  final AgendamentoRepository _repository;
  AgendamentoService(
    this._repository,
  );

  Future<void> salvarAgendamento(AgendamentoVM agendamentoVM) async {
    await _repository.salvarAgendamento(agendamentoVM);
  }

  Future<List<AgendamentoModel>> buscarAgendamento() async {
    return _repository.buscarAgendamento();
  }
}

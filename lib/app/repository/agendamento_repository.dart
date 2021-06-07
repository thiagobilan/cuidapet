import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/models/agendamento_model.dart';
import 'package:cuida_pet/app/shared/viewsModels/agendamento_vm.dart';

class AgendamentoRepository {
  Future<void> salvarAgendamento(AgendamentoVM agendamento) async {
    await CustomDio.authInstance.post('/agendamento/agendar', data: {
      'data_agendamento': agendamento.dataHora.toIso8601String(),
      'fornecedor_id': agendamento.fornecedorID,
      'servicos': agendamento.servicos.map<int>((e) => e.id).toList(),
      'nome': agendamento.nomeReserva,
      'nome_pet': agendamento.nomePet
    });
  }

  Future<List<AgendamentoModel>> buscarAgendamento() async {
    return await CustomDio.authInstance.get('/agendamentos').then((res) => res
        .data
        .map<AgendamentoModel>((a) => AgendamentoModel.fromJson(a))
        .toList());
  }
}

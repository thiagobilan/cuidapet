import 'package:cuida_pet/app/models/agendamento_model.dart';
import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:cuida_pet/app/services/agendamento_service.dart';
import 'package:mobx/mobx.dart';

part 'meusagendamentos_controller.g.dart';

class MeusagendamentosController = _MeusagendamentosControllerBase
    with _$MeusagendamentosController;

abstract class _MeusagendamentosControllerBase with Store {
  final AgendamentoService _service;

  _MeusagendamentosControllerBase(this._service);
  @observable
  ObservableFuture<List<AgendamentoModel>> agendamentosFuture;

  @action
  void buscarAgendamento() {
    agendamentosFuture = ObservableFuture(_service.buscarAgendamento());
  }

  double valor;
  double calcularTotal(List<FornecedorServicosModel> lista) {
    valor = 0.0;
    lista.forEach((e) {
      valor += e.valor;
    });
    return valor;
  }
}

import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/models/fornecedor_model.dart';
import 'package:cuida_pet/app/services/fornecedor_service.dart';

part 'estabelecimento_controller.g.dart';

class EstabelecimentoController = _EstabelecimentoControllerBase
    with _$EstabelecimentoController;

abstract class _EstabelecimentoControllerBase with Store {
  final FornecedorService _service;

  @observable
  ObservableFuture<FornecedorModel> fornecedorFuture;

  @observable
  ObservableFuture<List<FornecedorServicosModel>> fornecedorServicosFuture;

  @observable
  ObservableList<FornecedorServicosModel> servicosSelecionados =
      <FornecedorServicosModel>[].asObservable();

  _EstabelecimentoControllerBase(
    this._service,
  );
  @action
  void initPage(id) {
    fornecedorFuture = ObservableFuture(_service.buscarPorId(id));
    fornecedorServicosFuture =
        ObservableFuture(_service.buscarServicosFornecedor(id));
  }

  @action
  void adicionarOuRemoverServico(FornecedorServicosModel servico) {
    if (servicosSelecionados.contains(servico)) {
      print('REMOVIDO - ${servico.nome}');
      servicosSelecionados.remove(servico);
    } else {
      print('ADICIONADO - ${servico.nome}');
      servicosSelecionados.add(servico);
    }
  }
}

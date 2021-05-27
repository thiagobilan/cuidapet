import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:cuida_pet/app/models/categoria_model.dart';
import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:cuida_pet/app/services/categoria_service.dart';
import 'package:cuida_pet/app/services/enderecos_services.dart';
import 'package:cuida_pet/app/services/fornecedor_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecosServices _enderecosServices;
  final CategoriaService _categoriaService;
  final FornecedorService _fornecedorService;

  @observable
  EnderecoModel enderecoSelecionado;
  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;
  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelecimentosFuture;

  @observable
  int pageSelecionda = 0;

  _HomeControllerBase(
    this._enderecosServices,
    this._categoriaService,
    this._fornecedorService,
  );

  @action
  void alterarPaginaSelecionada(int pagina) => pageSelecionda = pagina;

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
    await recuperarEnderecoSelecionado();
    buscarCategorias();
    buscarEstabelecimentos();
  }

  @action
  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecosServices.existeEnderecoCadastrado();
    if (!temEndereco) {
      await Modular.link.pushNamed('/enderecos');
    }
  }

  @action
  Future<void> recuperarEnderecoSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    enderecoSelecionado = await prefs.enderecoSelecionado;
  }

  @action
  void buscarCategorias() {
    categoriasFuture = ObservableFuture(_categoriaService.buscarCategorias());
  }

  @action
  void buscarEstabelecimentos() {
    estabelecimentosFuture = ObservableFuture(
        _fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
  }
}

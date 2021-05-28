import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController filtroNomeController = TextEditingController();

  @observable
  EnderecoModel enderecoSelecionado;
  @observable
  ObservableFuture<List<CategoriaModel>> categoriasFuture;
  @observable
  ObservableFuture<List<FornecedorBuscaModel>> estabelecimentosFuture;
  List<FornecedorBuscaModel> estabelecimentosOriginais;
  @observable
  int categoriaSelecionada;

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
    await buscarEstabelecimentos();
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
  Future<void> buscarEstabelecimentos() async {
    categoriaSelecionada = null;
    filtroNomeController.text = '';
    estabelecimentosFuture = ObservableFuture(
        _fornecedorService.buscarFornecedoresProximos(enderecoSelecionado));
    estabelecimentosOriginais = await estabelecimentosFuture;
  }

  @action
  void filtrarPorCategoria(int id) {
    if (categoriaSelecionada == id) {
      categoriaSelecionada = null;
    } else {
      categoriaSelecionada = id;
    }
    _filtrarEstabelecimentos();
  }

  @action
  void _filtrarEstabelecimentos() {
    var fornecedores = estabelecimentosOriginais;
    if (categoriaSelecionada != null) {
      fornecedores = fornecedores
          .where((element) => element.categoria.id == categoriaSelecionada)
          .toList();
    }
    if (filtroNomeController.text.isNotEmpty) {
      fornecedores = fornecedores
          .where((element) => element.nome
              .toLowerCase()
              .contains(filtroNomeController.text.toLowerCase()))
          .toList();
    }
    estabelecimentosFuture = ObservableFuture(Future.value(fornecedores));
  }

  @action
  void filtrarEstabelecimentoPorNome() {
    _filtrarEstabelecimentos();
  }
}

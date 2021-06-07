import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:cuida_pet/app/models/fornecedor_model.dart';
import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:cuida_pet/app/repository/fornecedor_repository.dart';

class FornecedorService {
  final FornecedorRepository _repository;
  FornecedorService(
    this._repository,
  );
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      EnderecoModel endereco) async {
    return await _repository.buscarFornecedoresProximos(
        endereco.latitude, endereco.longitude);
  }

  Future<FornecedorModel> buscarPorId(int id) {
    return _repository.burcarPorId(id);
  }

  Future<List<FornecedorServicosModel>> buscarServicosFornecedor(
      int fornecedor) {
    return _repository.buscarServicosFornecedor(fornecedor);
  }
}

import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:cuida_pet/app/models/fornecedor_model.dart';
import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';

class FornecedorRepository {
  Future<List<FornecedorBuscaModel>> buscarFornecedoresProximos(
      double lat, double long) {
    return CustomDio.authInstance.get('/fornecedores', queryParameters: {
      'lat': lat,
      'long': long
    }).then((res) => res.data
        .map<FornecedorBuscaModel>((f) => FornecedorBuscaModel.fromJson(f))
        .toList());
  }

  Future<FornecedorModel> burcarPorId(int id) {
    return CustomDio.authInstance
        .get('/fornecedores/$id')
        .then((value) => FornecedorModel.fromJson(value.data));
  }

  Future<List<FornecedorServicosModel>> buscarServicosFornecedor(
      int fornecedor) {
    return CustomDio.authInstance
        .get('/fornecedores/servicos/$fornecedor')
        .then((value) => value.data
            .map<FornecedorServicosModel>(
                (f) => FornecedorServicosModel.fromJson(f))
            .toList());
  }
}

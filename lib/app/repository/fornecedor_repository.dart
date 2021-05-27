import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';

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
}

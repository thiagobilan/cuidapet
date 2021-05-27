import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/models/categoria_model.dart';

class CategoriaRepository {
  Future<List<CategoriaModel>> buscarCategoria() {
    return CustomDio.authInstance.get('/categorias').then((value) => value.data
        .map<CategoriaModel>((c) => CategoriaModel.fromJson(c))
        .toList());
  }
}

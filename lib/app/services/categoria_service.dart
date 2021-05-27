import 'package:cuida_pet/app/models/categoria_model.dart';
import 'package:cuida_pet/app/repository/categoria_repository.dart';

class CategoriaService {
  final CategoriaRepository _repository;
  CategoriaService(
    this._repository,
  );

  Future<List<CategoriaModel>> buscarCategorias() {
    return _repository.buscarCategoria();
  }
}

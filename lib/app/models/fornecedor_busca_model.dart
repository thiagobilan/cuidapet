import 'package:json_annotation/json_annotation.dart';

import 'package:cuida_pet/app/models/categoria_model.dart';

part 'fornecedor_busca_model.g.dart';

@JsonSerializable()
class FornecedorBuscaModel {
  int id;
  String nome;
  String logo;
  double distancia;
  CategoriaModel categoria;
  FornecedorBuscaModel({
    this.id,
    this.nome,
    this.logo,
    this.distancia,
    this.categoria,
  });

  factory FornecedorBuscaModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorBuscaModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorBuscaModelToJson(this);
}

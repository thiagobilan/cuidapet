import 'package:json_annotation/json_annotation.dart';

part 'fornecedor_servicos_model.g.dart';

@JsonSerializable()
class FornecedorServicosModel {
  int id;
  String nome;
  double valor;
  FornecedorServicosModel({
    this.id,
    this.nome,
    this.valor,
  });

  factory FornecedorServicosModel.fromJson(Map<String, dynamic> json) =>
      _$FornecedorServicosModelFromJson(json);
  Map<String, dynamic> toJson() => _$FornecedorServicosModelToJson(this);
}

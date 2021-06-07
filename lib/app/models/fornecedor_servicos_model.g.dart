// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_servicos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorServicosModel _$FornecedorServicosModelFromJson(
    Map<String, dynamic> json) {
  return FornecedorServicosModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    valor: (json['valor'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$FornecedorServicosModelToJson(
        FornecedorServicosModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'valor': instance.valor,
    };

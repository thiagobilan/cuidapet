// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorModel _$FornecedorModelFromJson(Map<String, dynamic> json) {
  return FornecedorModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    logo: json['logo'] as String,
    endereco: json['endereco'] as String,
    telefone: json['telefone'] as String,
    latitudo: (json['latitudo'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    categoria: json['categoria'] == null
        ? null
        : CategoriaModel.fromJson(json['categoria'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FornecedorModelToJson(FornecedorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'endereco': instance.endereco,
      'telefone': instance.telefone,
      'latitudo': instance.latitudo,
      'longitude': instance.longitude,
      'categoria': instance.categoria,
    };

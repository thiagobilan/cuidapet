import 'package:json_annotation/json_annotation.dart';

import 'package:cuida_pet/app/models/fornecedor_model.dart';
import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';

part 'agendamento_model.g.dart';

@JsonSerializable()
class AgendamentoModel {
  int id;
  String nome;
  String nomePet;
  DateTime dataAgendamento;
  FornecedorModel fornecedor;
  List<FornecedorServicosModel> servicos;
  String status;
  AgendamentoModel({
    this.id,
    this.nome,
    this.nomePet,
    this.dataAgendamento,
    this.fornecedor,
    this.servicos,
    this.status,
  });

  factory AgendamentoModel.fromJson(Map<String, dynamic> json) =>
      _$AgendamentoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgendamentoModelToJson(this);
}

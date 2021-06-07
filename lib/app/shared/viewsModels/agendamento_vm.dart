import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:flutter/cupertino.dart';

class AgendamentoVM {
  DateTime dataHora;
  int fornecedorID;
  String nomeReserva;
  String nomePet;
  List<FornecedorServicosModel> servicos;
  AgendamentoVM({
    @required this.fornecedorID,
    @required this.dataHora,
    @required this.nomeReserva,
    @required this.nomePet,
    @required this.servicos,
  });
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamentos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AgendamentosController on _AgendamentosControllerBase, Store {
  final _$dataSelecionadaAtom =
      Atom(name: '_AgendamentosControllerBase.dataSelecionada');

  @override
  DateTime get dataSelecionada {
    _$dataSelecionadaAtom.reportRead();
    return super.dataSelecionada;
  }

  @override
  set dataSelecionada(DateTime value) {
    _$dataSelecionadaAtom.reportWrite(value, super.dataSelecionada, () {
      super.dataSelecionada = value;
    });
  }

  final _$horarioSelecionadaAtom =
      Atom(name: '_AgendamentosControllerBase.horarioSelecionada');

  @override
  TimeOfDay get horarioSelecionada {
    _$horarioSelecionadaAtom.reportRead();
    return super.horarioSelecionada;
  }

  @override
  set horarioSelecionada(TimeOfDay value) {
    _$horarioSelecionadaAtom.reportWrite(value, super.horarioSelecionada, () {
      super.horarioSelecionada = value;
    });
  }

  final _$salvarAgendamentoAsyncAction =
      AsyncAction('_AgendamentosControllerBase.salvarAgendamento');

  @override
  Future<void> salvarAgendamento(
      {int estabelecimento, List<FornecedorServicosModel> servicos}) {
    return _$salvarAgendamentoAsyncAction.run(() => super.salvarAgendamento(
        estabelecimento: estabelecimento, servicos: servicos));
  }

  final _$_AgendamentosControllerBaseActionController =
      ActionController(name: '_AgendamentosControllerBase');

  @override
  void alterarData(DateTime data) {
    final _$actionInfo = _$_AgendamentosControllerBaseActionController
        .startAction(name: '_AgendamentosControllerBase.alterarData');
    try {
      return super.alterarData(data);
    } finally {
      _$_AgendamentosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void alterarHorario(TimeOfDay horarios) {
    final _$actionInfo = _$_AgendamentosControllerBaseActionController
        .startAction(name: '_AgendamentosControllerBase.alterarHorario');
    try {
      return super.alterarHorario(horarios);
    } finally {
      _$_AgendamentosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataSelecionada: ${dataSelecionada},
horarioSelecionada: ${horarioSelecionada}
    ''';
  }
}

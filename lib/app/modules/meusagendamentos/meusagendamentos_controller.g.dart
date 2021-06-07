// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meusagendamentos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeusagendamentosController on _MeusagendamentosControllerBase, Store {
  final _$agendamentosFutureAtom =
      Atom(name: '_MeusagendamentosControllerBase.agendamentosFuture');

  @override
  ObservableFuture<List<AgendamentoModel>> get agendamentosFuture {
    _$agendamentosFutureAtom.reportRead();
    return super.agendamentosFuture;
  }

  @override
  set agendamentosFuture(ObservableFuture<List<AgendamentoModel>> value) {
    _$agendamentosFutureAtom.reportWrite(value, super.agendamentosFuture, () {
      super.agendamentosFuture = value;
    });
  }

  final _$_MeusagendamentosControllerBaseActionController =
      ActionController(name: '_MeusagendamentosControllerBase');

  @override
  void buscarAgendamento() {
    final _$actionInfo = _$_MeusagendamentosControllerBaseActionController
        .startAction(name: '_MeusagendamentosControllerBase.buscarAgendamento');
    try {
      return super.buscarAgendamento();
    } finally {
      _$_MeusagendamentosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
agendamentosFuture: ${agendamentosFuture}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endereco_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnderecoController on _EnderecoControllerBase, Store {
  final _$enderecoFutureAtom =
      Atom(name: '_EnderecoControllerBase.enderecoFuture');

  @override
  ObservableFuture<List<EnderecoModel>> get enderecoFuture {
    _$enderecoFutureAtom.reportRead();
    return super.enderecoFuture;
  }

  @override
  set enderecoFuture(ObservableFuture<List<EnderecoModel>> value) {
    _$enderecoFutureAtom.reportWrite(value, super.enderecoFuture, () {
      super.enderecoFuture = value;
    });
  }

  final _$enviarDetalheAsyncAction =
      AsyncAction('_EnderecoControllerBase.enviarDetalhe');

  @override
  Future<void> enviarDetalhe(Prediction pred) {
    return _$enviarDetalheAsyncAction.run(() => super.enviarDetalhe(pred));
  }

  final _$minhaLocalizacaoAsyncAction =
      AsyncAction('_EnderecoControllerBase.minhaLocalizacao');

  @override
  Future<void> minhaLocalizacao() {
    return _$minhaLocalizacaoAsyncAction.run(() => super.minhaLocalizacao());
  }

  final _$selecionarEnderecoAsyncAction =
      AsyncAction('_EnderecoControllerBase.selecionarEndereco');

  @override
  Future<void> selecionarEndereco(EnderecoModel enderecoModel) {
    return _$selecionarEnderecoAsyncAction
        .run(() => super.selecionarEndereco(enderecoModel));
  }

  final _$_EnderecoControllerBaseActionController =
      ActionController(name: '_EnderecoControllerBase');

  @override
  void verificaEdicaoEndereco(EnderecoModel enderecoEdicao) {
    final _$actionInfo = _$_EnderecoControllerBaseActionController.startAction(
        name: '_EnderecoControllerBase.verificaEdicaoEndereco');
    try {
      return super.verificaEdicaoEndereco(enderecoEdicao);
    } finally {
      _$_EnderecoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enderecoFuture: ${enderecoFuture}
    ''';
  }
}

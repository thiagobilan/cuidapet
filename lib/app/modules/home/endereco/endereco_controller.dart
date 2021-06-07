import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:cuida_pet/app/services/enderecos_services.dart';
import 'package:cuida_pet/app/shared/components/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'endereco_controller.g.dart';

class EnderecoController = _EnderecoControllerBase with _$EnderecoController;

abstract class _EnderecoControllerBase with Store {
  FocusNode enderecoFocusNode = FocusNode();
  final EnderecosServices _enderecosServices;

  TextEditingController enderecoController = TextEditingController();

  _EnderecoControllerBase(this._enderecosServices);

  @observable
  ObservableFuture<List<EnderecoModel>> enderecoFuture;

  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecosServices.buscarEnderecosGooglePlaces(endereco);
  }

  @action
  Future<void> enviarDetalhe(Prediction pred) async {
    var result = await _enderecosServices
        .buscarDetalheEnderecoGooglePlaces(pred.placeId);
    var detalhe = result.result;
    var enderecoModel = EnderecoModel(
        id: null,
        endereco: detalhe.formattedAddress,
        latitude: detalhe.geometry.location.lat,
        longitude: detalhe.geometry.location.lng,
        complemento: null);
    var enderecoEdicao = await Modular.to.pushNamed('/home/enderecos/detalhe',
        arguments: enderecoModel) as EnderecoModel;
    verificaEdicaoEndereco(enderecoEdicao);
  }

  @action
  Future<void> minhaLocalizacao() async {
    Loader.show();
    var geolocator = Geolocator();
    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var placemark = await geolocator.placemarkFromPosition(position);
    var endereco =
        '${placemark[0].thoroughfare} ${placemark[0].subThoroughfare}';
    var enderecoModel = EnderecoModel(
        id: null,
        endereco: endereco,
        latitude: position.latitude,
        longitude: position.longitude,
        complemento: null);
    Loader.hide();
    var enderecoEdicao = await Modular.to
        .pushNamed('/home/enderecos/detalhe', arguments: enderecoModel);
    verificaEdicaoEndereco(enderecoEdicao);
  }

  void buscarEnderecosCadastrados() {
    enderecoFuture =
        ObservableFuture(_enderecosServices.buscarEnderecosCadastrados());
  }

  @action
  void verificaEdicaoEndereco(EnderecoModel enderecoEdicao) {
    if (enderecoEdicao == null) {
      buscarEnderecosCadastrados();
      enderecoController.text = '';
    } else {
      enderecoController.text = enderecoEdicao.endereco;
      enderecoFocusNode.requestFocus();
    }
  }

  @action
  Future<void> selecionarEndereco(EnderecoModel enderecoModel) async {
    var prefs = await SharedPrefsRepository.instance;
    await prefs.registrarEnderecoSelecionado(enderecoModel);
    Modular.to.pop();
  }

  Future<bool> enderecoFoiSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    return await prefs.enderecoSelecionado != null;
  }
}

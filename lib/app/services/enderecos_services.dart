import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/repository/enderecos_repository.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecosServices {
  EnderecosRepository _repository;

  EnderecosServices(
    this._repository,
  );

  Future<bool> existeEnderecoCadastrado() async {
    var listaEndereco = await _repository.buscarEnderecos();
    return listaEndereco.isNotEmpty;
  }

  Future<List<Prediction>> buscarEnderecosGooglePlaces(String endereco) async {
    return await _repository.buscarEnderecosGoogle(endereco);
  }

  Future<void> salvarEndereco(EnderecoModel model) async {
    await _repository.salvarEndereco(model);
  }

  Future<List<EnderecoModel>> buscarEnderecosCadastrados() {
    return _repository.buscarEnderecos();
  }

  Future<PlacesDetailsResponse> buscarDetalheEnderecoGooglePlaces(
      String placeId) {
    return _repository.recuperaDetalhesEnderecoGooglePlace(placeId);
  }

  Future<void> limparEnderecos() async {
    await _repository.limparEnderecos();
  }
}

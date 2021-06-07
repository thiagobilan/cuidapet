import 'package:cuida_pet/app/core/database/connection.dart';
import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class EnderecosRepository {
  Future<List<EnderecoModel>> buscarEnderecos() async {
    final conn = await Connection().instance;
    var result = await conn.rawQuery('select * from endereco');
    return result.map((e) => EnderecoModel.fromMap(e)).toList();
  }

  Future<void> salvarEndereco(EnderecoModel model) async {
    final conn = await Connection().instance;
    await conn.rawInsert('insert into endereco values(?, ?, ?, ?, ?)', [
      null,
      model.endereco,
      model.latitude,
      model.longitude,
      model.complemento
    ]);
  }

  Future<void> limparEnderecos() async {
    final conn = await Connection().instance;
    conn.rawDelete('delete from endereco');
    print('dbLimpo');
  }

  Future<List<Prediction>> buscarEnderecosGoogle(String endereco) async {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    var response = await places.autocomplete(endereco, language: 'pt');
    return response.predictions;
  }

  Future<PlacesDetailsResponse> recuperaDetalhesEnderecoGooglePlace(
      String placeId) {
    final places = GoogleMapsPlaces(apiKey: DotEnv().env['googleApiKey']);
    return places.getDetailsByPlaceId(placeId);
  }
}

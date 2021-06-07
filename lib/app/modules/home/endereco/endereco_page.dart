import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'endereco_controller.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({Key key}) : super(key: key);

  @override
  _EnderecoPageState createState() => _EnderecoPageState();
}

class _EnderecoPageState
    extends ModularState<EnderecoPage, EnderecoController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.buscarEnderecosCadastrados();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var enderecoSelecionado = await controller.enderecoFoiSelecionado();
        if (enderecoSelecionado) {
          return true;
        } else {
          Get.snackbar('Erro', 'Selecione um endereco');
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  'Adicione ou escolha um enderço',
                  style: ThemeUtils.theme.textTheme.headline5.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        focusNode: controller.enderecoFocusNode,
                        controller: controller.enderecoController,
                        decoration: InputDecoration(
                          hintText: 'Insira um endereço',
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                        ),
                      ),
                      itemBuilder: (BuildContext context, Prediction itemData) {
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(itemData.description),
                        );
                      },
                      onSuggestionSelected: (Prediction suggestion) {
                        // print(suggestion.toString());
                        controller.enderecoController.text =
                            suggestion.description;
                        controller.enviarDetalhe(suggestion);
                      },
                      suggestionsCallback: (String pattern) async {
                        return await controller.buscarEnderecos(pattern);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () async {
                    controller.minhaLocalizacao();

                    // Modular.link.pushNamed('/detalhe');
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Localização Atual'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(
                  height: 10,
                ),
                Observer(builder: (_) {
                  return FutureBuilder<List<EnderecoModel>>(
                    future: controller.enderecoFuture,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Container();
                          break;
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          break;
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) =>
                                  _buildItemEndereco(data[index]),
                            );
                          } else {
                            return Center(
                              child: Text('Nenhum Endereço Cadastrado'),
                            );
                          }
                          break;
                        default:
                          return Container();
                      }
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildItemEndereco(EnderecoModel enderecoModel) {
    return ListTile(
      onTap: () => controller.selecionarEndereco(enderecoModel),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.location_on,
          color: Colors.black,
        ),
      ),
      title: Text(enderecoModel.endereco),
      subtitle: Text(enderecoModel.complemento),
    );
  }
}

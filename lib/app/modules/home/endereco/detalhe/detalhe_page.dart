import 'dart:async';
import 'dart:io';

import 'package:cuida_pet/app/modules/home/endereco/detalhe/detalhe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:cuida_pet/app/models/endereco_model.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';

class DetalhePage extends StatefulWidget {
  final EnderecoModel enderecoModel;
  const DetalhePage({
    Key key,
    @required this.enderecoModel,
  }) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState();
}

class _DetalhePageState extends ModularState<DetalhePage, DetalheController> {
  var _appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: _tamanhoDaTela(),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Text(
                'Confirme seu endereço ${widget.enderecoModel.endereco}',
                style: ThemeUtils.theme.textTheme.headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.enderecoModel.latitude,
                        widget.enderecoModel.longitude),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('end'),
                      position: LatLng(widget.enderecoModel.latitude,
                          widget.enderecoModel.longitude),
                      infoWindow:
                          InfoWindow(title: widget.enderecoModel.endereco),
                    )
                  },
                ),
              ),
              TextFormField(
                initialValue: widget.enderecoModel.endereco,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Modular.to.pop(widget.enderecoModel),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.complementoController,
                decoration: InputDecoration(labelText: 'Complemento'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: ScreenUtil.screenWidthDp * .9,
                height: 50,
                child: RaisedButton(
                  color: ThemeUtils.primaryColor,
                  onPressed: () =>
                      controller.salvarEndereco(widget.enderecoModel),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  double _tamanhoDaTela() {
    var bottomBar = 5.0;
    if (Platform.isIOS) {
      bottomBar = ScreenUtil.bottomBarHeight;
    }
    return ScreenUtil.screenHeightDp -
        (ScreenUtil.statusBarHeight + _appBar.preferredSize.height + bottomBar);
  }
}

import 'package:flutter/material.dart';

import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstabelecimentoCard extends StatelessWidget {
  final FornecedorBuscaModel _fornecedor;
  const EstabelecimentoCard(this._fornecedor, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/estabelecimento/${_fornecedor.id}'),
      child: Stack(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            margin: const EdgeInsets.only(
              top: 40,
              left: 10,
              right: 10,
            ),
            child: Container(
              width: double.infinity,
              height: 120,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(_fornecedor.nome,
                        style: ThemeUtils.theme.textTheme.subtitle2),
                    Text(
                        '${_fornecedor.distancia.toStringAsFixed(2)} km de Distância'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(_fornecedor.logo),
            ),
          ),
        ],
      ),
    );
  }
}

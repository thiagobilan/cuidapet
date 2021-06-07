import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';

class EstabelecimentoItemList extends StatelessWidget {
  final FornecedorBuscaModel _fornecedor;
  const EstabelecimentoItemList(
    this._fornecedor, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/estabelecimento/${_fornecedor.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              width: ScreenUtil.screenWidthDp,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_fornecedor.nome),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey[500],
                            ),
                            Text(
                                '${_fornecedor.distancia.toStringAsFixed(2)} Km de distância')
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: ThemeUtils.primaryColor,
                      maxRadius: 15,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.grey[100],
                      ),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(_fornecedor.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

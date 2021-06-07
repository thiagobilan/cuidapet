import 'package:cuida_pet/app/modules/home/home_controller.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppbar extends PreferredSize {
  final HomeController controller;
  HomeAppbar(this.controller)
      : super(
            preferredSize: const Size(double.infinity, 100),
            child: AppBar(
              backgroundColor: Colors.grey[100],
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'CuidaPet',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () async {
                      await Modular.link.pushNamed('/enderecos');
                      await controller.recuperarEnderecoSelecionado();
                      controller.buscarEstabelecimentos();
                    }),
                // IconButton(
                //   icon: Icon(Icons.exit_to_app),
                //   onPressed: () async {
                //     var prefs = await SharedPrefsRepository.instance;
                //     prefs.logout();
                //   },
                // )
              ],
              elevation: 0,
              flexibleSpace: Stack(
                children: [
                  Container(
                    height: 95,
                    width: double.infinity,
                    color: ThemeUtils.primaryColor,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: ScreenUtil.screenWidthDp * .9,
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        elevation: 4,
                        child: Observer(builder: (_) {
                          return TextFormField(
                            autofocus: false,
                            controller: controller.filtroNomeController,
                            onChanged: (value) =>
                                controller.filtrarEstabelecimentoPorNome(),
                            decoration: InputDecoration(
                              filled: true,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200])),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
              centerTitle: true,
            ));
}

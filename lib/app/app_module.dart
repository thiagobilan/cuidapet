import 'package:cuida_pet/app/core/database/connection_adm.dart';
import 'package:cuida_pet/app/modules/home/home_module.dart';
import 'package:cuida_pet/app/modules/login/login_module.dart';
import 'package:cuida_pet/app/app_controller.dart';
import 'package:cuida_pet/app/modules/main_page/main_page.dart';
import 'package:cuida_pet/app/repository/enderecos_repository.dart';
import 'package:cuida_pet/app/repository/usuario_repository.dart';
import 'package:cuida_pet/app/services/enderecos_services.dart';
import 'package:cuida_pet/app/services/usuario_services.dart';
import 'package:cuida_pet/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuida_pet/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        // Bind((i) => MainPageController()),
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => AppController()),

        Bind((i) => AuthStore()),

        Bind((i) => EnderecosRepository()),
        Bind((i) => EnderecosServices(i.get())),

        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioServices(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => MainPage(),
        ),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

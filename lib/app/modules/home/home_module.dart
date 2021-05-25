import 'package:cuida_pet/app/modules/home/endereco/endereco_module.dart';
import 'package:cuida_pet/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuida_pet/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/enderecos', module: EnderecoModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}

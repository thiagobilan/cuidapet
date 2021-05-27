import 'package:cuida_pet/app/modules/home/endereco/endereco_module.dart';
import 'package:cuida_pet/app/modules/home/home_controller.dart';
import 'package:cuida_pet/app/repository/categoria_repository.dart';
import 'package:cuida_pet/app/services/categoria_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuida_pet/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CategoriaRepository()),
        Bind((i) => CategoriaService(i.get())),
        Bind((i) => HomeController(i.get(), i.get(), i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/enderecos', module: EnderecoModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}

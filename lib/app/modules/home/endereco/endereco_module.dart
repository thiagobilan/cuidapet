import 'package:cuida_pet/app/modules/home/endereco/detalhe/detalhe_controller.dart';
import 'package:cuida_pet/app/modules/home/endereco/detalhe/detalhe_page.dart';
import 'package:cuida_pet/app/modules/home/endereco/endereco_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuida_pet/app/modules/home/endereco/endereco_page.dart';

class EnderecoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DetalheController(i.get())),
        Bind((i) => EnderecoController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => EnderecoPage()),
        ModularRouter('/detalhe',
            child: (_, args) => DetalhePage(enderecoModel: args.data)),
      ];

  static Inject get to => Inject<EnderecoModule>.of();
}

import 'package:cuida_pet/app/modules/meusagendamentos/meusagendamentos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuida_pet/app/modules/meusagendamentos/meusagendamentos_page.dart';

class MeusagendamentosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MeusagendamentosController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => MeusagendamentosPage()),
      ];

  static Inject get to => Inject<MeusagendamentosModule>.of();
}

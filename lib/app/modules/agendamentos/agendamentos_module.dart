import 'package:cuida_pet/app/modules/agendamentos/agendamentos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuida_pet/app/modules/agendamentos/agendamentos_page.dart';

class AgendamentosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AgendamentosController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) {
          var parametros = args.data;
          return AgendamentosPage(
            estabelecimento: parametros['estabelecimentoId'],
            servicos: parametros['servicosSelecionados'],
          );
        }),
      ];

  static Inject get to => Inject<AgendamentosModule>.of();
}

import 'package:cuida_pet/app/modules/chat_lista/chat/chat_module.dart';
import 'package:cuida_pet/app/modules/chat_lista/chat_lista_controller.dart';
import 'package:cuida_pet/app/modules/chat_lista/chat_lista_page.dart';
import 'package:cuida_pet/app/repository/chat_repository.dart';
import 'package:cuida_pet/app/services/chat_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatListaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatRepository()),
        Bind((i) => ChatService(i())),
        Bind((i) => ChatListaController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ChatListaPage()),
        ModularRouter('/chat', module: ChatModule()),
      ];

  static Inject get to => Inject<ChatListaModule>.of();
}

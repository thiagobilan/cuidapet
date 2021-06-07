import 'package:cuida_pet/app/modules/chat_lista/chat/chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuida_pet/app/modules/chat_lista/chat/chat_page.dart';

class ChatModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatController(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ChatPage(
                  chat: args.data,
                )),
      ];

  static Inject get to => Inject<ChatModule>.of();
}

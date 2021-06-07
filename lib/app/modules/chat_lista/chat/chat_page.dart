import 'package:cuida_pet/app/models/chat_model.dart';
import 'package:cuida_pet/app/models/chat_msg_model.dart';
import 'package:cuida_pet/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;
  const ChatPage({Key key, this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(chat);
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  final ScrollController _scrollController = ScrollController();
  final ChatModel model;

  _ChatPageState(this.model);
  //use 'controller' variable to access controller
  @override
  void initState() {
    controller.getChat(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                final List<ChatMsgModel> msgs = controller.messages?.data;
                if (msgs == null) {
                  return SizedBox.shrink();
                }
                Future.delayed(
                    Duration.zero,
                    () => _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent));

                return ListView.builder(
                    controller: _scrollController,
                    itemCount: msgs.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final msg = msgs[index];
                      if (msg.fornecedor != null) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(model.fornecedor.logo),
                          ),
                          title: Text(model.fornecedor.nome),
                          subtitle: Text(msg.mensagem),
                        );
                      } else {
                        var user = Modular.get<AuthStore>().usuarioLogado;
                        return ListTile(
                          trailing: CircleAvatar(
                            backgroundImage: NetworkImage(user.imgAvatar),
                          ),
                          title: Text(
                            model.nome,
                            textAlign: TextAlign.end,
                          ),
                          subtitle:
                              Text(msg.mensagem, textAlign: TextAlign.end),
                        );
                      }
                    });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller.mensagemController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    minRadius: 25,
                    child: IconButton(
                      onPressed: () => controller.sendMessage(),
                      icon: Icon(Icons.send),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

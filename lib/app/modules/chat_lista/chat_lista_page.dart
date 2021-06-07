import 'package:cuida_pet/app/models/chat_model.dart';
import 'package:cuida_pet/app/modules/chat_lista/chat_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatListaPage extends StatefulWidget {
  const ChatListaPage({Key key}) : super(key: key);

  @override
  _ChatListaPageState createState() => _ChatListaPageState();
}

class _ChatListaPageState
    extends ModularState<ChatListaPage, ChatListaController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.findChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Chats'),
        ),
        body: Observer(builder: (_) {
          return FutureBuilder(
            future: controller.chatFuture,
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {

                // default:
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao buscar Chat'),
                    );
                  }
                  return _buildListTile(snapshot);
                  break;
                default:
                  return Container();
              }
            },
          );
        }));
  }

  Widget _buildListTile(AsyncSnapshot<List<ChatModel>> snapshot) {
    final chats = snapshot.data;
    if (snapshot.hasData && chats.isEmpty) {
      return Center(
        child: Text('Nenhum Chat Encontrado'),
      );
    }
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemCount: chats.length,
      itemBuilder: (_, index) {
        final chat = chats[index];
        return ListTile(
          onTap: () => Modular.link.pushNamed('/chat/', arguments: chat),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chats[index].fornecedor.logo),
          ),
          title: Text(chats[index].nome),
          subtitle: Text(chats[index].nomePet),
        );
      },
    );
  }
}

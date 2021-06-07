import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuida_pet/app/core/dio/custom_dio.dart';
import 'package:cuida_pet/app/models/chat_model.dart';
import 'package:cuida_pet/app/models/chat_msg_model.dart';

class ChatRepository {
  final Firestore _firestore = Firestore.instance;

  Future<List<ChatModel>> buscarChatUsuario() {
    return CustomDio.authInstance
        .get(
          '/chats/usuario',
        )
        .then((value) => value.data
            .map<ChatModel>(
              (c) => ChatModel.fromJson(c),
            )
            .toList());
  }

  Stream<List<ChatMsgModel>> getMenssages(ChatModel chat) {
    return _firestore
        .collection('chat')
        .document(chat.id.toString())
        .collection('messages')
        .orderBy('data_mensagem')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.documents
            .map(
              (m) => ChatMsgModel(
                usuario: m['usuario'],
                fornecedor: m['fornecedor'],
                mensagem: m['mensagem'],
              ),
            )
            .toList();
      },
    );
  }

  void sendMessageChat(ChatModel model, String message) {
    final data = <String, dynamic>{
      'mensagem': message,
      'data_mensagem': DateTime.now(),
      'usuario': model.usuario
    };
    _firestore
        .collection('chat')
        .document(model.id.toString())
        .collection('messages')
        .add(data);
  }

  void notifyUser(ChatModel model, String message) {
    CustomDio.authInstance.post('/chats/notificar',
        data: {'chat': model.id, 'mensagem': message, 'para': 'F'});
  }
}

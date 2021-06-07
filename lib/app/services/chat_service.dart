import 'package:cuida_pet/app/models/chat_model.dart';
import 'package:cuida_pet/app/models/chat_msg_model.dart';
import 'package:cuida_pet/app/repository/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;
  ChatService(
    this._repository,
  );
  Future<List<ChatModel>> buscarChat() {
    return _repository.buscarChatUsuario();
  }

  Stream<List<ChatMsgModel>> getMenssages(ChatModel chat) {
    return _repository.getMenssages(chat);
  }

  void sendMenssage(ChatModel model, String mensagem) {
    _repository.sendMessageChat(model, mensagem);
    _repository.notifyUser(model, mensagem);
  }
}

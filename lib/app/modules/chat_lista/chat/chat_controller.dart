import 'package:cuida_pet/app/models/chat_model.dart';
import 'package:cuida_pet/app/models/chat_msg_model.dart';
import 'package:cuida_pet/app/services/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final ChatService _service;
  TextEditingController mensagemController = TextEditingController();

  _ChatControllerBase(this._service);

  @observable
  ChatModel chat;

  @observable
  ObservableStream<List<ChatMsgModel>> messages;

  void getChat(ChatModel model) {
    chat = model;
    final msgs = _service.getMenssages(chat);
    messages = msgs.asObservable();
  }

  void sendMessage() {
    if (mensagemController.text.isNotEmpty) {
      _service.sendMenssage(chat, mensagemController.text);
      mensagemController.text = '';
    }
  }
}

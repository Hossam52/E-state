import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:osol/User/BussinssLogic/services/chat_services.dart';
import 'package:osol/User/BussinssLogic/services/firebase/models/chat_model.dart';
import './chats_states.dart';

//Bloc builder and bloc consumer methods
typedef ChatsBlocBuilder = BlocBuilder<ChatsCubit, ChatsStates>;
typedef ChatsBlocConsumer = BlocConsumer<ChatsCubit, ChatsStates>;

//
class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit(this.myUserId) : super(IntitalChatsState()) {
    getAllChats();
  }
  static ChatsCubit instance(BuildContext context) =>
      BlocProvider.of<ChatsCubit>(context);
  final String myUserId;
  final chatService = ChatService.instance;

  Stream<QuerySnapshot<ChatModel>>? chatsStream;
  bool get isChatsLoaded => chatsStream != null;
  Future<void> getAllChats() async {
    log('asdf$myUserId\n');
    chatsStream = await chatService.getAllChats(myUserId);
    emit(ChangeChatData());
  }

  ChatMember displayedMember(QueryDocumentSnapshot<ChatModel> item) {
    return item.data().displayedMember(myUserId);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osol/User/BussinssLogic/services/firebase/firebase_collection_paths.dart';
import 'package:osol/User/BussinssLogic/services/firebase/models/chat_model.dart';

class ChatService {
  ChatService._();
  static ChatService get instance => ChatService._();
  late final _firestore = FirebaseFirestore.instance;

  Future<Stream<QuerySnapshot<ChatModel>>> getAllChats(String myId) async {
    final chatsCollection = _firestore.collection(CollectionPaths.chats);
    final allChatsStream = chatsCollection
        .where('memberIds', arrayContainsAny: [myId])
        .withConverter<ChatModel>(
            fromFirestore: (snapshot, _) => ChatModel.fromMap(snapshot.data()!),
            toFirestore: (chat, _) => chat.toMap())
        .snapshots();
    allChatsStream.map((event) => event.docs);
    return allChatsStream;
  }
}

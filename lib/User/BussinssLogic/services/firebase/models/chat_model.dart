import 'dart:convert';

class ChatModel {
  List<String> memberIds;
  List<ChatMember> members;
  ChatModel({
    required this.memberIds,
    required this.members,
  });

  Map<String, dynamic> toMap() {
    return {
      'memberIds': memberIds,
      'members': members.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      memberIds: List<String>.from(map['memberIds']),
      members: List<ChatMember>.from(
          map['members']?.map((x) => ChatMember.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  ChatMember displayedMember(String myId) {
    return members.firstWhere((element) => element.userId != myId,
        orElse: () => members.first);
  }
}

class ChatMember {
  String userPicture;
  String userName;
  String userId;
  ChatMember({
    required this.userPicture,
    required this.userName,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userPicture': userPicture,
      'userName': userName,
      'userId': userId,
    };
  }

  factory ChatMember.fromMap(Map<String, dynamic> map) {
    return ChatMember(
      userPicture: map['userPicture'] ?? '',
      userName: map['userName'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMember.fromJson(String source) =>
      ChatMember.fromMap(json.decode(source));
}

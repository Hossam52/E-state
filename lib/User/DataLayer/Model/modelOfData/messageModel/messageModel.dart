class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessageModel({
    required this.text,
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json["sender"];
    receiverId = json["reciever"];
    dateTime = json["dateTime"];
    text = json["text"];
  }

  Map<String, dynamic> toMap() {
    return {
      "sender": senderId,
      "reciever": receiverId,
      "dateTime": dateTime,
      "text": text,
    };
  }
}

class UserCompany {
  String? mail;

  UserCompany({required this.mail});

  UserCompany.fromJson(Map<String, dynamic> json) {
    mail = json["email"];
  }
}

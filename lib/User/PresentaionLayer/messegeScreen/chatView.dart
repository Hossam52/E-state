import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';

import '../../BussinssLogic/companyCubit/company_cubit.dart';

class ChatView extends StatefulWidget {
  String? name;
  String email;
  String image;

  ChatView({required this.name, required this.email, required this.image});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var chatDocId;

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async {
    await _fireStore
        .collection("nChat")
        .where("users", isEqualTo: {
          widget.email: null,
          ProfileCubit.get(context).profileDate[0].client!.email: null,
          "cImage": widget.image,
          "cEmail": widget.email,
          "cName": widget.name,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            setState(() {
              chatDocId = querySnapshot.docs.single.id;
            });
          } else {
            await _fireStore.collection("nChat").add({
              "users": {
                widget.email: null,
                ProfileCubit.get(context).profileDate[0].client!.email: null,
                "cImage": widget.image,
                "cEmail": widget.email,
                "cName": widget.name,
              },
              "names": {
                widget.email: widget.name,
                ProfileCubit.get(context).profileDate[0].client!.email:
                    ProfileCubit.get(context).profileDate[0].client!.userName
              }
            }).then((value) {
              chatDocId = value;
            });
          }
        })
        .catchError((e) {
          debugPrint("Chat create Error $e");
        });
  }

  void sendMsg(String msg) {
    if (msg.isEmpty) return;
    FirebaseFirestore.instance
        .collection("nChat")
        .doc(chatDocId)
        .collection("message")
        .add({
      "createdOn": FieldValue.serverTimestamp(),
      "email": ProfileCubit.get(context).profileDate[0].client!.email,
      "name": ProfileCubit.get(context).profileDate[0].client!.userName,
      "image": ProfileCubit.get(context).profileDate[0].client!.image,
      "text": msg
    }).then((value) {
      chatController.text = "";
    });
  }

  final _fireStore = FirebaseFirestore.instance;

  String? messageText;

  TextEditingController chatController = TextEditingController();

  DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.WhiteScreen,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.WhiteScreen,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
            size: 28,
          ),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        centerTitle: true,
        title: Text(
          "${widget.name}",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: chatDocId == null
          ? Center(
              child: CupertinoActivityIndicator(
                color: ColorManager.telegramBTn,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _fireStore
                            .collection("nChat")
                            .doc(chatDocId)
                            .collection("message")
                            .orderBy("createdOn", descending: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<ChatWidget> messagesWidget = [];
                          if (!snapshot.hasData || snapshot.hasError) {
                            return Center(
                              child: CupertinoActivityIndicator(
                                color: ColorManager.telegramBTn,
                              ),
                            );
                          }
                          final messages = snapshot.data!.docs.reversed;
                          for (var item in messages) {
                            final email = item.get("email");
                            final imgSnder = item.get("image");
                            final txt = item.get("text");
                            final messageWidget = ChatWidget(
                              email: email ==
                                  ProfileCubit.get(context)
                                      .profileDate[0]
                                      .client!
                                      .email,
                              time: '33',
                              txt: '$txt',
                              img: '$imgSnder',
                            );
                            messagesWidget.add(messageWidget);
                          }
                          debugPrint("${snapshot.data!.docs.reversed}");
                          return ListView(
                            reverse: true,
                            children: messagesWidget,
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorManager.chatGreyColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              controller: chatController,
                              onChanged: (String? v) {
                                messageText = v;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Say Something...",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => sendMsg(chatController.text),
                            // {
                            //   _fireStore
                            //       .collection("nUser")
                            //       .limit(1)
                            //       .where("uid", isEqualTo: widget.email)
                            //       .get()
                            //       .then((QuerySnapshot query) {
                            //     if (query.docs.isEmpty) {
                            //       _fireStore.collection("nUser").add({
                            //         "uid": widget.email,
                            //         "name": widget.name,
                            //         "cImage": widget.image,
                            //         "time": FieldValue.serverTimestamp(),
                            //         "timenow": "${_now.hour}:${_now.minute}"
                            //       });
                            //     }
                            //   });
                            //   if (chatController.text != "") {
                            //     _fireStore
                            //         .collection("usersData")
                            //         .doc(widget.email)
                            //         .collection("message")
                            //         .add({
                            //       "cEmail": widget.email,
                            //       "cImage": widget.image,
                            //       "text": messageText.toString(),
                            //       "userEmail": ProfileCubit.get(context)
                            //           .profileDate[0]
                            //           .client!
                            //           .email,
                            //       "userImage": ProfileCubit.get(context)
                            //           .profileDate[0]
                            //           .client!
                            //           .image,
                            //       "time": FieldValue.serverTimestamp(),
                            //       "timenow": "${_now.hour}:${_now.minute}"
                            //     });
                            //     sendMessageToFireStore(
                            //       context: context,
                            //       message: ProfileCubit.get(context)
                            //           .messageText
                            //           .toString(),
                            //     );
                            //   }
                            //   chatController.clear();
                            // },
                            child: Container(
                              child: Icon(
                                FontAwesomeIcons.mailForward,
                                color: Colors.blue,
                                size: 50,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  String? txt;
  String? img;
  String? time;
  bool email;

  ChatWidget(
      {required this.img,
      required this.txt,
      required this.time,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: email
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: sizeFromWidth(2.5),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "$txt",
                        textAlign: TextAlign.end,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("$img"),
                  ),
                  // Container(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     "$time",
                  //     style: TextStyle(
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("$img"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: sizeFromWidth(2.5),
                    decoration: BoxDecoration(
                        color: ColorManager.chatGreyColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "$txt",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     "$time",
                  //     style: TextStyle(
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // )
                ],
              ),
      ),
    );
  }
}

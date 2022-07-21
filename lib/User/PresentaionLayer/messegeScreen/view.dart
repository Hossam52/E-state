import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/chats_cubit/chats_cubit.dart';

import 'chatView.dart';

class MessageView extends StatefulWidget {
  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit('user2'),
      child: ChatsBlocBuilder(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
              ),
              shape: const ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              centerTitle: true,
              title: Text("Messages",
                  style: Theme.of(context).textTheme.headline1),
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.collection("nChat").snapshots(),
                      builder: (context, snapshot) {
                        List<ChatData> messagesWidget = [];
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              color: ColorManager.telegramBTn,
                            ),
                          );
                        }

                        final messages = snapshot.data!.docs;
                        for (var item in messages) {
                          final imgSnder = item.get("users")["cImage"];
                          final companyName = item.get("users")["cName"];
                          final companyEmail = item.get("users")["cEmail"];
                          messagesWidget.add(ChatData(
                              companyImage: imgSnder,
                              time: '2',
                              img: '$imgSnder',
                              msg: "dd",
                              companyName: companyName,
                              companyEmail: companyEmail));
                        }

                        return ListView(
                          children: messagesWidget,
                        );
                      }),
                ),
                // Expanded(
                //   child: StreamBuilder<QuerySnapshot<ChatModel>>(
                //       stream: ChatsCubit.instance(context).chatsStream,
                //       builder: (context, snapshot) {
                //         List<ChatData> messagesWidget = [];
                //         if (!snapshot.hasData) {
                //           return Center(
                //             child: CupertinoActivityIndicator(
                //               color: ColorManager.telegramBTn,
                //             ),
                //           );
                //         }

                //         final messages = snapshot.data!.docs;
                //         for (var item in messages) {
                //           final person = ChatsCubit.instance(context)
                //               .displayedMember(item);
                //           messagesWidget.add(ChatData(
                //               companyImage: person.userPicture,
                //               time: '2',
                //               img: person.userPicture,
                //               msg: "dd",
                //               companyName: person.userName,
                //               companyEmail: person.userName));
                //         }

                //         return ListView(
                //           children: messagesWidget,
                //         );
                //       }),
                // ),
                TextButton(
                    onPressed: () async {
                      await ChatsCubit.instance(context).getAllChats();
                    },
                    child: Text('Press')),
                Divider(
                  height: 0.2,
                  color: ColorManager.AppBarIconcolorGrey,
                  thickness: 0.2,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChatData extends StatelessWidget {
  String companyName;
  String msg;
  String time;
  String img;
  String companyEmail;
  String companyImage;

  ChatData(
      {required this.companyImage,
      required this.time,
      required this.img,
      required this.msg,
      required this.companyName,
      required this.companyEmail,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: sizeFromHeight(7),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => ChatView(
                      image: companyImage,
                      email: companyEmail,
                      name: companyName,
                    )),
          );
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(img),
        ),
        title: Text(companyName, style: Theme.of(context).textTheme.headline2),
        subtitle: SizedBox(
          width: double.infinity,
          child: Text(msg, style: Theme.of(context).textTheme.headline3),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: time, style: Theme.of(context).textTheme.headline4),
              TextSpan(
                  text: "ساعه", style: Theme.of(context).textTheme.headline4),
            ])),
            // index == 0
            //     ? Container(
            //         alignment: Alignment.center,
            //         height: 25,
            //         width: 25,
            //         decoration: BoxDecoration(
            //           color: ColorManager.onboardingColorDots,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Text(
            //           "2",
            //           style: TextStyle(
            //             color: ColorManager.WhiteScreen,
            //           ),
            //         ),
            //       )
            //     :
            const SizedBox(
              height: 25,
              width: 25,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/profilecompanyCubit/profile_company_cubit.dart';
import 'package:osol/Shared/constants.dart';

class ChatCompanyView extends StatelessWidget {
  String? name;
  String email;

  ChatCompanyView({required this.name, required this.email});

  final _fireStore = FirebaseFirestore.instance;
  String? messageText;
  TextEditingController chatController = TextEditingController();

  void getMessages() async {
    await for (var snapshot in _fireStore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        debugPrint("chat: ${message.data()}");
      }
    }
  }

  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCompanyCubit, ProfileCompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: Text(
              "$name",
            ),
          ),
          body: state is SuccessGetProfileDataStatus
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: _fireStore
                                .collection("users")
                                .doc(email)
                                .collection("userCompany")
                                .doc(ProfileCompanyCubit.get(context)
                                    .companyProfile
                                    ?.email)
                                .collection("message")
                                .orderBy("time")
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
                                      ProfileCompanyCubit.get(context)
                                          .companyProfile
                                          ?.email,
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
                                  decoration: const InputDecoration(
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
                                onTap: () {
                                  chatController.text == ""
                                      ? null
                                      : _fireStore
                                          .collection("users")
                                          .doc(email)
                                          .collection("userCompany")
                                          .doc(ProfileCompanyCubit.get(context)
                                              .companyProfile
                                              ?.email)
                                          .collection("message")
                                          .add({
                                          "text": messageText.toString(),
                                          "email":
                                              ProfileCompanyCubit.get(context)
                                                  .companyProfile
                                                  ?.email,
                                          "image":
                                              ProfileCompanyCubit.get(context)
                                                  .companyProfile
                                                  ?.image,
                                          "time": FieldValue.serverTimestamp(),
                                          "timenow":
                                              "${_now.hour}:${_now.minute}"
                                        });
                                  chatController.clear();
                                },
                                child: Container(
                                  child: const Icon(
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
                )
              : const Center(
                  child: CupertinoActivityIndicator(),
                ),
        );
      },
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
                    decoration: const BoxDecoration(
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
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: sizeFromWidth(2.5),
                    decoration: BoxDecoration(
                        color: ColorManager.chatGreyColor,
                        borderRadius: const BorderRadius.only(
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
                        style: const TextStyle(
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

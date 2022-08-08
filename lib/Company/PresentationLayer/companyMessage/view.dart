import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';

import '../../businessLogicLayer/profilecompanyCubit/profile_company_cubit.dart';
import 'chatCompanyView.dart';

class MessageCompanyView extends StatelessWidget {
  final _fireStore = FirebaseFirestore.instance;

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
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: Text(
              "Messages",
            ),
          ),
          body: state is SuccessGetProfileDataStatus
              ? ProfileCompanyCubit.get(context).companyProfile?.email != null
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: _fireStore
                                    .collection("UeserCompany")
                                    .orderBy("time")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  List<ChatData> messagesWidget = [];
                                  if (!snapshot.hasData || snapshot.hasError) {
                                    return Center(
                                      child: CupertinoActivityIndicator(
                                        color: ColorManager.telegramBTn,
                                      ),
                                    );
                                  }
                                  final messages = snapshot.data!.docs.reversed;
                                  for (var item in messages) {
                                    final userImage = item.get("userImage");
                                    final userName = item.get("userName");
                                    final userEmail = item.get("userMail");
                                    final imgSnder = item.get("image");
                                    final companyName = item.get("name");
                                    final companyEmail = item.get("email");
                                    if (ProfileCompanyCubit.get(context)
                                            .companyProfile
                                            ?.email !=
                                        null) {
                                      final messageWidget = companyEmail ==
                                              ProfileCompanyCubit.get(context)
                                                  .companyProfile
                                                  ?.email
                                          ? ChatData(
                                              time: '2',
                                              img: '$userImage',
                                              msg: "سشس",
                                              companyName: userName,
                                              companyEmail: userEmail)
                                          : null;
                                      messageWidget != null
                                          ? messagesWidget.add(messageWidget)
                                          : Text("There is no Chats");
                                    }
                                  }
                                  return ListView(
                                    children: messagesWidget,
                                  );
                                }),
                          ),
                        ),
                        Divider(
                          height: 0.2,
                          color: ColorManager.AppBarIconcolorGrey,
                          thickness: 0.2,
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )
              : Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}

class ChatData extends StatelessWidget {
  String companyName;
  String msg;
  String time;
  String img;
  String companyEmail;

  ChatData(
      {required this.time,
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
                builder: (_) => ChatCompanyView(
                      email: '$companyEmail',
                      name: '$companyName',
                    )),
          );
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage("$img"),
        ),
        title: Text(
          "$companyName",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        subtitle: Container(
          width: double.infinity,
          child: Text(
            "$msg",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "$time",
                style: TextStyle(
                  color: ColorManager.AppBarIconcolorGrey,
                ),
              ),
              TextSpan(
                text: "ساعه",
                style: TextStyle(
                  color: ColorManager.AppBarIconcolorGrey,
                ),
              ),
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
            SizedBox(
              height: 25,
              width: 25,
            )
          ],
        ),
      ),
    );
  }
}

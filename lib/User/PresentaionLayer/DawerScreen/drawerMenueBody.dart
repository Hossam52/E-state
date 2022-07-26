// import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/registerition/registeration/view.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/darkmood_switch.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signIn/view.dart';
import 'package:osol/User/PresentaionLayer/SavedScreen/view.dart';
import 'package:osol/User/PresentaionLayer/aboutScreen/view.dart';
import 'package:osol/User/PresentaionLayer/appsettingScreen/view.dart';
import 'package:osol/User/PresentaionLayer/customerServicesScreen/view.dart';
import 'package:osol/User/PresentaionLayer/messegeScreen/view.dart';

class DrawerMenuBody extends StatelessWidget {
  bool isSwitched = false;

  onWillPop(context) {
    debugPrint("sooo");
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text("Exit"),
              content: const Text("Are you sure you want to leave the app?"),
              actions: [
                CupertinoDialogAction(
                    child: const Text("YES"),
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    }),
                CupertinoDialogAction(
                    child: const Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        var cubit3 = HomeCubit.get(context);
        var cubit2 = AuthCubit.get(context);
        return WillPopScope(
          onWillPop: () => onWillPop(context),
          child: Scaffold(
            backgroundColor: ColorManager.onboardingColorDots,
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 50,
                bottom: 50,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            cubit2.userToken == null &&
                                    cubit3.getMyToken == null
                                ? const CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage("assets/images/guest.png"),
                                  )
                                : CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                      "${cubit.profileModel?.client?.image}",
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              cubit.profileModel?.client?.userName ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => SavedScreen()));
                                },
                                child: SizedBox(
                                  height: sizeFromHeight(18),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidBookmark,
                                        color: ColorManager.WhiteScreen,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        "Saved",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(
                                        "assets/images/message.svg",
                                        color: ColorManager.WhiteScreen,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (_) => MessageView(),
                                      )),
                                      child: const Text(
                                        "Messages",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.gear,
                                      color: ColorManager.WhiteScreen,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (_) => AppSettingView(),
                                      )),
                                      child: const Text(
                                        "Settings",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.phone,
                                      color: ColorManager.WhiteScreen,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (_) => CustomerServicesView(),
                                      )),
                                      child: const Text(
                                        "Contact Us",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  children: [
                                    Container(
                                      child: SvgPicture.asset(
                                          "assets/images/examilation.svg"),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (_) => AboutView(),
                                      )),
                                      child: const Text(
                                        "About App",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidMoon,
                                        color: ColorManager.WhiteScreen,
                                        size: 20,
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Dark mode",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: DarkmoodSwitch(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: FaIcon(
                                        FontAwesomeIcons.earth,
                                        color: ColorManager.WhiteScreen,
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Languages",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: sizeFromHeight(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (_) =>
                                          CompanyRegisterationScreen(),
                                    ));
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Container(
                                      child: const Text(
                                        "Register as a company",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: sizeFromHeight(18),
                                child: Row(
                                  children: [
                                    cubit2.userToken == null &&
                                            cubit3.myToken == null
                                        ? InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          SignInView()));
                                            },
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons
                                                      .arrowRightFromBracket,
                                                  color:
                                                      ColorManager.WhiteScreen,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text(
                                                  "Sign In",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              await AuthCubit.get(context)
                                                  .logOut(context: context);
                                            },
                                            child: Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons
                                                      .arrowRightFromBracket,
                                                  color:
                                                      ColorManager.WhiteScreen,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text(
                                                  "LogOut",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

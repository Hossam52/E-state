import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/registerition/registeration/view.dart';
import 'package:osol/Company/businessLogicLayer/authCompany/auth_company_cubit.dart';
import 'package:osol/Company/businessLogicLayer/profilecompanyCubit/profile_company_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/companyProfile/getProfileDataModel.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signIn/view.dart';
import 'package:osol/User/PresentaionLayer/aboutScreen/view.dart';
import 'package:osol/User/PresentaionLayer/appsettingScreen/view.dart';
import 'package:osol/User/PresentaionLayer/customerServicesScreen/view.dart';
import 'package:osol/User/PresentaionLayer/messegeScreen/view.dart';

class DrawerMenuBodyCompany extends StatelessWidget {
  bool isSwitched = false;

  ImageProvider profileImage(CompanyProfile? profile) {
    if (profile != null && profile.image != null) {
      return CachedNetworkImageProvider(profile.image!);
    } else {
      return const AssetImage("assets/images/avatar.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompanyCubit, ProfileCompanyState>(
      builder: (context, state) {
        final profile = ProfileCompanyCubit.get(context).companyProfile;

        return Scaffold(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: profileImage(profile),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          profile?.name ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: sizeFromHeight(18),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: FaIcon(
                                    FontAwesomeIcons.solidBookmark,
                                    color: ColorManager.WhiteScreen,
                                  ),
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
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
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
                                    style: const TextStyle(
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
                          Container(
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
                                    style: const TextStyle(
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
                          Container(
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
                                    style: const TextStyle(
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
                          Container(
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
                                    style: const TextStyle(
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
                          Container(
                            height: sizeFromHeight(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidMoon,
                                    color: ColorManager.WhiteScreen,
                                    size: 20,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      "Dark mode",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Switch(
                                    onChanged: (value) {},
                                    value: isSwitched,
                                    activeColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: sizeFromHeight(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Container(
                      height: sizeFromHeight(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: sizeFromHeight(18),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.arrowRightFromBracket,
                                  color: ColorManager.WhiteScreen,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // await cubit.logOutCompany(
                                    //     context: context);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => SignInView(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "LogOut",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

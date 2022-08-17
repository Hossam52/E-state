import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/PresentaionLayer/profileScreen/updateProfile.dart';

import 'changePasswordView.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: const Text(
              "Profile",
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage("${cubit.profileDate[0].client?.image}"),
                ),
                title: Text(
                  "${cubit.profileDate[0].client?.userName}",
                  style: Theme.of(context).textTheme.headline2,
                ),
                subtitle: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Personal account",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const UpdateProfile(),
                      ),
                    );
                  },
                  child: Card(
                    color: AppSettingCubit.get(context).isDark
                        ? ColorManager.DarkThemeBlackGround2
                        : Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FaIcon(
                        FontAwesomeIcons.pen,
                        color: ColorManager.onboardingColorDots,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Personal Data",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppSettingCubit.get(context).isDark
                          ? ColorManager.DarkThemeBlackGround2
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      "Change Name",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppSettingCubit.get(context).isDark
                          ? ColorManager.DarkThemeBlackGround2
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordView(),
                        ),
                      );
                    },
                    title: Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

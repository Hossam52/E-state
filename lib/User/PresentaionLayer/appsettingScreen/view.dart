import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';

class AppSettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppSettingCubit, AppSettingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
              "App Setting",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.CompareConatainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    onTap: () {},
                    leading: Container(
                      child: SvgPicture.asset("assets/images/language.svg"),
                    ),
                    title: Text(
                      "Change Language",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Container(
                      width: sizeFromWidth(4.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "English",
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[800],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.CompareConatainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    onTap: () {
                      AppSettingCubit.get(context)
                          .chandeDarkMode(!AppSettingCubit.get(context).isDark);
                    },
                    leading: Container(
                      child: SvgPicture.asset("assets/images/night.svg"),
                    ),
                    title: Text(
                      "Dark Mode",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Container(
                      width: sizeFromWidth(4.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppSettingCubit.get(context).isDark == false
                                ? "Enable"
                                : "Dissable",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[800],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.CompareConatainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    onTap: () {},
                    leading: Container(
                      child: SvgPicture.asset("assets/images/text.svg"),
                    ),
                    title: Text(
                      "Font Size",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Container(
                      width: sizeFromWidth(4.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "medium",
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[800],
                          ),
                        ],
                      ),
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

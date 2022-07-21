import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/PrivacyAndPolicyScreen/view.dart';
import 'package:osol/User/PresentaionLayer/aboutScreen/view.dart';
import 'package:osol/User/PresentaionLayer/appsettingScreen/view.dart';
import 'package:osol/User/PresentaionLayer/customerServicesScreen/view.dart';
import 'package:osol/User/PresentaionLayer/messegeScreen/view.dart';
import 'package:osol/User/PresentaionLayer/profileScreen/view.dart';

class MoreViewScreen extends StatelessWidget {
  const MoreViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          top: 15,
        ),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return ProfileView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(13),
                width: sizeFromHeight(13),
                decoration: BoxDecoration(
                  color: ColorManager.OnBoardingScreen,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/person.svg",
                      color: ColorManager.WhiteScreen,
                    ),
                  ),
                ),
              ),
              title: Text(
                "My account",
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Container(
                width: double.infinity,
                child: FittedBox(
                  child: Text(
                    "change your account data,email,password...etc",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return MessageView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(13),
                width: sizeFromHeight(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: ColorManager.OnBoardingScreen,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/message.svg",
                      color: ColorManager.WhiteScreen,
                    ),
                  ),
                ),
              ),
              title: Text(
                "Messages",
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "2 new messages found",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AppSettingView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(13),
                width: sizeFromHeight(13),
                decoration: BoxDecoration(
                  color: ColorManager.OnBoardingScreen,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.gear,
                    color: ColorManager.WhiteScreen,
                    size: 22,
                  ),
                ),
              ),
              title: Text(
                "App Settings",
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "change languages, dark moe and manage your app",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return AboutView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(13),
                width: sizeFromHeight(13),
                decoration: BoxDecoration(
                  color: ColorManager.OnBoardingScreen,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/examilation.svg",
                    ),
                  ),
                ),
              ),
              title: Text(
                "About App",
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "Learn More about Osol App",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return CustomerServicesView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(13),
                width: sizeFromHeight(13),
                decoration: BoxDecoration(
                  color: ColorManager.OnBoardingScreen,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/images/custser.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                "Customer Services",
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "Contact us if you have some issues",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return PrivacyAndPolicyView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(13),
                width: sizeFromHeight(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: ColorManager.OnBoardingScreen,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/images/shield.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                "Privacy and Policy",
                style: Theme.of(context).textTheme.headline2,
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "Contact us if you have some issue",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
              ),
            )
          ],
        ),
      ),
    );
  }
}

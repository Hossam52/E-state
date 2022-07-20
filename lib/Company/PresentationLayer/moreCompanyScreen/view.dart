import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/companyProfile/view.dart';
import 'package:osol/Company/PresentationLayer/companyProjects/view.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/PrivacyAndPolicyScreen/view.dart';
import 'package:osol/User/PresentaionLayer/aboutScreen/view.dart';
import 'package:osol/User/PresentaionLayer/appsettingScreen/view.dart';
import 'package:osol/User/PresentaionLayer/customerServicesScreen/view.dart';
import 'package:osol/User/PresentaionLayer/messegeScreen/view.dart';
import 'package:osol/User/PresentaionLayer/profileScreen/view.dart';

import '../companyMessage/view.dart';

class MoreViewCompanyScreen extends StatelessWidget {
  const MoreViewCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.WhiteScreen,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,top: 15,
        ),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return CompanyProfileScreen();
                }));
              },
              leading: Container(
                height: sizeFromHeight(12),
                width:sizeFromHeight(12),
                decoration: BoxDecoration(
                    color: ColorManager.WhiteScreen,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/person.svg",
                      color: ColorManager.personMoreIcon,
                    ),
                  ),
                ),
              ),
              title: Text(
                "My account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: FittedBox(
                  fit:BoxFit.scaleDown,
                  child: Text(
                    "change your account data,email,password...etc",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
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
                  return CompanyProjectScreen();
                }));
              },
              leading: Container(
                height: sizeFromHeight(12),
                width: sizeFromWidth(8),
                decoration: BoxDecoration(
                    color: ColorManager.WhiteScreen,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Icon(OsolIcon.estate),
                  ),
                ),
              ),
              title: Text(
                "Company Projects",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit:BoxFit.scaleDown,
                  child: Text(
                    "change your account data,email,password...etc",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
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
                  return MessageCompanyView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(12),
                width: sizeFromHeight(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: ColorManager.WhiteScreen,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/message.svg",
                      color: ColorManager.onboardingColorDots,
                    ),
                  ),
                ),
              ),
              title: Text(
                "Messages",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "2 new messages found",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
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
                  return AppSettingView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(12),
                width: sizeFromHeight(12),
                decoration: BoxDecoration(
                  color: ColorManager.WhiteScreen,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(color: Colors.grey, width: 1)                    ),
                child: Align(
                  alignment: Alignment.center,
                  child: FaIcon(
                    FontAwesomeIcons.gear,
                    color: ColorManager.settingMoreIcon,
                    size: 22,
                  ),
                ),
              ),
              title: Text(
                "App Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: FittedBox(
                  fit:BoxFit.scaleDown,
                  child: Text(
                    "change languages, dark moe and manage your app",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
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
                height: sizeFromHeight(12),
                width: sizeFromHeight(12),
                decoration: BoxDecoration(
                    color: ColorManager.WhiteScreen,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/examilation.svg",
                      color: ColorManager.personMoreIcon,
                    ),
                  ),
                ),
              ),
              title: Text(
                "About App",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "Learn More about Osol App",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
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
                  return CustomerServicesView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(12),
                width: sizeFromHeight(12),
                decoration: BoxDecoration(
                  color: ColorManager.WhiteScreen,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset("assets/images/cust.svg",color: ColorManager.onboardingColorDots,),
                  ),
                ),
              ),
              title: Text(
                "Customer Services",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "Contact us if you have some issues",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
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
                  return PrivacyAndPolicyView();
                }));
              },
              leading: Container(
                height: sizeFromHeight(12),
                width: sizeFromHeight(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: ColorManager.WhiteScreen,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/images/priv.svg",
                      color: ColorManager.personMoreIcon,
                    ),
                  ),
                ),
              ),
              title: Text(
                "Privacy and Policy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  "Contact us if you have some issue",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
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

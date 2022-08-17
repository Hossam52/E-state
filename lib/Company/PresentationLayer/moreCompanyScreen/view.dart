import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/companyProfile/view.dart';
import 'package:osol/Company/PresentationLayer/companyProjects/view.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/methods..dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/PrivacyAndPolicyScreen/view.dart';
import 'package:osol/User/PresentaionLayer/aboutScreen/view.dart';
import 'package:osol/User/PresentaionLayer/appsettingScreen/view.dart';
import 'package:osol/User/PresentaionLayer/customerServicesScreen/view.dart';

import '../companyMessage/view.dart';

class MoreViewCompanyScreen extends StatelessWidget {
  const MoreViewCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 15,
        ),
        child: ListView(
          children: [
            _listTileItem(
              context,
              title: 'My account',
              subTitle: 'Change your account email,password .... etc',
              screen: CompanyProfileScreen(),
              iconColor: ColorManager.personMoreIcon,
              svgPath: "assets/images/person.svg",
            ),
            _listTileItem(
              context,
              title: 'Company Projects',
              subTitle: 'change your account data,email,password...etc',
              screen: const CompanyProjectScreen(),
              icon: OsolIcon.estate,
            ),
            _listTileItem(
              context,
              title: 'Messages',
              subTitle: '2 new messeges found',
              iconColor: ColorManager.onboardingColorDots,
              screen: MessageCompanyView(),
              svgPath: "assets/images/message.svg",
            ),
            _listTileItem(
              context,
              title: 'App Settings',
              iconColor: ColorManager.settingMoreIcon,
              subTitle: 'change languages, dark moe and manage your app',
              screen: AppSettingView(),
              faIcon: FontAwesomeIcons.gear,
            ),
            _listTileItem(
              context,
              title: 'About App',
              iconColor: ColorManager.personMoreIcon,
              subTitle: 'Learn More about Osol App',
              screen: AboutView(),
              svgPath: "assets/images/examilation.svg",
            ),
            _listTileItem(
              context,
              title: "Customer Services",
              iconColor: ColorManager.onboardingColorDots,
              subTitle: 'Contact us if you have some issues',
              screen: CustomerServicesView(),
              svgPath: "assets/images/cust.svg",
            ),
            _listTileItem(
              context,
              iconColor: ColorManager.personMoreIcon,
              title: "PrivacyPolicy",
              subTitle: 'Contact us if you have some issue',
              screen: PrivacyAndPolicyView(),
              svgPath: "assets/images/priv.svg",
            ),
          ],
        ),
      ),
    );
  }

  ListTile _listTileItem(context,
      {required String title,
      required String subTitle,
      required Widget screen,
      String? svgPath,
      IconData? icon,
      IconData? faIcon,
      Color? iconColor}) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return screen;
          return CompanyProfileScreen();
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
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath,
                      color: iconColor,
                    )
                  : icon != null
                      ? Icon(icon, color: iconColor)
                      : faIcon != null
                          ? FaIcon(
                              faIcon,
                              color: iconColor,
                            )
                          : Container()),
        ),
      ),
      title: Text(title,
          style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .headline2!
                  .color
                  ?.withOpacity(0.9))),
      subtitle: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(subTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w400)),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: isDark(context) ? Colors.white : Colors.grey[800],
      ),
    );
  }
}

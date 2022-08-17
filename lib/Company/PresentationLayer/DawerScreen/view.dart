import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:osol/Company/PresentationLayer/HomeScreen/HomeScreenView.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';

import 'drawerMenueBody.dart';

class NavigationDrawerCompany extends StatefulWidget {
  const NavigationDrawerCompany({Key? key}) : super(key: key);

  static ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawerCompany>
    with WidgetsBindingObserver {
  // DynamicLink dynamicLink = DynamicLink();


  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreenTapClose: true,

      controller: NavigationDrawer.zoomDrawerController,
      menuBackgroundColor: ColorManager.AppBarHomeColorIcon,
      style: DrawerStyle.defaultStyle,
      //disableGesture: true,
      //clipMainScreen: true,
      borderRadius: 24.0,
      angle: 0,
      slideWidth: MediaQuery.of(context).size.width * 0.63,
      drawerShadowsBackgroundColor: Colors.blue.withOpacity(0.5),
      showShadow: true,
      mainScreenScale: 0,
      menuScreen: DrawerMenuBodyCompany(),
      mainScreen: HomeScreenCompanyView(),
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceOut,
      androidCloseOnBackTap: true,
      duration: const Duration(milliseconds: 200),
    );
  }
}

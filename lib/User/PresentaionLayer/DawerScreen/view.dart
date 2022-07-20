import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/HomeScreenView.dart';

import 'drawerMenueBody.dart';

class NavigationDrawer extends StatefulWidget {
  String token;

  NavigationDrawer({required this.token});

  static ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer>
    with WidgetsBindingObserver {
  // DynamicLink dynamicLink = DynamicLink();
  onWillPop() {
    debugPrint("sooo");
    if (HomeCubit.get(context).currentIndex == 0) {
      return showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text("Exit"),
                content: Text("Are you sure you want to leave the app?"),
                actions: [
                  CupertinoDialogAction(
                      child: Text("YES"),
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      }),
                  CupertinoDialogAction(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      })
                ],
              ));
    } else {
      return HomeCubit.get(context).changeIndexOfBody(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        state is HomeInitial ? HomeCubit.get(context).getDataOfHome() : null;
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () => onWillPop(),
          child: ZoomDrawer(
            mainScreenTapClose: true,
            disableDragGesture: true,
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
            menuScreen: DrawerMenuBody(),
            mainScreen: HomeScreenUserView(token: widget.token),
            openCurve: Curves.fastOutSlowIn,
            closeCurve: Curves.bounceOut,
            androidCloseOnBackTap: true,
            duration: Duration(milliseconds: 200),
          ),
        );
      },
    );
  }
}

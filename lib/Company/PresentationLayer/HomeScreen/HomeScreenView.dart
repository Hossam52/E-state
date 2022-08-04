import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:osol/Company/PresentationLayer/HomeScreen/units.dart';
import 'package:osol/Company/PresentationLayer/addBanner/view.dart';
import 'package:osol/Company/PresentationLayer/addFeature/view.dart';
import 'package:osol/Company/PresentationLayer/addScreen/addScreen.dart';

import 'package:osol/Company/PresentationLayer/moreCompanyScreen/view.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/unit_crud_view.dart';
import 'package:osol/Company/PresentationLayer/walletScreen/view.dart';
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';
import 'package:osol/User/PresentaionLayer/notification/view.dart';
import 'package:osol/shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';

import '../listScreen/listScreen.dart';

class HomeScreenCompanyView extends StatefulWidget {
  @override
  State<HomeScreenCompanyView> createState() => _HomeScreenUserViewState();
}

class _HomeScreenUserViewState extends State<HomeScreenCompanyView> {
  int currentIndex = 0;
  int index = 0;
  int indexBottomSheet = 0;
  bool overLaySheet = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Widget> screen = [
    HomeViewCompanyData(),
    ListScreen(),
    AddScreen(),
    WalletView(),
    MoreViewCompanyScreen(),
  ];
  List ScreenName = ["Home", "Listing", "Home", "Wallet", "More"];
  OverlayEntry? entry;
  int add = 0;
  int iconIndex = 0;

  void ShowOverlay() {
    final overLay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 60,
        width: size.width,
        child: buildOverlay(
          entry: entry,
        ),
      ),
    );
    overLay.insert(entry!);
  }

  void hideOverLay() {
    setState(() {
      entry?.remove();
      entry = null;
      iconIndex == 2;
    });
  }

  @override
  void deactivate() {
    BannersCubit.get(context).close();
    super.deactivate();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorManager.WhiteScreen,
          appBar: CustomVompany(
            context,
            Container(
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 25.h,
                    width: 17.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/estatehom.png"))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Estate GPS",
                        style: TextStyle(
                            color: ColorManager.firsthomemainicon,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        "Result that move you",
                        style: TextStyle(
                            color: ColorManager.firsthomemainicon,
                            fontWeight: FontWeight.bold,
                            fontSize: 6),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          body: currentIndex == 2 ? screen[0] : screen[currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: ColorManager.AppBarHomeColorIcon,
                  hoverColor: ColorManager.AppBarHomeColorIcon,
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 14,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: ColorManager.AppBarHomeColorIcon,
                  color: Colors.grey[400],
                  tabBorderRadius: 12,
                  tabs: [
                    GButton(
                      icon: FontAwesomeIcons.home,
                      iconSize: 16,
                      onPressed: () {
                        setState(() {
                          overLaySheet = false;
                        });
                      },
                      text: 'Home',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.listAlt,
                      iconSize: 20,
                      onPressed: () {
                        setState(() {
                          overLaySheet = false;
                        });
                      },
                      text: 'Listing',
                    ),
                    GButton(
                      icon: iconIndex == 2
                          ? Icons.add
                          : FontAwesomeIcons.plusSquare,
                      iconSize: 24,
                      onPressed: () {
                        setState(() {
                          overLaySheet = !overLaySheet;
                          overLaySheet == true
                              ? WidgetsBinding.instance!.addPostFrameCallback(
                                  (timeStamp) => ShowOverlay())
                              : hideOverLay();
                        });
                      },
                      text: '',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.wallet,
                      iconSize: 20,
                      text: 'Wallet',
                      onPressed: () {
                        setState(() {
                          overLaySheet = false;
                        });
                      },
                    ),
                    GButton(
                      icon: OsolIcon.label,
                      iconSize: 20,
                      text: 'More',
                      onPressed: () {
                        setState(() {
                          overLaySheet = false;
                        });
                      },
                    ),
                  ],
                  selectedIndex: currentIndex,
                  onTabChange: (index) async {
                    setState(() {
                      index != 2 ? iconIndex = 0 : null;
                      index != 2 ? currentIndex = index : iconIndex = index;
                      add == 0;
                      index == 2 ? add++ : null;
                    });
                    index == 2 && add == 1 ? null : hideOverLay();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class buildOverlay extends StatefulWidget {
  OverlayEntry? entry;

  buildOverlay({required this.entry});

  @override
  State<buildOverlay> createState() => _buildOverlayState();
}

class _buildOverlayState extends State<buildOverlay> {
  void hideOverLay() {
    setState(() {
      widget.entry?.remove();
      widget.entry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.entry?.remove();
              widget.entry = null;
            });
          },
          child: Container(
            color: Colors.grey.withOpacity(0.3),
            height: sizeFromHeight(1.4),
            width: double.infinity,
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Container(
                        width: sizeFromWidth(1.2),
                        child: ListTile(
                          onTap: () {
                            final unit =
                                UnitCubit.get(context).getDataFeature.first;
                            hideOverLay();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const UnitCrudView(),
                              ),
                            );
                          },
                          leading:
                              SvgPicture.asset("assets/images/addunit.svg"),
                          title: Text(
                            "Add Unit Listing",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: sizeFromWidth(1.4),
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: sizeFromWidth(1.2),
                      child: ListTile(
                        onTap: () {
                          hideOverLay();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => UnitCrudView(
                                adsType: 'Feature',
                              ),
                            ),
                          );
                        },
                        leading: SvgPicture.asset("assets/images/feature.svg"),
                        title: Text(
                          "Add Featured Advertisement",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: sizeFromWidth(1.4),
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: sizeFromWidth(1.2),
                      child: ListTile(
                        onTap: () {
                          hideOverLay();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AddBannerInCompanyScreen(),
                            ),
                          );
                        },
                        leading:
                            SvgPicture.asset("assets/images/addbanner.svg"),
                        title: Text(
                          "Add To main banner",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: sizeFromWidth(1.4),
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: sizeFromWidth(1.2),
                      child: ListTile(
                        onTap: () {
                          hideOverLay();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => NotificationScreen(),
                            ),
                          );
                        },
                        leading: FaIcon(
                          FontAwesomeIcons.solidBell,
                          color: ColorManager.onboardingColorDots,
                        ),
                        title: Text(
                          "Add Notification",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

AppBar CustomVompany(context, title) {
  return AppBar(
    elevation: 0,
    backgroundColor: ColorManager.WhiteScreen,
    toolbarHeight: 75.h,
    leadingWidth: 83.h,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Transform.scale(
        scale: 0.6,
        child: InkWell(
          onTap: () {
            NavigationDrawer.zoomDrawerController.toggle!();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: ColorManager.AppBarHomeColorIcon, width: 2),
            ),
            child: Icon(
              OsolIcon.menu,
              size: 22,
              color: ColorManager.AppBarHomeColorIcon,
            ),
          ),
        ),
      ),
    ),
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    centerTitle: true,
    title: title,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NotificationScreen(),
            ),
          );
        },
        icon: Icon(
          OsolIcon.bell,
          size: 20,
          color: ColorManager.AppBarIconcolorGrey,
        ),
      )
    ],
  );
}

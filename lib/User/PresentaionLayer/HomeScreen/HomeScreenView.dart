import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osol/Shared/customBottomAppBar.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/savedCubit/saved_cubit.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signIn/view.dart';
import 'package:osol/User/PresentaionLayer/notification/view.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:osol/shared/Customicon.dart';
import 'package:osol/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreenUserView extends StatefulWidget {
  String token;

  HomeScreenUserView({required this.token});

  @override
  State<HomeScreenUserView> createState() => _HomeScreenUserViewState();
}

class _HomeScreenUserViewState extends State<HomeScreenUserView> {
  @override
  void initState() {
    HomeCubit.get(context).getDataOfHome();
    HomeCubit.get(context).myToken == null &&
            AuthCubit.get(context).userToken == null
        ? null
        : ProfileCubit.get(context).getProfileData();
    super.initState();
  }

  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  //
  // void _onRefresh() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   HomeCubit.get(context).getDataOfHome();
  //
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   HomeCubit.get(context).getDataOfHome();
  //   if (mounted) setState(() {});
  //   _refreshController.loadComplete();
  // }

  List<String> names = [];

  getFirstName(name) {
    names = name.split(" ");
    return names[0];
  }

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
    var cubit = HomeCubit.get(context);
    var cubit2 = ProfileCubit.get(context);
    ProfileCubit.get(context).profileDate.isEmpty
        ? ProfileCubit.get(context).getProfileData()
        : null;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () => onWillPop.call(),
          child: Scaffold(
            drawer: NavigationDrawer(
              token: widget.token,
            ),
            appBar: cubit.currentIndex == 0
                ? HomeAppBar(
                    context,
                    Container(
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20.h,
                            width: 13.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      "assets/images/estatehom.png",
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estate GPS",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  "Result that move you",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : AppBarRemainsScreen(
                    context,
                    cubit.myToken == null &&
                            AuthCubit.get(context).userToken == null
                        ? Text(
                            "Hello",
                            style: Theme.of(context).textTheme.headline5,
                          )
                        : cubit2.profileDate.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                "Hello ${getFirstName(cubit2.profileModel?.client?.userName)}",
                                style: Theme.of(context).textTheme.headline5),
                    cubit.currentIndex == 4 ? true : false),
            body: state is LoadingGetBannerOfHomeState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.screen[cubit.currentIndex],
            bottomNavigationBar: MainUserNavigationBar(
              cubit: cubit,
              token: cubit.clienToken == null ? "" : cubit.token.toString(),
            ),
          ),
        );
      },
    );
  }
}

class CardHomeDetailsUserView extends StatelessWidget {
  int index;

  CardHomeDetailsUserView({required this.index});

  final controllerHome = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            child: Material(
              color: AppSettingCubit.get(context).isDark
                  ? ColorManager.DarkThemeBlackGround2
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: sizeFromWidth(1.5),
                                height: sizeFromHeight(4.69),
                                child: ListView.builder(
                                  controller: controllerHome,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: cubit.imagesFeature.length,
                                  itemBuilder: (context, index) {
                                    cubit.currentHomeBoardIndex = index;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: cubit.imagesFeature.isEmpty
                                          ? Container(
                                              width: sizeFromWidth(1.5),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            )
                                          : Container(
                                              width: sizeFromWidth(1.5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(cubit
                                                      .imagesFeature[index]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              left: sizeFromWidth(1.8),
                              child: IconButton(
                                  onPressed: () {
                                    SavedCubit.get(context).setSave(
                                        unitId: cubit.dataFeature[index].id);

                                    cubit.getFeatureOfClientHome();
                                  },
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: cubit.dataFeature[index]
                                                  .authFavourite ==
                                              true
                                          // ||
                                          //     cubit.color == true
                                          ? InkWell(
                                              onTap: () => cubit.changeColor(),
                                              child: FaIcon(
                                                FontAwesomeIcons.solidBookmark,
                                                color: ColorManager
                                                    .OnBoardingScreen,
                                                size: 16,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () => cubit.changeColor(),
                                              child: FaIcon(
                                                FontAwesomeIcons.bookmark,
                                                color: ColorManager
                                                    .OnBoardingScreen,
                                                size: 16,
                                              ),
                                            ),
                                    ),
                                  )),
                            ),
                            Positioned(
                              height: sizeFromHeight(2.8),
                              child: Container(
                                width: sizeFromWidth(1.5),
                                alignment: Alignment.center,
                                child: SmoothPageIndicator(
                                  controller: controllerHome,
                                  count: 3,
                                  effect: WormEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    activeDotColor:
                                        ColorManager.onboardingColorDots,
                                    dotColor: ColorManager
                                        .onboardingColorDotsNotActive,
                                    type: WormType.thin,
                                    // strokeWidth: 5,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                "${cubit.dataFeature[index].type}",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    OsolIcon.location,
                                    color: ColorManager.AppBarIconcolorGrey,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${cubit.dataFeature[index].city} , ${cubit.dataFeature[index].country}",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: sizeFromWidth(1.6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text:
                                            "\$ ${cubit.dataFeature[index].price == null ? 0 : cubit.dataFeature[index].price} ",
                                        style: TextStyle(
                                            color:
                                                ColorManager.OnBoardingScreen),
                                      ),
                                      TextSpan(
                                        text: "\\ Mnth",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.lightBlueAccent),
                                      )
                                    ])),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8, bottom: 3),
                              child: Container(
                                width: sizeFromWidth(1.6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      OsolIcon.square_,
                                      color: Colors.grey[400],
                                      size: 12,
                                    ),
                                    Text(
                                      "${cubit.dataFeature[index].area} m²",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.bath,
                                      color: Colors.grey[400],
                                      size: 12,
                                    ),
                                    Text(
                                      "${cubit.dataFeature[index].bathroom}",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.bed,
                                      size: 12,
                                      color: Colors.grey[400],
                                    ),
                                    Text(
                                      "${cubit.dataFeature[index].bedrooms}",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "3.4",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidStar,
                                        color: ColorManager.starColor,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTxtFieldWithSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: sizeFromHeight(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: sizeFromHeight(14),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: TextFormField(
                          onChanged: (v) {
                            debugPrint("$v");
                          },
                          cursorColor: Colors.grey[500],
                          cursorHeight: sizeFromHeight(17),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              bottom: 15,
                              left: 10,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          showMaterialModalBottomSheet(
                            enableDrag: true,
                            builder: (context) => CustomModelSheet(),
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: sizeFromHeight(14),
                          width: sizeFromWidth(8),
                          decoration: BoxDecoration(
                            color: ColorManager.AppBarHomeColorIcon,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/images/slider.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

AppBar HomeAppBar(
  BuildContext context,
  Widget title,
) {
  return AppBar(
    toolbarHeight: 75.h,
    leadingWidth: 83.h,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Transform.scale(
        scale: 0.6,
        child: InkWell(
          onTap: () {
            NavigationDrawer.zoomDrawerController.open!();
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SearchScreen()));
        },
        icon: Icon(
          OsolIcon.search,
          size: 20,
          color: ColorManager.AppBarIconcolorGrey,
        ),
      ),
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

AppBar AppBarRemainsScreen(BuildContext context, Widget title, bool isMore) {
  return AppBar(
    toolbarHeight: 75.h,
    leadingWidth: 83.h,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Transform.scale(
        scale: 0.6,
        child: InkWell(
          onTap: () {
            NavigationDrawer.zoomDrawerController.open!();
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
    centerTitle: false,
    title: title,
    actions: isMore
        ? [
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
          ]
        : [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchScreen()));
              },
              icon: Icon(
                OsolIcon.search,
                size: 20,
                color: ColorManager.AppBarIconcolorGrey,
              ),
            ),
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

class MainUserNavigationBar extends StatelessWidget {
  var cubit;
  String token;

  MainUserNavigationBar({required this.cubit, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            var cubit2 = AuthCubit.get(context);
            return Container(
              decoration: BoxDecoration(
                color: AppSettingCubit.get(context).isDark
                    ? ColorManager.DarkThemeBlackGround2
                    : Colors.white,
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
                    backgroundColor: AppSettingCubit.get(context).isDark
                        ? ColorManager.DarkThemeBlackGround2
                        : Colors.white,
                    rippleColor: ColorManager.AppBarHomeColorIcon,
                    hoverColor: ColorManager.AppBarHomeColorIcon,
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 14,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    duration: Duration(milliseconds: 800),
                    tabBackgroundColor: ColorManager.AppBarHomeColorIcon,
                    color: Colors.grey[400],
                    tabBorderRadius: 14,
                    tabs: [
                      GButton(
                        icon: FontAwesomeIcons.home,
                        iconSize: 16,
                        text: 'Home',
                        onPressed: () {},
                      ),
                      GButton(
                        icon: OsolIcon.location,
                        iconSize: 18,
                        text: 'Map',
                        onPressed: () {
                          cubit2.userToken == null && cubit.myToken == null
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SignInView(),
                                  ),
                                )
                              : null;
                        },
                      ),
                      GButton(
                        icon: OsolIcon.category,
                        iconSize: 18,
                        text: 'Companies',
                        onPressed: () {
                          cubit2.userToken == null && cubit.myToken == null
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SignInView(),
                                  ),
                                )
                              : null;
                        },
                      ),
                      GButton(
                        icon: OsolIcon.images,
                        iconSize: 18,
                        text: 'Compare',
                        onPressed: () {
                          cubit2.userToken == null && cubit.myToken == null
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SignInView(),
                                  ),
                                )
                              : null;
                        },
                      ),
                      GButton(
                        icon: OsolIcon.label,
                        iconSize: 20,
                        text: 'More',
                        onPressed: () {
                          cubit2.userToken == null && cubit.myToken == null
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SignInView(),
                                  ),
                                )
                              : null;
                        },
                      ),
                    ],
                    selectedIndex: cubit.currentIndex,
                    onTabChange: (index) {
                      cubit.changeIndexOfBody(index);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

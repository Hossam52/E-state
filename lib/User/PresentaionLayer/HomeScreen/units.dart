import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/customListLabel.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/featureViewAllScreen.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/shared/Customicon.dart';
import 'package:osol/shared/constants.dart';

import '../../BussinssLogic/authCubit/auth_cubit.dart';
import 'HomeScreenView.dart';

class ListViewDetails extends StatelessWidget {
  DecorationImage image;
  String txt;

  ListViewDetails({
    required this.image,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Container(
        height: sizeFromHeight(3.6),
        width: sizeFromWidth(1.3),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: image,
              ),
              height: sizeFromHeight(3),
              width: double.infinity,
            ),
            Positioned(
                child: Container(
              height: sizeFromHeight(3),
              width: sizeFromWidth(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.transparent,
                      ColorManager.OnBoardingScreen.withOpacity(0.3),
                    ],
                  )),
            )),
            // Positioned(
            //     left: 40,
            //     top: 50,
            //     child: Text(
            //       "Sale",
            //       style: TextStyle(
            //           fontSize: 28,
            //           fontWeight: FontWeight.bold,
            //           color: ColorManager.WhiteScreen),
            //     )),
            Positioned(
                left: 40,
                top: 90,
                child: Container(
                  height: 70.h,
                  width: 100.w,
                  child: Text(
                    "${txt}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.WhiteScreen),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class ListViewCmpanyDetails extends StatelessWidget {
  DecorationImage image;
  String txt;

  ListViewCmpanyDetails({
    required this.image,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Container(
        height: sizeFromHeight(3.6),
        width: sizeFromWidth(1.3),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: image,
              ),
              height: sizeFromHeight(3),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class pageViewDetails extends StatelessWidget {
  String image;
  String txt;
  String city;
  String country;
  String area;
  String bathroom;
  String bedroom;
  String strnum;
  String price;
  int index;

  pageViewDetails({
    required this.index,
    required this.image,
    required this.txt,
    required this.bathroom,
    required this.country,
    required this.city,
    required this.area,
    required this.bedroom,
    required this.strnum,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var cubit2 = ProfileCubit.get(context);
        var cubit3 = AuthCubit.get(context);
        return InkWell(
          onTap: cubit3.userToken == null && cubit.myToken == null
              ? () {}
              : () {
                  UnitClientCubit.get(context)
                      .getUnitId(cubit.dataFeature[index].id);
                  debugPrint("${cubit.dataFeature[index].view}");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UnitsDetailsScreen(),
                    ),
                  );
                },
          child: Material(
            color: AppSettingCubit.get(context).isDark
                ? ColorManager.DarkThemeBlackGround2
                : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "$txt",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              OsolIcon.location,
                              color: ColorManager.AppBarIconcolorGrey,
                              size: 10.w,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "$city , $country",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "\$ $price ",
                                style: TextStyle(
                                    color: ColorManager.OnBoardingScreen),
                              ),
                              TextSpan(
                                text: "\\ Mnth",
                                style: TextStyle(color: Colors.lightBlueAccent),
                              )
                            ])),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FaIcon(
                                OsolIcon.square_,
                                color: Colors.grey[400],
                                size: 12,
                              ),
                              Text(
                                "$area m²",
                                style: Theme.of(context).textTheme.headline4,
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
                                "$bathroom",
                                style: Theme.of(context).textTheme.headline4,
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
                                "$bedroom",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "$strnum",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: ColorManager.starColor,
                                size: 12,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}

class CardHomeRecentlyWatchedView extends StatelessWidget {
  int index;

  CardHomeRecentlyWatchedView({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Container(
          decoration: BoxDecoration(
              color: ColorManager.DarkThemeBlackGround2,
              border: Border.all(color: Colors.lightBlueAccent, width: 0.5),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            cubit.imagesPopular.first,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
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
                        padding: const EdgeInsets.only(left: 8.0, top: 2),
                        child: Text(
                          "${cubit.dataPopular[index].type}",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Container(
                          width: sizeFromWidth(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text:
                                      "\$ ${cubit.dataPopular[index].price == null ? 0 : cubit.dataPopular[index].price.toString().length > 6 ? cubit.dataPopular[index].price.toString().substring(0, 1) : cubit.dataPopular[index].price.toString()} ${cubit.dataPopular[index].price.toString().length > 3 && cubit.dataPopular[index].price.toString().length < 6 ? "K" : cubit.dataPopular[index].price.toString().length > 6 && cubit.dataPopular[index].price.toString().length < 9 ? "M" : "B"}",
                                  style: TextStyle(
                                      color: ColorManager.OnBoardingScreen),
                                ),
                                TextSpan(
                                  text: "\\ Mnth",
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                )
                              ])),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              "${cubit.dataPopular[index].city} , ${cubit.dataPopular[index].country}",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.homeColorFeature,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FaIcon(
                                OsolIcon.square_,
                                color: Colors.grey[400],
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${cubit.dataPopular[index].area} m²",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FaIcon(
                                FontAwesomeIcons.bath,
                                color: Colors.grey[400],
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${cubit.dataPopular[index].bathroom}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FaIcon(
                                FontAwesomeIcons.bed,
                                size: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${cubit.dataPopular[index].bedrooms}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: ColorManager.starColor,
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "3.4",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
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

class HomeViewData extends StatelessWidget {
  List<HomeScreenSliderModel> homeScreenSliderData = [
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "60%"),
  ];
  List<String> names = [];

  getFirstName(name) {
    names = name.split(" ");
    return names[0];
  }

  onWillPop(context) {
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
    var cubit3 = AuthCubit.get(context);
    HomeCubit.get(context).myToken == null &&
            AuthCubit.get(context).userToken == null
        ? null
        : UnitClientCubit.get(context).getUnitById;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit.dataFeature.isEmpty &&
                cubit.dataBanner.isEmpty &&
                cubit.dataPopular.isEmpty
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                ),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: sizeFromHeight(11),
                        child: Container(
                          height: sizeFromHeight(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "Hello ${cubit2.profileModel?.client?.userName == null ? "" : getFirstName(cubit2.profileModel?.client?.userName)}",
                                    style:
                                        Theme.of(context).textTheme.headline1),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: sizeFromHeight(3.5),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: cubit.dataBanner.length == null
                                ? homeScreenSliderData.length
                                : cubit.dataBanner.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                // onTap: cubit3.userToken == null &&
                                //         cubit.myToken == null
                                //     ? () {}
                                //     : () {
                                //         UnitClientCubit.get(context)
                                //             .getUnitId(cubit.dataBanner[index].id);
                                //         Navigator.of(context).push(
                                //           MaterialPageRoute(
                                //             builder: (_) => UnitsDetailsScreen(),
                                //           ),
                                //         );
                                //       },
                                child: ListViewDetails(
                                    image: cubit.dataBanner.length == null
                                        ? DecorationImage(
                                            image: AssetImage(
                                              homeScreenSliderData[index].image,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: NetworkImage(
                                              "${cubit.dataBanner[index].image}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                    txt: cubit.dataBanner.length == null
                                        ? homeScreenSliderData[index].Text
                                        : cubit.dataBanner[index].description
                                            .toString()),
                              );
                            }),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Container(
                        height: sizeFromHeight(13.7),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Looking For",
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: 10, start: 20.0, bottom: 10),
                        child: Container(
                          height: sizeFromHeight(18),
                          child: ListLabelInDetails(
                            num: 200,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                      ),
                      child: Container(
                        height: sizeFromHeight(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Features",
                                style: Theme.of(context).textTheme.headline2),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            FeatureViewAllScreen()));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    child:
                                        Icon(Icons.arrow_forward_ios, size: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    cubit.imagesFeature.isNotEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20.0,
                              ),
                              child: Container(
                                height: sizeFromHeight(2.8),
                                child: ListView.builder(
                                    itemCount: cubit.dataFeature.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: cubit3.userToken == null &&
                                                cubit.myToken == null
                                            ? () {}
                                            : () {
                                                UnitClientCubit.get(context)
                                                    .getUnitId(cubit
                                                        .dataFeature[index].id);
                                                debugPrint(
                                                    "${cubit.dataFeature[index].view}");
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        UnitsDetailsScreen(),
                                                  ),
                                                );
                                              },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: CardHomeDetailsUserView(
                                            index: index,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                      ),
                      child: Container(
                        height: sizeFromHeight(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Near you",
                                style: Theme.of(context).textTheme.headline2),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text("View All",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    child:
                                        Icon(Icons.arrow_forward_ios, size: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Container(
                          height: sizeFromHeight(5.1),
                          width: 327.w,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: cubit.dataFeature.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: pageViewDetails(
                                    index: index,
                                    country: cubit.dataFeature[index].country
                                        .toString(),
                                    city: cubit.dataFeature[index].city
                                        .toString(),
                                    price:
                                        cubit.dataFeature[index].price == null
                                            ? "0"
                                            : cubit.dataFeature[index].price
                                                .toString(),
                                    area: cubit.dataFeature[index].area
                                        .toString(),
                                    bathroom: cubit.dataFeature[index].bathroom
                                        .toString(),
                                    bedroom: cubit.dataFeature[index].bedrooms
                                        .toString(),
                                    strnum: "4",
                                    image: cubit.imagesFeature[0],
                                    txt: cubit.dataFeature[index].type
                                        .toString(),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                      ),
                      child: Container(
                        height: sizeFromHeight(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Popular watched",
                                style: Theme.of(context).textTheme.headline2),
                          ],
                        ),
                      ),
                    )),
                    cubit.imagesPopular.isNotEmpty
                        ? SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 4,
                              childAspectRatio: 1.8 / 1.9,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, left: 3),
                                  child: cubit.dataPopular.isEmpty
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : InkWell(
                                          onTap: cubit3.userToken == null &&
                                                  cubit.myToken == null
                                              ? () {}
                                              : () {
                                                  UnitClientCubit.get(context)
                                                      .getUnitId(cubit
                                                          .dataPopular[index]
                                                          .id);
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          UnitsDetailsScreen(),
                                                    ),
                                                  );
                                                },
                                          child: CardHomeRecentlyWatchedView(
                                            index: index,
                                          ),
                                        ),
                                );
                              },
                              childCount: cubit.dataPopular.length,
                            ),
                          )
                        : SliverToBoxAdapter()
                  ],
                ),
              );
      },
    );
  }
}

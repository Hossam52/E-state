import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/customListLabel.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/featureViewAllScreen.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/common_models/unit_model.dart';
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
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
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
                child: SizedBox(
                  height: 70.h,
                  width: 100.w,
                  child: Text(
                    txt,
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
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
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
  final UnitModel unit;

  const pageViewDetails({required this.unit});

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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UnitsDetailsScreen(
                        unitId: unit.id!,
                      ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5),
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(unit.images!.first),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              unit.type!,
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
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "${unit.city} , ${unit.country}",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: "\$ ${unit.price} ",
                                style: TextStyle(
                                    color: ColorManager.OnBoardingScreen),
                              ),
                              const TextSpan(
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
                                "${unit.area} m²",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.bath,
                                color: Colors.grey[400],
                                size: 12,
                              ),
                              Text(
                                "${unit.bathroom}",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.bed,
                                size: 12,
                                color: Colors.grey[400],
                              ),
                              Text(
                                "${unit.bedrooms}",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "4",
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
  final UnitModel unit;
  const CardHomeRecentlyWatchedView({required this.unit});

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
              color: AppSettingCubit.get(context).isDark
                  ? ColorManager.DarkThemeBlackGround2
                  : Colors.white,
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
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            unit.images!.first,
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
                          "${unit.type}",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: SizedBox(
                          width: sizeFromWidth(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text:
                                      "\$ ${unit.price == null ? 0 : unit.price.toString().length > 6 ? unit.price.toString().substring(0, 1) : unit.price.toString()} ${unit.price.toString().length > 3 && unit.price.toString().length < 6 ? "K" : unit.price.toString().length > 6 && unit.price.toString().length < 9 ? "M" : "B"}",
                                  style: TextStyle(
                                      color: ColorManager.OnBoardingScreen),
                                ),
                                const TextSpan(
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
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${unit.city} , ${unit.country}",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
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
                    borderRadius: const BorderRadius.only(
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
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${unit.area} m²",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${unit.bathroom}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${unit.bedrooms}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
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
                title: const Text("Exit"),
                content: const Text("Are you sure you want to leave the app?"),
                actions: [
                  CupertinoDialogAction(
                      child: const Text("YES"),
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      }),
                  CupertinoDialogAction(
                      child: const Text("NO"),
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
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final features = cubit.featuresUnits;
        final populars = cubit.popularUnits;
        return features.isEmpty &&
                cubit.dataBanner.isEmpty &&
                cubit.popularUnits.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: sizeFromHeight(11),
                        child: SizedBox(
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
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: sizeFromHeight(3.5),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.dataBanner.isNotEmpty
                                ? cubit.dataBanner.length
                                : homeScreenSliderData.length,
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
                                    image: cubit.dataBanner.isEmpty
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
                                    txt: cubit.dataBanner.isEmpty
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
                      child: SizedBox(
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
                        padding: const EdgeInsetsDirectional.only(
                            top: 10, start: 20.0, bottom: 10),
                        child: SizedBox(
                          height: sizeFromHeight(18),
                          child: const UserFilterLabelsWidget(
                            displayCustomFilter: false,
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
                      child: SizedBox(
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
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    child: const Icon(Icons.arrow_forward_ios,
                                        size: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    features.isNotEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20.0,
                              ),
                              child: SizedBox(
                                height: sizeFromHeight(2.8),
                                child: ListView.builder(
                                    itemCount: features.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: cubit3.userToken == null &&
                                                cubit.myToken == null
                                            ? () {}
                                            : () {
                                                UnitClientCubit.get(context)
                                                    .getUnitId(cubit
                                                        .featuresUnits[index]
                                                        .id);
                                                debugPrint(
                                                    "${features[index].view}");
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        UnitsDetailsScreen(
                                                      unitId: cubit
                                                          .featuresUnits[index]
                                                          .id!,
                                                    ),
                                                  ),
                                                );
                                              },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: CardHomeDetailsUserView(
                                            unit: cubit.featuresUnits[index],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          )
                        : const SliverToBoxAdapter(),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                      ),
                      child: SizedBox(
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
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Container(
                                    child: const Icon(Icons.arrow_forward_ios,
                                        size: 18),
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
                        child: SizedBox(
                          height: sizeFromHeight(5.1),
                          width: 327.w,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: features.length,
                              itemBuilder: (context, index) {
                                final unit = features[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: pageViewDetails(
                                    unit: unit,
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
                      child: SizedBox(
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
                    populars.isNotEmpty
                        ? SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  child: populars.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : InkWell(
                                          onTap: cubit3.userToken == null &&
                                                  cubit.myToken == null
                                              ? () {}
                                              : () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          UnitsDetailsScreen(
                                                              unitId: populars[
                                                                      index]
                                                                  .id!),
                                                    ),
                                                  );
                                                },
                                          child: CardHomeRecentlyWatchedView(
                                            unit: populars[index],
                                          ),
                                        ),
                                );
                              },
                              childCount: populars.length,
                            ),
                          )
                        : const SliverToBoxAdapter()
                  ],
                ),
              );
      },
    );
  }
}

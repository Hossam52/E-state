import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/custom_app_bar_with_search.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/HomeScreenView.dart';

import '../../BussinssLogic/unitCubit/unit_cubit.dart';
import 'comparing_final_view.dart';

class CompareView extends StatefulWidget {
  @override
  State<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {
  @override
  void initState() {
    super.initState();
    AuthCubit.get(context).userToken == null &&
            HomeCubit.get(context).token == null
        ? null
        : UnitClientCubit.get(context).getAllUnitDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: state is ErrorGetUnitClientDetails
                ? CupertinoAlertDialog(
                    title: Text("Error On Loading Data"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        NavigationDrawer(token: "token")));
                          },
                          child: Text("Ok"))
                    ],
                  )
                : cubit.getAllDataList.isEmpty
                    ? Center(
                        child: Text(
                        "There Is No Data",
                        style: Theme.of(context).textTheme.headline1,
                      ))
                    : CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              height: sizeFromHeight(11),
                              child: CustomTxtFieldWithSearch(),
                            ),
                          ),
                          cubit.compareList.length == 0
                              ? SliverPadding(
                                  padding: EdgeInsets.zero,
                                  sliver: SliverToBoxAdapter(
                                    child:
                                        Container(height: 1, child: SizedBox()),
                                  ),
                                )
                              : SliverToBoxAdapter(
                                  child: Container(
                                    height: 120.h,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, left: 18, right: 18),
                                        child: Dismissible(
                                          key: ValueKey(cubit.compareList[0]),
                                          onDismissed:
                                              (DismissDirection direction) {
                                            cubit.removeIndexFromCompareList(
                                                0, 0);
                                          },
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Container(
                                            color: ColorManager.redHeartcolor,
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                          child: cubit.compareList[0],
                                        )),
                                  ),
                                ),
                          cubit.newIndex == 2
                              ? SliverToBoxAdapter(
                                  child: Container(
                                    height: 120.h,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, left: 18, right: 18),
                                        child: Dismissible(
                                          key: ValueKey(cubit.compareList),
                                          onDismissed:
                                              (DismissDirection direction) {
                                            cubit.removeIndexFromCompareList(
                                                1, 1);
                                          },
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Container(
                                            color: ColorManager.redHeartcolor,
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                          child: cubit.compareList[1],
                                        )),
                                  ),
                                )
                              : SliverPadding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  sliver: SliverGrid(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 2.4 / 2,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return GridCardsInCompare(
                                          currentImage: cubit
                                              .getAllDataList[index].images![0],
                                          country: cubit
                                              .getAllDataList[index].country
                                              .toString(),
                                          city: cubit.getAllDataList[index].city
                                              .toString(),
                                          price: cubit
                                              .getAllDataList[index].price
                                              .toString(),
                                          txt: cubit.getAllDataList[index].type
                                              .toString(),
                                          onTap: () {
                                            cubit.unitDetectedId.add(
                                                cubit.getAllDataList[index].id);
                                            debugPrint(cubit
                                                .getAllDataList[index].id
                                                .toString());
                                            cubit.addCompareToList(
                                                CompareUnitDetails(
                                                  id: cubit
                                                      .getAllDataList[index].id,
                                                  city: cubit
                                                      .getAllDataList[index]
                                                      .city
                                                      .toString(),
                                                  country: cubit
                                                      .getAllDataList[index]
                                                      .country
                                                      .toString(),
                                                  image:
                                                      "${cubit.getAllDataList[index].images![0]}",
                                                  txt: cubit
                                                      .getAllDataList[index]
                                                      .type
                                                      .toString(),
                                                ),
                                                id: cubit
                                                    .getAllDataList[index].id);
                                          },
                                        );
                                      },
                                      childCount: cubit.getAllDataList.length,
                                    ),
                                  ),
                                ),
                        ],
                      ),
          ),
          floatingActionButton: CustomFloatingActionButon(
            index: cubit.newIndex,
            compareList: cubit.compareList,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

class GridCardsInCompare extends StatefulWidget {
  void Function() onTap;
  String price;
  String txt;
  String city;
  String country;
  String currentImage;

  GridCardsInCompare(
      {required this.onTap,
      required this.country,
      required this.city,
      required this.price,
      required this.currentImage,
      required this.txt});

  @override
  State<GridCardsInCompare> createState() => _GridCardsInCompareState();
}

class _GridCardsInCompareState extends State<GridCardsInCompare> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
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
              flex: 3,
              child: Container(
                height: 68.h,
                // child: CachedNetworkImage(
                //   imageUrl: "${widget.currentImage}",
                //   imageBuilder: (context, imageProvider) => Container(
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: imageProvider,
                //           fit: BoxFit.cover,
                //           colorFilter: ColorFilter.mode(
                //               Colors.red, BlendMode.colorBurn)),
                //     ),
                //   ),
                //   placeholder: (context, url) =>
                //       Center(child: CircularProgressIndicator()),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        "${widget.currentImage}",
                      ),
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 5),
                child: Text(
                  "${widget.txt}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Row(
                  children: [
                    Icon(
                      OsolIcon.location,
                      color: ColorManager.AppBarIconcolorGrey,
                      size: 12,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${widget.city} , ${widget.country}",
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "\$ ${widget.price} ",
                    style: TextStyle(color: ColorManager.OnBoardingScreen),
                  ),
                  TextSpan(
                    text: "\\ Mnth",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  )
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompareUnitDetails extends StatefulWidget {
  String image;
  String txt;
  String city;
  String country;
  var id;

  CompareUnitDetails({
    required this.image,
    required this.txt,
    required this.city,
    required this.country,
    required this.id,
  });

  @override
  State<CompareUnitDetails> createState() => _CompareUnitDetailsState();
}

class _CompareUnitDetailsState extends State<CompareUnitDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppSettingCubit.get(context).isDark
          ? ColorManager.DarkThemeBlackGround2
          : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 5,
      child: Container(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
              child: Container(
                width: 80.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${widget.image}"),
                      fit: BoxFit.cover),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.txt}",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: 130.w,
                      child: Row(
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
                            "${widget.city} ,${widget.country}",
                            style: Theme.of(context).textTheme.headline4,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class CustomFloatingActionButon extends StatelessWidget {
  int index;
  List compareList;

  CustomFloatingActionButon({required this.compareList, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitClientCubit, UnitClientState>(
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: InkWell(
            onTap: () async {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ComparingScreen()));
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: index != 2
                      ? ColorManager.disabledButtons
                      : ColorManager.OnBoardingScreen,
                ),
                height: 60.h,
                alignment: Alignment.center,
                child: Text(
                  "Compare",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
        );
      },
    );
  }
}

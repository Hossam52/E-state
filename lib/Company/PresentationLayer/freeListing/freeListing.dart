import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osol/Company/PresentationLayer/UnitsScreenDetailsCompany/view.dart';
import 'package:osol/Company/businessLogicLayer/popularList/popular_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/customListLabel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularCubit, PopularState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = PopularCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorManager.WhiteScreen,
            toolbarHeight: 50,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
                size: 28,
              ),
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: Text(
              "Popular Listing",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: sizeFromHeight(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              height: sizeFromHeight(12),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200]?.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: TextFormField(
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
                            child: InkWell(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  isDismissible: true,
                                  animationCurve: Curves.bounceInOut,
                                  enableDrag: true,
                                  builder: (context) => Container(
                                    height: sizeFromHeight(1.5),
                                    width: 42.w,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            color: ColorManager.WhiteScreen,
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(20.0),
                                                topRight: const Radius.circular(
                                                    20.0))),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Container(
                                                          width:
                                                              sizeFromWidth(3),
                                                          height: 10,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black87,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Filter",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Clear all",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              FaIcon(
                                                                FontAwesomeIcons
                                                                    .eraser,
                                                                color: Colors
                                                                    .black,
                                                                size: 20,
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Container(
                                                        height:
                                                            sizeFromHeight(13),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(11),
                                                          border: Border.all(
                                                              color: ColorManager
                                                                  .AppBarHomeColorIcon,
                                                              width: 1.5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  cubit
                                                                      .changeIndexBottomSheet(
                                                                          0);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      sizeFromHeight(
                                                                          13),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: cubit.indexBottomSheet ==
                                                                            0
                                                                        ? ColorManager
                                                                            .AppBarHomeColorIcon
                                                                        : ColorManager
                                                                            .WhiteScreen,
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      "Sell",
                                                                      style:
                                                                          TextStyle(
                                                                        color: cubit.indexBottomSheet ==
                                                                                0
                                                                            ? ColorManager.WhiteScreen
                                                                            : Colors.black,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  cubit
                                                                      .changeIndexBottomSheet(
                                                                          1);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      sizeFromHeight(
                                                                          13),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: cubit.indexBottomSheet ==
                                                                            1
                                                                        ? ColorManager
                                                                            .AppBarHomeColorIcon
                                                                        : ColorManager
                                                                            .WhiteScreen,
                                                                  ),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      "Rent",
                                                                      style:
                                                                          TextStyle(
                                                                        color: cubit.indexBottomSheet ==
                                                                                1
                                                                            ? ColorManager.WhiteScreen
                                                                            : Colors.black,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    StackedCustomizeText(),
                                                    StackedCustomizeCardPrice(),
                                                    StackedCustomrequiredField(),
                                                    StackedFinishesAndPaints(),
                                                    StackedAdvertisor(),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: ColorManager
                                                          .AppBarHomeColorIcon,
                                                    ),
                                                    height: sizeFromHeight(13),
                                                    width: double.infinity,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Show Result",
                                                        style: TextStyle(
                                                            color: ColorManager
                                                                .WhiteScreen,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: sizeFromHeight(12),
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
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: sizeFromHeight(1.25),
                    child: DefaultTabController(
                      length: 4,
                      child: Scaffold(
                        backgroundColor: ColorManager.WhiteScreen,
                        appBar: AppBar(
                          toolbarHeight: 50,
                          leadingWidth: 0,
                          elevation: 0,
                          backgroundColor: ColorManager.WhiteScreen,
                          title: Container(
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorManager.onboardingColorDots,
                                ),
                              ),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          width: 3))),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: ColorManager.onboardingColorDots,
                              onTap: (numOfTapped) {
                                cubit.getTappedIndex(numOfTapped);
                              },
                              tabs: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Tab(
                                    text: "Accepted",
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Tab(
                                    text: "Rejected",
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Tab(
                                    text: "Expired",
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Tab(
                                    text: "Pending",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TabBarView(
                            children: [
                              state is changeIndexOfTapped ||
                                      state is changeIndexOfTapped
                                  ? Center(child: CircularProgressIndicator())
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 2.5 / 2,
                                      ),
                                      itemCount:
                                          cubit.detectedUnitList.length == null
                                              ? 0
                                              : cubit.detectedUnitList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 3.0, left: 3),
                                          child: cubit.detectedUnitList
                                                      .length ==
                                                  null
                                              ? null
                                              : CardFreeListingData(
                                                  type: cubit
                                                      .detectedUnitList[index]
                                                      .type
                                                      .toString(),
                                                  country: cubit
                                                      .detectedUnitList[index]
                                                      .country
                                                      .toString(),
                                                  city: cubit
                                                      .detectedUnitList[index]
                                                      .city
                                                      .toString(),
                                                  index: index,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${cubit.detectedUnitList[index].images?.first}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                              state is changeIndexOfTapped ||
                                      state is changeIndexOfTapped
                                  ? Center(child: CircularProgressIndicator())
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 2.5 / 2,
                                      ),
                                      itemCount:
                                          cubit.detectedUnitList.length == null
                                              ? 0
                                              : cubit.detectedUnitList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 3.0, left: 3),
                                          child: cubit.detectedUnitList
                                                      .length ==
                                                  null
                                              ? null
                                              : CardFreeListingData(
                                                  type: cubit
                                                      .detectedUnitList[index]
                                                      .type
                                                      .toString(),
                                                  country: cubit
                                                      .detectedUnitList[index]
                                                      .country
                                                      .toString(),
                                                  city: cubit
                                                      .detectedUnitList[index]
                                                      .city
                                                      .toString(),
                                                  index: index,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${cubit.detectedUnitList[index].images?.first}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                              state is changeIndexOfTapped ||
                                      state is changeIndexOfTapped
                                  ? Center(child: CircularProgressIndicator())
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 2.5 / 2,
                                      ),
                                      itemCount:
                                          cubit.detectedUnitList.length == null
                                              ? 0
                                              : cubit.detectedUnitList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 3.0, left: 3),
                                          child: cubit.detectedUnitList
                                                      .length ==
                                                  null
                                              ? null
                                              : CardFreeListingData(
                                                  type: cubit
                                                      .detectedUnitList[index]
                                                      .type
                                                      .toString(),
                                                  country: cubit
                                                      .detectedUnitList[index]
                                                      .country
                                                      .toString(),
                                                  city: cubit
                                                      .detectedUnitList[index]
                                                      .city
                                                      .toString(),
                                                  index: index,
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${cubit.detectedUnitList[index].images?.first}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                              state is changeIndexOfTapped ||
                                      state is changeIndexOfTapped
                                  ? Center(child: CircularProgressIndicator())
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 2.5 / 2,
                                      ),
                                      itemCount:
                                          cubit.detectedUnitList.length == null
                                              ? 0
                                              : cubit.detectedUnitList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 3.0, left: 3),
                                          child: cubit.detectedUnitList
                                                      .length ==
                                                  null
                                              ? null
                                              : CardFreeListingData(
                                                  type: cubit
                                                      .detectedUnitList[index]
                                                      .type
                                                      .toString(),
                                                  country: cubit
                                                      .detectedUnitList[index]
                                                      .country
                                                      .toString(),
                                                  city: cubit
                                                      .detectedUnitList[index]
                                                      .city
                                                      .toString(),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${cubit.detectedUnitList[index].images?.first}"),
                                                      fit: BoxFit.cover),
                                                  index: index,
                                                ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ),
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

class CardFreeListingData extends StatelessWidget {
  DecorationImage image;
  int index;
  String city;
  String country;
  String type;

  CardFreeListingData({
    required this.type,
    required this.image,
    required this.index,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            debugPrint(
                "${PopularCubit.get(context).detectedUnitList[index].id}");
            UnitCubit.get(context).changeId(
                id: PopularCubit.get(context).detectedUnitList[index].id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return UnitDetailsCompanyScreen(
                    unit: PopularCubit.get(context).detectedUnitList[index],
                  );
                },
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlueAccent, width: 0.5),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        image: image),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      "$type",
                      style: TextStyle(
                        color: ColorManager.TextHomeColor,
                        fontSize: 12,
                      ),
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
                          color: ColorManager.redHeartcolor,
                          size: 12,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "$city , $country ",
                          style: TextStyle(fontSize: 9),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/eye.svg"),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "18 Seen",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

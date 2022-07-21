import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osol/Company/PresentationLayer/UnitsScreenDetailsCompany/view.dart';
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/features/featuresModel.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:osol/common_models/unit_model.dart';

class HomeViewCompanyData extends StatefulWidget {
  const HomeViewCompanyData({Key? key}) : super(key: key);

  @override
  _HomeViewDataState createState() => _HomeViewDataState();
}

class _HomeViewDataState extends State<HomeViewCompanyData> {
  List<HomeScreenSliderModel> homeScreenSliderData = [
    HomeScreenSliderModel(image: "assets/images/maplabel.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/maplabel.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/maplabel.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/maplabel.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/maplabel.png", Text: "60%"),
  ];
  int currentIndex = 0;

  int index = 0;

  int indexBottomSheet = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 23.0,
      ),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                                            topRight:
                                                const Radius.circular(20.0))),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Container(
                                                      width: sizeFromWidth(3),
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black87,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
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
                                                            color: Colors.black,
                                                            fontSize: 18),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Clear all",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .eraser,
                                                            color: Colors.black,
                                                            size: 20,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Container(
                                                    height: sizeFromHeight(13),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11),
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
                                                              setState(() {
                                                                indexBottomSheet =
                                                                    0;
                                                              });
                                                            },
                                                            child: Container(
                                                              height:
                                                                  sizeFromHeight(
                                                                      13),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: indexBottomSheet ==
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
                                                                    color: indexBottomSheet ==
                                                                            0
                                                                        ? ColorManager
                                                                            .WhiteScreen
                                                                        : Colors
                                                                            .black,
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
                                                              setState(() {
                                                                indexBottomSheet =
                                                                    1;
                                                              });
                                                            },
                                                            child: Container(
                                                              height:
                                                                  sizeFromHeight(
                                                                      13),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: indexBottomSheet ==
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
                                                                    color: indexBottomSheet ==
                                                                            1
                                                                        ? ColorManager
                                                                            .WhiteScreen
                                                                        : Colors
                                                                            .black,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: ColorManager
                                                      .AppBarHomeColorIcon,
                                                ),
                                                height: sizeFromHeight(13),
                                                width: double.infinity,
                                                child: Align(
                                                  alignment: Alignment.center,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0, top: 20),
              child: BlocBuilder<BannersCubit, BannersState>(
                builder: (context, state) {
                  log('Banner is $state');
                  var cubit = BannersCubit.get(context);
                  // state is SuccessGetAllBannersCompany
                  //     ? print(
                  //         "Mostafa banner: ${cubit.bannerData[index].image!}")
                  //     : UnitCubit.get(context).getAllFunction();
                  return Container(
                    height: sizeFromHeight(3.5),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: state is SuccessGetAllBannersCompany
                            ? cubit.bannerData.length
                            : homeScreenSliderData.length,
                        itemBuilder: (context, index) {
                          return ListViewDetails(
                            image: state is SuccessGetAllBannersCompany
                                ? DecorationImage(
                                    image: NetworkImage(
                                        "${cubit.bannerData[index].image!}"),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: AssetImage(
                                        "${homeScreenSliderData[index].image}"),
                                    fit: BoxFit.scaleDown),
                            txt: state is SuccessGetAllBannersCompany
                                ? cubit.bannerData[index].description!
                                : "",
                          );
                        }),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 3, top: 0),
            child: Container(
              height: sizeFromHeight(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "Your Featured Ads",
                      style: TextStyle(
                          color: ColorManager.blackFontStyle,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Icon(Icons.arrow_forward_ios, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: BlocConsumer<UnitCubit, UnitState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = UnitCubit.get(context);
                if (cubit.getDataFeature.isEmpty) {
                  return _EmptyList(title: 'No Feature ads added');
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 0),
                  child: Container(
                    height: sizeFromHeight(2.1),
                    child: ListView.builder(
                        itemCount: cubit.getDataFeature.isNotEmpty
                            ? cubit.getDataFeature.length
                            : homeScreenSliderData.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _FeaturedItem(
                            featured: cubit.getDataFeature[index],
                            index: index,
                          );
                        }),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 3, top: 0),
            child: Container(
              height: sizeFromHeight(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "Company Project",
                      style: TextStyle(
                          color: ColorManager.blackFontStyle,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Icon(Icons.arrow_forward_ios, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          SliverToBoxAdapter(
            child: BlocConsumer<UnitCubit, UnitState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = UnitCubit.get(context);
                if (cubit.getDataPopular.isEmpty) {
                  return _EmptyList(title: 'No company projects');
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 0),
                  child: Container(
                    height: sizeFromHeight(2.1),
                    child: ListView.builder(
                        itemCount: cubit.getDataPopular != null
                            ? cubit.getDataPopular.length
                            : homeScreenSliderData.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: CardHomeDetailsCompanyView(
                              city: cubit.getDataPopular != null
                                  ? cubit.getDataPopular[index].city.toString()
                                  : "",
                              index: index,
                              image: cubit.getDataPopular != null
                                  ? DecorationImage(
                                      image: NetworkImage(cubit
                                          .getDataPopular[index].images![0]),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: AssetImage(
                                          "${homeScreenSliderData[index].image}"),
                                      fit: BoxFit.scaleDown),
                              departType: cubit.getDataPopular != null
                                  ? cubit.getDataPopular[index].type.toString()
                                  : "",
                              country: cubit.getDataPopular != null
                                  ? cubit.getDataPopular[index].country
                                      .toString()
                                  : "",
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardHomeDetailsCompanyView extends StatelessWidget {
  int index;
  DecorationImage image;
  String city;
  String country;
  String departType;

  CardHomeDetailsCompanyView({
    required this.index,
    required this.image,
    required this.city,
    required this.country,
    required this.departType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: sizeFromHeight(5),
                          width: sizeFromWidth(1.6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: image),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2),
                            child: Text(
                              "${departType}",
                              style: TextStyle(
                                color: ColorManager.TextHomeColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  OsolIcon.location,
                                  color: ColorManager.redHeartcolor,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "$city , $country",
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/eye.svg"),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "12 total seen",
                                  style: TextStyle(fontSize: 14),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            color: ColorManager.GreyColortext,
          ),
        ),
      ),
    );
  }
}

class _FeaturedItem extends StatelessWidget {
  const _FeaturedItem({Key? key, required this.featured, required this.index})
      : super(key: key);
  final UnitModel featured;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => UnitDetailsCompanyScreen(
                      unit: featured,
                    )));
      },
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: CardHomeDetailsCompanyView(
              city: featured.city.toString(),
              departType: featured.type.toString(),
              country: featured.country.toString(),
              index: index,
              image: DecorationImage(
                  image: NetworkImage(featured.images![0]),
                  fit: BoxFit.cover))),
    );
  }
}

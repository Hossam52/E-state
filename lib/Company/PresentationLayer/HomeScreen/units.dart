import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osol/Company/PresentationLayer/UnitsScreenDetailsCompany/view.dart';
import 'package:osol/Company/PresentationLayer/company_search/company_search_screen.dart';
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/methods..dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello',
                    style: TextStyle(
                        color: getInvertDarkmoodColor(context),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700)),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const CompanySearchScreen()));
                  },
                  icon: const Icon(Icons.search),
                  color: Colors.grey[500],
                ),
              ],
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
                  return SizedBox(
                    height: sizeFromHeight(3.5),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state is SuccessGetAllBannersCompany
                            ? cubit.bannerData.length
                            : homeScreenSliderData.length,
                        itemBuilder: (context, index) {
                          return ListViewDetails(
                            image: state is SuccessGetAllBannersCompany
                                ? DecorationImage(
                                    image: NetworkImage(
                                        cubit.bannerData[index].image!),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: AssetImage(
                                        homeScreenSliderData[index].image),
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
            child: SizedBox(
              height: sizeFromHeight(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text("Your Featured Ads",
                        style: Theme.of(context).textTheme.headline2
                        // TextStyle(
                        //     color: ColorManager.blackFontStyle,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: getInvertDarkmoodColor(context),
                        ),
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
                  return const _EmptyList(title: 'No Feature ads added');
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 0),
                  child: SizedBox(
                    height: sizeFromHeight(2.1),
                    child: ListView.builder(
                        itemCount: cubit.getDataFeature.isNotEmpty
                            ? cubit.getDataFeature.length
                            : homeScreenSliderData.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
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
            child: SizedBox(
              height: sizeFromHeight(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "Company Project",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: getInvertDarkmoodColor(context),
                        ),
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
                  return const _EmptyList(title: 'No company projects');
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 0),
                  child: SizedBox(
                    height: sizeFromHeight(2.1),
                    child: ListView.builder(
                        itemCount: cubit.getDataPopular != null
                            ? cubit.getDataPopular.length
                            : homeScreenSliderData.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            UnitDetailsCompanyScreen(
                                              unit: cubit.getDataPopular[index],
                                            )));
                              },
                              child: CardHomeDetailsCompanyView(
                                unit: cubit.getDataPopular[index],
                              ),
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
  const CardHomeDetailsCompanyView({required this.unit});
  final UnitModel unit;
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
            color: getDarkmoodColor(context),
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
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      unit.images!.first))),
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
                            child: Text("${unit.title} (${unit.type})",
                                style: Theme.of(context).textTheme.headline3),
                          ),
                          const SizedBox(
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
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/eye.svg"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${unit.watchNum} total seen",
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
            child: CardHomeDetailsCompanyView(unit: featured)));
  }
}

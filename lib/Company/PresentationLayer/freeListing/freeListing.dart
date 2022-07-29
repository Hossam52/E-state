import 'dart:developer';

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
import 'package:osol/Shared/component/filter_dialog.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/customListLabel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:osol/common_models/unit_model.dart';

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PopularCubit(context: context)..getDetectedPopularList(),
      child: BlocConsumer<PopularCubit, PopularState>(
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                  size: 28,
                ),
              ),
              shape: const ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              centerTitle: true,
              title: const Text(
                "Popular Listing",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
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
                                    contentPadding: const EdgeInsets.only(
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
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    isDismissible: true,
                                    animationCurve: Curves.bounceInOut,
                                    enableDrag: true,
                                    builder: (_) =>
                                        FilterDialog(onConfirmFilter: () {
                                      PopularCubit.get(context)
                                          .showResFromFilter();
                                    }),
                                    context: context,
                                    shape: const RoundedRectangleBorder(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SizedBox(
                      height: sizeFromHeight(18),
                      child: CompanyFilterLabelsWidget(
                        num: 200,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
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
                              child: Builder(builder: (context) {
                                return _StatuesesTabBar(cubit: cubit);
                              }),
                            ),
                          ),
                          body: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _gridView(),
                                _gridView(),
                                _gridView(),
                                _gridView(),
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
      ),
    );
  }

  Widget _gridView() {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        final cubit = PopularCubit.get(context);
        final units = cubit.displayedUnits;
        if (state is LoadingGetPopularListData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!cubit.isCategoryLoadedData) {
          return const Center(child: Text('Not loaded data'));
        }
        if (units.isEmpty) {
          return Center(
            child: Text(
              'No found items in ${cubit.selectedUnitCategory.title} category',
              style: TextStyle(fontSize: 18.sp),
            ),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 4,
            childAspectRatio: 2.5 / 2,
          ),
          itemCount: units.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 3.0, left: 3),
              child: CardFreeListingData(
                unit: units[index],
              ),
            );
          },
        );
      },
    );
  }
}

class _StatuesesTabBar extends StatelessWidget {
  const _StatuesesTabBar({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final PopularCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: ColorManager.onboardingColorDots, width: 3))),
      labelStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: ColorManager.onboardingColorDots,
      onTap: (numOfTapped) {
        cubit.getTappedIndex(numOfTapped);
      },
      tabs: [
        ...cubit.selectedCategory.statues
            .map(
              (e) => FittedBox(
                fit: BoxFit.scaleDown,
                child: Tab(
                  text: e.title,
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class CardFreeListingData extends StatelessWidget {
  final UnitModel unit;
  CardFreeListingData({required this.unit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return UnitDetailsCompanyScreen(
                    unit: unit,
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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(unit.images!.first),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      "${unit.type}",
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
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "${unit.city} , ${unit.country} ",
                          style: const TextStyle(fontSize: 9),
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
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "${unit.watchNum} Seen",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
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

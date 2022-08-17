
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osol/Company/PresentationLayer/UnitsScreenDetailsCompany/view.dart';
import 'package:osol/Company/businessLogicLayer/popularList/popular_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/methods..dart';
import 'package:osol/Shared/component/search_and_filter_widget.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/customListLabel.dart';
import 'package:osol/common_models/unit_model.dart';

class PopularScreen extends StatefulWidget {
  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final searchController = TextEditingController();
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
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 50,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              shape: const ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              centerTitle: true,
              title: const Text(
                "Popular Listing",
              ),
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SearchAndFilterWidget(
                      onConfirmFilter:
                          PopularCubit.get(context).showResFromFilter,
                      onSearch: () =>
                          cubit.selectedUnitCategory.onTapped(forceTap: true)),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 20.h),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SizedBox(
                      height: sizeFromHeight(18),
                      child: const CompanyFilterLabelsWidget(
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
                          appBar: AppBar(
                            leading: Container(),
                            toolbarHeight: 50,
                            leadingWidth: 0,
                            elevation: 0,
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
      labelColor: getInvertDarkmoodColor(context),
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
  const CardFreeListingData({required this.unit});

  @override
  Widget build(BuildContext context) {
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
                child: Text("${unit.type}",
                    style: Theme.of(context).textTheme.headline4),
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
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/eye.svg"),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${unit.watchNum} Seen",
                      style: Theme.of(context).textTheme.headline4,
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
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osol/Company/PresentationLayer/freeListing/freeListing.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/component/search_and_filter_widget.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/common_models/unit_model.dart';

class CompanySearchScreen extends StatelessWidget {
  const CompanySearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        FilterCubit.instance(context).resetSearchText();
        return UnitCubit(context)..searchInUnits();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Search units'),
          titleTextStyle: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700),
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: BlocBuilder<UnitCubit, UnitState>(
            builder: (context, state) {
              final cubit = UnitCubit.get(context);
              List<UnitModel> units = cubit.getUnitsBySearchType;
              return Column(
                children: [
                  SearchAndFilterWidget(
                    onSearch: () {
                      cubit.searchInUnits();
                    },
                    onConfirmFilter: () {
                      cubit.searchInUnits();
                    },
                  ),
                  _SearchInWidget(
                    selectedSearch: UnitCubit.get(context).selectedSearchIn,
                  ),
                  SizedBox(height: sizeFromHeight(25)),
                  Expanded(
                    child: state is LoadingGetFeaturesData ||
                            state is LoadingGetPopularData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 4,
                              childAspectRatio: 2.5 / 2,
                            ),
                            itemCount: units.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 3.0, left: 3),
                                child: CardFreeListingData(
                                  unit: units[index],
                                ),
                              );
                            },
                          ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SearchInWidget extends StatelessWidget {
  const _SearchInWidget({Key? key, required this.selectedSearch})
      : super(key: key);
  final SearchInEnum selectedSearch;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: sizeFromHeight(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border:
              Border.all(color: ColorManager.AppBarHomeColorIcon, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildItem(
                  isSelected: selectedSearch == SearchInEnum.feature,
                  searchIn: SearchInEnum.feature,
                  title: 'Features'),
            ),
            Expanded(
              child: _buildItem(
                  isSelected: selectedSearch == SearchInEnum.popular,
                  searchIn: SearchInEnum.popular,
                  title: 'Populars'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required SearchInEnum searchIn,
    required bool isSelected,
  }) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          UnitCubit.get(context).changeSelectedSearchType(searchIn);
        },
        child: Container(
          height: sizeFromHeight(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? ColorManager.AppBarHomeColorIcon
                : ColorManager.WhiteScreen,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? ColorManager.WhiteScreen : Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    });
  }
}

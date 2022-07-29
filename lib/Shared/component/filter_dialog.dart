import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_states.dart';
import 'package:osol/Shared/component/stacked_fields.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/shared/constants.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key, required this.onConfirmFilter})
      : super(key: key);
  final VoidCallback onConfirmFilter;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterStates>(
      builder: (context, filterState) {
        final filterCubit = FilterCubit.instance(context);
        var filterType = filterCubit.filterType;
        PropertyTypeFilter propertyTypeFilter = filterCubit.propertyTypeFilter;
        RequiredFieldsFilter requiredFieldsFilter =
            filterCubit.requiredFieldsFilter;
        PaymentGatewayFilter paymentGatewayFilter =
            filterCubit.paymentGatewayFilter;
        FinishedTypeFilter finishedTypeFilter = filterCubit.finishedTypeFilter;
        AdvisorFilter advisorFilter = filterCubit.advisorFilter;
        return Container(
          decoration: BoxDecoration(
              color: ColorManager.WhiteScreen,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          height: sizeFromHeight(1.1),
          width: 42.w,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorManager.WhiteScreen,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: sizeFromWidth(3),
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Filter",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      filterCubit.resetFilters();
                                    },
                                    child: const Text(
                                      "Clear all",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const FaIcon(
                                    FontAwesomeIcons.eraser,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: sizeFromHeight(17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              border: Border.all(
                                  color: ColorManager.AppBarHomeColorIcon,
                                  width: 1.5),
                            ),
                            child: Row(
                              children: [
                                for (int i = 0;
                                    i < (filterType.list?.length ?? 0);
                                    i++)
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        filterCubit.changeFilterType(i);
                                      },
                                      child: Container(
                                        height: sizeFromHeight(13),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: filterType.selectedIndex == i
                                              ? ColorManager.AppBarHomeColorIcon
                                              : ColorManager.WhiteScreen,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            filterType.list![i],
                                            style: TextStyle(
                                              color:
                                                  filterType.selectedIndex == i
                                                      ? ColorManager.WhiteScreen
                                                      : Colors.black,
                                              fontSize: 18,
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
                        FilterSection(
                          list: propertyTypeFilter.list ?? [],
                          selectedIndex: propertyTypeFilter.selectedIndex,
                          onChangeIndex: filterCubit.changePropertyIndex,
                          title: 'Property Type',
                          svgPath: 'assets/images/home.svg',
                        ),
                        // StackedCustomizeCardPrice(),
                        const PriceFilterSection(
                          title: 'Price',
                          icon: FontAwesomeIcons.dollarSign,
                        ),
                        FilterSection(
                          list: requiredFieldsFilter.list ?? [],
                          selectedIndex: requiredFieldsFilter.selectedIndex,
                          onChangeIndex: filterCubit.changeRequiredFieldsIndex,
                          title: 'Required fields',
                          svgPath: 'assets/images/home.svg',
                        ),
                        if (filterCubit.filterType.selectedIndex == 0)
                          FilterSection(
                            list: paymentGatewayFilter.list ?? [],
                            selectedIndex: paymentGatewayFilter.selectedIndex,
                            onChangeIndex: filterCubit.changePaymentGatwayIndex,
                            title: 'Payment gateway',
                            icon: FontAwesomeIcons.wallet,
                          ),
                        FilterSection(
                          list: finishedTypeFilter.list ?? [],
                          selectedIndex: finishedTypeFilter.selectedIndex,
                          onChangeIndex: filterCubit.changeFinishedTypeIndex,
                          title: 'Finished Type',
                          svgPath: 'assets/images/home.svg',
                        ),
                        FilterSection(
                          list: advisorFilter.list ?? [],
                          selectedIndex: advisorFilter.selectedIndex,
                          onChangeIndex: filterCubit.changeAdvisorIndex,
                          title: 'Advertisor',
                          svgPath: 'assets/images/home.svg',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            floatingActionButton: _ShowResultButton(
              onPressed: onConfirmFilter,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}

class _ShowResultButton extends StatelessWidget {
  const _ShowResultButton({Key? key, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.onboardingColorDots,
        ),
        height: sizeFromHeight(10),
        child: InkWell(
          onTap: () {
            onPressed();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorManager.AppBarHomeColorIcon,
              ),
              height: sizeFromHeight(13),
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Show Result",
                  style:
                      TextStyle(color: ColorManager.WhiteScreen, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

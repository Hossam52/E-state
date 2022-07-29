import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_states.dart';
import 'package:osol/shared/constants.dart';

class _StackedContainer extends StatelessWidget {
  const _StackedContainer(
      {Key? key,
      required this.title,
      this.icon,
      this.svgPath,
      required this.child})
      : super(key: key);
  final String title;
  final IconData? icon;
  final String? svgPath;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              height: sizeFromHeight(9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black45, width: 1),
              ),
              child: child),
        ),
        Positioned(
          top: 10,
          left: sizeFromWidth(11),
          child: Container(
            color: ColorManager.WhiteScreen,
            height: 20,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                if (svgPath != null)
                  SvgPicture.asset(
                    svgPath!,
                  )
                else if (icon != null)
                  FaIcon(
                    icon,
                    size: 14,
                    color: Colors.black54,
                  ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FilterSection extends StatelessWidget {
  const FilterSection(
      {Key? key,
      required this.list,
      required this.title,
      required this.onChangeIndex,
      this.selectedIndex = 0,
      this.icon,
      this.svgPath})
      : super(key: key);
  final List<String> list;
  final void Function(int) onChangeIndex;
  final int selectedIndex;
  final String title;
  final IconData? icon;
  final String? svgPath;

  @override
  Widget build(BuildContext context) {
    return _StackedContainer(
      title: title,
      icon: icon,
      svgPath: svgPath,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, listIndex) {
                  return InkWell(
                    onTap: () {
                      onChangeIndex(listIndex);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: selectedIndex == listIndex
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: ColorManager.AppBarHomeColorIcon,
                                ),
                              )
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                list[listIndex],
                                style: TextStyle(
                                    fontWeight: selectedIndex == listIndex
                                        ? FontWeight.bold
                                        : null),
                              )),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class PriceFilterSection extends StatelessWidget {
  const PriceFilterSection(
      {Key? key, required this.title, this.icon, this.svgPath})
      : super(key: key);
  final String title;
  final IconData? icon;
  final String? svgPath;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterStates>(
      builder: (context, state) {
        final filterCubit = FilterCubit.instance(context);
        return _StackedContainer(
          title: title,
          icon: icon,
          svgPath: svgPath,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RangeSlider(
                      values: RangeValues(filterCubit.startFilterPrice,
                          filterCubit.endFilterPrice),
                      labels: RangeLabels(
                          filterCubit.startFilterPrice.toString(),
                          filterCubit.endFilterPrice.toString()),
                      onChanged: filterCubit.changePriceRange,
                      min: filterCubit.minPriceSlider,
                      max: filterCubit.maxPriceSlider,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "\$${filterCubit.startFilterPrice.toStringAsFixed(1)}"),
                        Text(
                            "\$${filterCubit.endFilterPrice.toStringAsFixed(1)}")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';

class IndoorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Indoor",
              style: TextStyle(
                  color: ColorManager.onboardingColorDots,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            _RowItem(
              title: 'Air Condition',
              isSelected: cubit.valueAirCondition,
              changeSelected: cubit.changeAirConditionValue,
            ),
            _RowItem(
              title: 'Cable Tv',
              isSelected: cubit.valueCableTV,
              changeSelected: cubit.changeCableTVValue,
            ),
            _RowItem(
                title: 'Computer',
                isSelected: cubit.valueComputer,
                changeSelected: cubit.changeComputerValue),
            _RowItem(
                title: 'GasLine',
                isSelected: cubit.valueGasline,
                changeSelected: cubit.changeGaslineValue),
            _RowItem(
                title: 'DishShawer',
                isSelected: cubit.valueDishwasher,
                changeSelected: cubit.changeDishwasherValue),
            _RowItem(
                title: 'Internet',
                isSelected: cubit.valueInternet,
                changeSelected: cubit.changeInternetValue),
            _RowItem(
                title: 'Microwave',
                isSelected: cubit.valueMicrowave,
                changeSelected: cubit.changeMicrowaveValue),
          ],
        );
      },
    );
  }
}

class OutdoorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = UnitCubit.get(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Outdoor",
            style: TextStyle(
                color: ColorManager.onboardingColorDots,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          _RowItem(
              title: 'Balcony',
              svgPath: 'assets/images/balcony.svg',
              isSelected: cubit.valuebalcony,
              changeSelected: cubit.changeBalconyValue),
          _RowItem(
              title: 'Lift',
              svgPath: 'assets/images/lift.svg',
              isSelected: cubit.valueLift,
              changeSelected: cubit.changeLiftValue),
          _RowItem(
              title: 'Grill',
              svgPath: 'assets/images/grill.svg',
              isSelected: cubit.valueGrill,
              changeSelected: cubit.changeGrillValue),
          _RowItem(
              title: 'Pool',
              svgPath: 'assets/images/pool.svg',
              isSelected: cubit.valuePool,
              changeSelected: cubit.changePoolValue),
          _RowItem(
              title: 'Security',
              isSelected: cubit.valueSecurity,
              changeSelected: cubit.changeSecurityValue),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    Key? key,
    required this.title,
    required this.isSelected,
    this.svgPath,
    this.changeSelected,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  final String? svgPath;
  final dynamic Function(bool)? changeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 10,
        ), //SizedBox
        Row(
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath!,
                color: Colors.black54,
                width: 20,
              ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17.0),
            ),
          ],
        ), //Text
        const Spacer(),
        /** Checkbox Widget **/
        Checkbox(
          value: isSelected,
          onChanged: (val) {
            if (changeSelected != null) changeSelected!(val ?? false);
          },
        ), //Checkbox
      ], //<Widget>[]
    );
  }
}

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
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Air Condition',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueAirCondition,
                  onChanged: (value) {
                    cubit.changeAirConditionValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Cable Tv ',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueCableTV,
                  onChanged: (value) {
                    cubit.changeCableTVValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Computer',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueComputer,
                  onChanged: (value) {
                    cubit.changeComputerValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'GasLine',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueGasline,
                  onChanged: (value) {
                    cubit.changeGaslineValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'DishShawer',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueDishwasher,
                  onChanged: (value) {
                    cubit.changeDishwasherValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Internet',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueInternet,
                  onChanged: (value) {
                    cubit.changeInternetValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Heater',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueHeater,
                  onChanged: (value) {
                    cubit.changeHeaterValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Microwave',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                Checkbox(
                  value: cubit.valueMicrowave,
                  onChanged: (value) {
                    cubit.changeMicrowaveValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
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
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/balcony.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Balcony',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valuebalcony,
                onChanged: (value) {
                  cubit.changeBalconyValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 6,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/lift.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Lift',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valueLift,
                onChanged: (value) {
                  cubit.changeLiftValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              //SizedBox
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/images/grill.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Grill',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valueGrill,
                onChanged: (value) {
                  cubit.changeGrillValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/pool.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pool',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valuePool,
                onChanged: (value) {
                  cubit.changePoolValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/parking.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Parking',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valueParking,
                onChanged: (value) {
                  cubit.changeParkingValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
        ],
      ),
    );
  }
}

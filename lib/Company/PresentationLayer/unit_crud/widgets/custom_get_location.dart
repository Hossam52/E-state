import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osol/Company/PresentationLayer/HomeScreen/mapGetLocation.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/shared/constants.dart';

class CustomGetLocation extends StatelessWidget {
  String title = "";

  CustomGetLocation(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        final lat = UnitCubit.get(context).latitude;
        final long = UnitCubit.get(context).longitude;
        log('lat $lat');
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: UnitCubit.get(context),
                      child: MyMap(),
                    ),
                  ),
                );
              },
              child: Container(
                height: sizeFromHeight(6.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                            style: Theme.of(context).textTheme.headline3!),
                      ],
                    ),
                    Container(
                      height: sizeFromHeight(10),
                      decoration: BoxDecoration(
                          color: ColorManager.onboardingColorDots,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              lat == null
                                  ? "PickUp Location"
                                  : 'Change selected location',
                              style: TextStyle(
                                  color: ColorManager.WhiteScreen,
                                  fontSize: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: SvgPicture.asset("assets/images/map.svg"),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            if (lat != null && long != null)
              InkWell(
                onTap: () {
                  UnitCubit.get(context).removeLatLngLocation();
                },
                child: Container(
                  height: sizeFromHeight(6.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: sizeFromHeight(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Remove selected location',
                                style: TextStyle(
                                    color: ColorManager.WhiteScreen,
                                    fontSize: 16),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

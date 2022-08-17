import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';

import 'constants.dart';

class CustomFloatingFilterButton extends StatelessWidget {
  const CustomFloatingFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = UnitClientCubit.get(context);
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                cubit.getAllDataList.clear();
                cubit.getAllUnitDetails(context);
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                      style: TextStyle(
                          color: ColorManager.WhiteScreen, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

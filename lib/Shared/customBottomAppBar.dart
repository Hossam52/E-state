import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';

import 'constants.dart';
import 'customFloatingFilteButton.dart';

class CustomBottomAppBar extends StatelessWidget {
  Color color;

  CustomBottomAppBar({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(9),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 10,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                height: sizeFromHeight(14),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(
                      10,
                    )),
                child: TextFormField(
                  cursorColor: Colors.grey[500],
                  cursorHeight: sizeFromHeight(17),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
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
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    enableDrag: true,
                    builder: (context) => CustomModelSheet(),
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: sizeFromHeight(14),
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
    );
  }
}

class CustomModelSheet extends StatelessWidget {
  const CustomModelSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitClientCubit, UnitClientState>(
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return Container(
          decoration: new BoxDecoration(
              color: ColorManager.WhiteScreen,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          height: sizeFromHeight(1.1),
          width: 42.w,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: new BoxDecoration(
                        color: ColorManager.WhiteScreen,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0))),
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
                              Text(
                                "Filter",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      cubit.changeTypeOfFilter(2);
                                      cubit.changePropType("");
                                    },
                                    child: Text(
                                      "Clear all",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
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
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.changeTypeOfFilter(2);
                                    },
                                    child: Container(
                                      height: sizeFromHeight(13),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cubit.indexOfTypeOfFilter == 2
                                            ? ColorManager.AppBarHomeColorIcon
                                            : ColorManager.WhiteScreen,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Any",
                                          style: TextStyle(
                                            color:
                                            cubit.indexOfTypeOfFilter == 2
                                                ? ColorManager.WhiteScreen
                                                : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.changeTypeOfFilter(0);
                                    },
                                    child: Container(
                                      height: sizeFromHeight(13),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cubit.indexOfTypeOfFilter == 0
                                            ? ColorManager.AppBarHomeColorIcon
                                            : ColorManager.WhiteScreen,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Sale",
                                          style: TextStyle(
                                            color:
                                                cubit.indexOfTypeOfFilter == 0
                                                    ? ColorManager.WhiteScreen
                                                    : Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      cubit.changeTypeOfFilter(1);
                                    },
                                    child: Container(
                                      height: sizeFromHeight(13),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cubit.indexOfTypeOfFilter == 1
                                            ? ColorManager.AppBarHomeColorIcon
                                            : ColorManager.WhiteScreen,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Rent",
                                          style: TextStyle(
                                            color:
                                                cubit.indexOfTypeOfFilter == 1
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
                        StackedCustomizeText(),
                        StackedCustomizeCardPrice(),
                        StackedFinishesAndPaints(),
                        cubit.indexOfTypeOfFilter == 0
                            ? PaymentType()
                            : SizedBox(),
                        StackedCustomrequiredField(),
                        StackedAdvertisor(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            floatingActionButton: CustomFloatingFilterButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }
}

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
                cubit.getAllUnitDetails();
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

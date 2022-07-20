import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osol/Company/businessLogicLayer/popularList/popular_cubit.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';

import 'constants.dart';

class ListLabelInDetails extends StatelessWidget {
  int num;

  ListLabelInDetails({required this.num});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                cubit.currentLabelindex = 0;
                cubit.changeLabel(cubit.currentLabelindex);
                PopularCubit.get(context).getTappedContainer("");
              },
              child: Container(
                decoration: BoxDecoration(
                    color: cubit.currentLabelindex == 0
                        ? ColorManager.OnBoardingScreen
                        : AppSettingCubit.get(context).isDark
                            ? ColorManager.DarkThemeBlackGround2
                            : Colors.grey[num],
                    borderRadius: BorderRadius.circular(8)),
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: cubit.currentLabelindex == 0
                          ? Icon(
                              cubit.listData[0].icon,
                              size: 14.sp,
                              color: Colors.white,
                            )
                          : Icon(
                              cubit.listData[0].icon,
                              size: 14.sp,
                              color: ColorManager.onboardingColorDots,
                            ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${cubit.listData[0].txt}",
                          style: TextStyle(
                            fontFamily: "arial",
                            color: cubit.currentLabelindex == 0
                                ? Colors.white
                                : AppSettingCubit.get(context).isDark
                                    ? Colors.white
                                    : ColorManager.GreyColortext,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: InkWell(
                onTap: () {
                  cubit.currentLabelindex = 1;
                  cubit.changeLabel(cubit.currentLabelindex);
                  PopularCubit.get(context).getTappedContainer("Sale");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: cubit.currentLabelindex == 1
                          ? ColorManager.OnBoardingScreen
                          : AppSettingCubit.get(context).isDark
                              ? ColorManager.DarkThemeBlackGround2
                              : Colors.grey[num],
                      borderRadius: BorderRadius.circular(8)),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: cubit.currentLabelindex == 1
                            ? Icon(
                                cubit.listData[1].icon,
                                size: 14.sp,
                                color: Colors.white,
                              )
                            : Icon(
                                cubit.listData[1].icon,
                                size: 14.sp,
                                color: ColorManager.onboardingColorDots,
                              ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${cubit.listData[1].txt}",
                            style: TextStyle(
                              fontFamily: "arial",
                              color: cubit.currentLabelindex == 1
                                  ? Colors.white
                                  : AppSettingCubit.get(context).isDark
                                      ? Colors.white
                                      : ColorManager.GreyColortext,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                onTap: () {
                  cubit.currentLabelindex = 2;
                  cubit.changeLabel(cubit.currentLabelindex);
                  PopularCubit.get(context).getTappedContainer("Rent");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: cubit.currentLabelindex == 2
                          ? ColorManager.OnBoardingScreen
                          : AppSettingCubit.get(context).isDark
                              ? ColorManager.DarkThemeBlackGround2
                              : Colors.grey[num],
                      borderRadius: BorderRadius.circular(8)),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: SvgPicture.asset(
                          "assets/images/calendar-2.svg",
                          height: 13.h,
                          color: cubit.currentLabelindex == 2
                              ? Colors.white
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            "${cubit.listData[2].txt}",
                            style: TextStyle(
                              color: cubit.currentLabelindex == 2
                                  ? ColorManager.WhiteScreen
                                  : AppSettingCubit.get(context).isDark
                                      ? Colors.white
                                      : ColorManager.GreyColortext,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                cubit.currentLabelindex = 3;
                cubit.changeLabel(cubit.currentLabelindex);
                PopularCubit.get(context).getTappedContainer("Compound");
              },
              child: Container(
                decoration: BoxDecoration(
                    color: cubit.currentLabelindex == 3
                        ? ColorManager.OnBoardingScreen
                        : AppSettingCubit.get(context).isDark
                            ? ColorManager.DarkThemeBlackGround2
                            : Colors.grey[num],
                    borderRadius: BorderRadius.circular(8)),
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Icon(
                        cubit.listData[3].icon,
                        size: 14,
                        color: cubit.currentLabelindex == 3
                            ? Colors.white
                            : Colors.lightBlueAccent,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        "${cubit.listData[3].txt}",
                        style: TextStyle(
                          color: cubit.currentLabelindex == 3
                              ? Colors.white
                              : AppSettingCubit.get(context).isDark
                                  ? Colors.white
                                  : ColorManager.GreyColortext,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () {
                  cubit.currentLabelindex = 4;
                  cubit.changeLabel(cubit.currentLabelindex);
                  PopularCubit.get(context).getTappedContainer("Estate");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: cubit.currentLabelindex == 4
                          ? ColorManager.OnBoardingScreen
                          : AppSettingCubit.get(context).isDark
                              ? ColorManager.DarkThemeBlackGround2
                              : Colors.grey[num],
                      borderRadius: BorderRadius.circular(8)),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(
                          cubit.listData[4].icon,
                          size: 13,
                          color: cubit.currentLabelindex == 4
                              ? ColorManager.WhiteScreen
                              : Colors.lightBlueAccent,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          "${cubit.listData[4].txt}",
                          style: TextStyle(
                            color: cubit.currentLabelindex == 4
                                ? Colors.white
                                : AppSettingCubit.get(context).isDark
                                    ? Colors.white
                                    : AppSettingCubit.get(context).isDark
                                        ? Colors.white
                                        : ColorManager.GreyColortext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

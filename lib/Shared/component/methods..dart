import 'package:flutter/material.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/shared/constants.dart';

bool isDark(BuildContext context) => AppSettingCubit.get(context).isDark;
Color getDarkmoodColor(BuildContext context) =>
    AppSettingCubit.get(context).isDark
        ? ColorManager.DarkThemeBlackGround2
        : Colors.white;
Color getInvertDarkmoodColor(BuildContext context) =>
    AppSettingCubit.get(context).isDark
        ? Colors.white
        : ColorManager.DarkThemeBlackGround2;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';

class DarkmoodSwitch extends StatelessWidget {
  const DarkmoodSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(AppSettingCubit.get(context).isDark.toString());
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      builder: (context, state) {
        return Switch(
          onChanged: (value) {
            AppSettingCubit.get(context).chandeDarkMode(value);
          },
          value: AppSettingCubit.get(context).isDark,
          activeColor: Colors.white,
        );
      },
    );
  }
}

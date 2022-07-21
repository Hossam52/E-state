import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController fText = TextEditingController();

  TextEditingController sText = TextEditingController();

  TextEditingController tText = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Change Password",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                CustomProfileTextForm(
                  cubit: cubit,
                  labelTxt: 'Last Password',
                  hintTxt: 'Enter Your Last Password',
                  controller: fText,
                  validator: (String? v) {
                    if (v!.length < 9) {
                      return "You Must Enter Correct Answer";
                    }
                    return null;
                  },
                ),
                CustomProfileTextForm(
                  cubit: cubit,
                  labelTxt: 'New Password',
                  hintTxt: 'Enter Your New Password',
                  controller: sText,
                  validator: (String? v) {
                    if (v!.length < 9) {
                      return "You Must Enter Correct Answer";
                    }
                    return null;
                  },
                ),
                CustomProfileTextForm(
                  cubit: cubit,
                  labelTxt: 'Confirm Password',
                  hintTxt: 'Enter Your Confirm Password',
                  controller: tText,
                  validator: (String? v) {
                    if (v!.length < 9) {
                      if (sText != v) {
                        return "this field must equal above field";
                      }
                      return "You Must Enter Correct Answer";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.changePassword(
                            oldPass: fText.text.toString(),
                            newPass: sText.text.toString(),
                            confPass: tText.text.toString());
                      }
                    },
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 16),
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

class CustomProfileTextForm extends StatefulWidget {
  ProfileCubit cubit;
  TextEditingController controller;
  String? Function(String?) validator;
  String labelTxt;
  String hintTxt;

  CustomProfileTextForm({
    required this.cubit,
    required this.controller,
    required this.validator,
    required this.hintTxt,
    required this.labelTxt,
  });

  @override
  State<CustomProfileTextForm> createState() => _CustomProfileTextFormState();
}

class _CustomProfileTextFormState extends State<CustomProfileTextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        obscureText: widget.cubit.visb,
        validator: (String? v) {},
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.cubit.visb
              ? IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    widget.cubit.changeVisi();
                  },
                )
              : IconButton(
                  icon: Icon(Icons.visibility_off),
                  onPressed: () {
                    widget.cubit.changeVisi();
                  },
                ),
          labelText: widget.labelTxt,
          labelStyle: Theme.of(context).textTheme.headline2,
          suffixIconColor: AppSettingCubit.get(context).isDark
              ? ColorManager.DarkThemeBlackGround2
              : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintTxt,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/customerServicesCubit/customer_services_cubit.dart';

class CustomerServicesView extends StatefulWidget {
  @override
  State<CustomerServicesView> createState() => _CustomerServicesViewState();
}

class _CustomerServicesViewState extends State<CustomerServicesView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController problemController = TextEditingController();

  GlobalKey<FormState> _customerServicesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerServicesCubit, CustomerServicesState>(
      listener: (context, state) {
        if (state is SuccesSendMessageToCustomerServises) {
          CustomToast(
            msg: "تم الارسال بنجاح",
            color: Colors.green,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = CustomerServicesCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: Text(
              "Customer Service",
            ),
          ),
          body: Form(
            key: _customerServicesKey,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: SvgPicture.asset("assets/images/customser.svg"),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppSettingCubit.get(context).isDark
                            ? ColorManager.DarkThemeBlackGround2
                            : ColorManager.CompareConatainer,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        children: [
                          Container(
                            height: 70.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    height: 70,
                                    child: CustomTxtField(
                                      controller: nameController,
                                      validator: (String? v) {
                                        if (v!.isEmpty) {
                                          return "You must fill this field";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(),
                                      keyBoardType: TextInputType.multiline,
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: Text("Name")),
                              ],
                            ),
                          ),
                          Container(
                            height: 70.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.phone,
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    height: 70,
                                    child: CustomTxtField(
                                      controller: phoneController,
                                      validator: (String? v) {
                                        if (v!.isEmpty) {
                                          return "You must fill this field";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(),
                                      keyBoardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: Text("Mobile")),
                              ],
                            ),
                          ),
                          Container(
                            height: 70.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Icon(
                                    FontAwesomeIcons.envelopeOpen,
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    height: 70,
                                    child: CustomTxtField(
                                      controller: emailController,
                                      validator: (String? v) {
                                        if (v!.isEmpty || !v.contains("@")) {
                                          return "You must fill this field";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(),
                                      keyBoardType: TextInputType.multiline,
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: Text("Email")),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.pending_actions,
                                ),
                                Text("Problem Description"),
                              ],
                            ),
                          ),
                          Container(
                            height: 100.h,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.WhiteScreen,
                                  ),
                                  height: 100,
                                  child: CustomTxtField(
                                    controller: problemController,
                                    validator: (String? v) {
                                      if (v!.isEmpty) {
                                        return "You must fill this field";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    keyBoardType: TextInputType.multiline,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: state is LoadingSendMessageToCustomerServices
                                ? Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (!_customerServicesKey.currentState!
                                          .validate()) {
                                        return;
                                      } else {
                                        await cubit
                                            .sendMessageToCustomerServices(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                problem: problemController.text,
                                                email: emailController.text);
                                        state is SuccesSendMessageToCustomerServises
                                            ? print("true State")
                                            : print("false state");
                                      }
                                    },
                                    child: Text(
                                      "Send",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),
                                      primary: ColorManager.onboardingColorDots,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomTxtField extends StatefulWidget {
  String? Function(String?)? validator;
  TextEditingController? controller;
  InputDecoration decoration;
  TextInputType keyBoardType;

  CustomTxtField({
    required this.controller,
    required this.validator,
    required this.decoration,
    required this.keyBoardType,
  });

  @override
  _CustomTxtFieldState createState() => _CustomTxtFieldState();
}

class _CustomTxtFieldState extends State<CustomTxtField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: widget.decoration,
      validator: widget.validator,
      controller: widget.controller,
      minLines: 1,
      maxLines: 5,
      keyboardType: widget.keyBoardType,
    );
  }
}

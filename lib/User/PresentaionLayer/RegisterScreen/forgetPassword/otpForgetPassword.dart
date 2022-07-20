import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OTPForgetPasswordScreen extends StatefulWidget {
  @override
  _OTPForgetPasswordScreenState createState() =>
      _OTPForgetPasswordScreenState();
}

class _OTPForgetPasswordScreenState extends State<OTPForgetPasswordScreen> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  final formKey = GlobalKey<FormState>();
  final myForm = GlobalKey<FormState>();

  TextEditingController PassController = TextEditingController();
  TextEditingController confPassController = TextEditingController();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          body: GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Email Verification For Restart Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 5,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 5) {
                              return "Enter the 5 number from your mail";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              inactiveColor: Colors.grey,
                              activeColor: Colors.blue,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.grey),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            cubit.changeValueOfOTPForgetPassword(v);
                          },
                          onChanged: (value) {
                            debugPrint(value);
                            // cubit.changeValueOfOTP(value);
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      cubit.hasErrror
                          ? "*Please fill up all the cells properly"
                          : "",
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Form(
                      key: myForm,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            CustomTxtEditing(
                              controller: PassController,
                              hint: "Password",
                              txtInputType: TextInputType.visiblePassword,
                              validate: (String? v) {
                                if (v!.length < 8) {
                                  return "Please Enter Valid Password";
                                }
                                return null;
                              },
                              obscure: false,
                              suffixIcon: null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTxtEditing(
                              controller: confPassController,
                              hint: "Password Confirmed",
                              txtInputType: TextInputType.visiblePassword,
                              validate: (String? v) {
                                if (v!.length < 8) {
                                  return "Please Enter Valid Password";
                                }
                                return null;
                              },
                              obscure: false,
                              suffixIcon: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          cubit.reSendOTP();
                          snackBar("OTP resend!!");
                        },
                        child: const Text(
                          "RESEND",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  state is LoadingsendOTP
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 30),
                          child: ButtonTheme(
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                // cubit.sendOTP(otpValue: );
                                formKey.currentState!.validate();
                                // conditions for validating
                                if (cubit.curentText.length != 5) {
                                  errorController!
                                      .add(ErrorAnimationType.shake);
                                  cubit.changeErrrorOTP(true);
                                } else {
                                  cubit.changeErrrorOTP(false);
                                  if (myForm.currentState!.validate()) {
                                    cubit.resetPass(
                                      otpValue: cubit.curentText,
                                      context: context,
                                      pass: PassController.text,
                                      passConfirm: confPassController.text,
                                    );
                                    snackBar("OTP Verified!!");
                                  }
                                }
                              },
                              child: Center(
                                  child: Text(
                                "VERIFY".toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue.shade200,
                                    offset: const Offset(1, -2),
                                    blurRadius: 5),
                                BoxShadow(
                                    color: Colors.blue.shade200,
                                    offset: const Offset(-1, 2),
                                    blurRadius: 5)
                              ]),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child: TextButton(
                        child: const Text("Clear"),
                        onPressed: () {
                          textEditingController.clear();
                        },
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';

class EmailForgetPassword extends StatefulWidget {
  @override
  State<EmailForgetPassword> createState() => _EmailForgetPasswordState();
}

class _EmailForgetPasswordState extends State<EmailForgetPassword> {
  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30.0,
                            ),
                            child: SvgPicture.asset(
                              "assets/images/forgetpw.svg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "Forget Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Provide your account email for which you want to reset Your password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTxtEditing(
                              validate: (String? v) {
                                if (v!.isEmpty || !v.contains("@")) {
                                  return "Enter Your Valid Email";
                                }
                                return null;
                              },
                              controller: emailController,
                              txtInputType: TextInputType.emailAddress,
                              hint: 'Email',
                              obscure: false,
                              suffixIcon: null,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(sizeFromWidth(1), 60),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.emailForgetPassword =
                                      emailController.text;
                                  cubit.forgetPassword(context: context);
                                }
                              },
                              child: state is LoadingForgetPass
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

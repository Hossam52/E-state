import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/forgetPassword/emailForgetPassword.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/viewTypes.dart';


class SignInView extends StatefulWidget {
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  onWillPob() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text("Exit"),
              content: const Text("Are you sure you want to leave the app?"),
              actions: [
                CupertinoDialogAction(
                    child: const Text("YES"),
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    }),
                CupertinoDialogAction(
                    child: const Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Builder(builder: (context) {
          return WillPopScope(
            onWillPop: () => onWillPob(),
            child: Scaffold(
              backgroundColor: ColorManager.onboardingColorDots,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ColorManager.onboardingColorDots,
                toolbarHeight: 80,
                shape: const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                centerTitle: true,
                leadingWidth: 0,
                leading: Icon(
                  Icons.arrow_forward,
                  color: ColorManager.onboardingColorDots,
                ),
                title: const Text(
                  "",
               
                ),
                actions: const [],
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                          child: const Image(
                        image: AssetImage("assets/images/estatehomee.png"),
                      )),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Form(
                        key: formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.WhiteScreen,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15.0,
                                  ),
                                  child: Text(
                                    "Welcome Back",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTxtEditing(
                                    controller: emailController,
                                    hint: "Email",
                                    txtInputType: TextInputType.emailAddress,
                                    validate: (String? v) {
                                      if (v!.isEmpty || !v.contains("@")) {
                                        return "Enter Correct Email";
                                      }
                                      return null;
                                    },
                                    obscure: false,
                                    suffixIcon: null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTxtEditing(
                                    controller: passController,
                                    hint: "Password",
                                    txtInputType: TextInputType.emailAddress,
                                    validate: (String? v) {
                                      if (v!.isEmpty || v.length < 8) {
                                        return "Enter Correct Password";
                                      }
                                      return null;
                                    },
                                    obscure: cubit.suffix,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.changeSuffixIcon();
                                      },
                                      icon: cubit.suffix == true
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EmailForgetPassword(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Forget Password ?",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: state is LoadingSignIn
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : ElevatedButton(
                                          onPressed: () {
                                            cubit.emailLog =
                                                emailController.text;

                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.logInAsUser(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passController.text);
                                            }
                                          },
                                          child: const Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size(double.infinity, 50),
                                            primary: ColorManager
                                                .onboardingColorDots,
                                          ),
                                        ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Text("OR"),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.blue,
                                        child: FaIcon(
                                          FontAwesomeIcons.twitter,
                                          color: ColorManager.WhiteScreen,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            ColorManager.WhiteScreen,
                                        child: SvgPicture.asset(
                                          "assets/images/google.svg",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: ColorManager.circleFB,
                                        child: FaIcon(
                                          FontAwesomeIcons.facebookF,
                                          color: ColorManager.WhiteScreen,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const TypesScreen()));
                                        },
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

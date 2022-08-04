import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/dataLayer/dataModel/verifyCompanyModel.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/countryModel/modelOfData.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/modelOfLogIn/modelOfLogin.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/modelOfOTPResponce/modelOfOTPResponce.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/forgetPassword/otpForgetPassword.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/otpScreen/view.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signIn/view.dart';

import '../../../main.dart';
import '../../DataLayer/localDataLayer/localData.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  String? token;
  String? accessType;

  AuthCubit({this.token, this.accessType}) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  /// change suffix icon
  bool suffix = true;
  changeSuffixIcon() {
    suffix = !suffix;
    emit(ChangeInSuffixIcon());
  }

  ///RegisterCubit
  String? email;
  String? name;
  String? password;
  String? countryId;
  String? phone;
  int? gender;
  String? cityId;

  Future<dynamic> registerAsUser({
    cityId,
    gender,
    phone,
    countryId,
    password,
    name,
    email,
    confirmPassword,
    context,
  }) async {
    try {
      emit(LoadingRegisterUserState());
      Response response = await DioHelper.postData(url: authRegisterURL, data: {
        "user_name": "$name",
        "email": "$email",
        "password": "$password",
        "password_confirmation": "$confirmPassword",
        "country_id": "$countryId",
        "city_id": "$cityId",
        "phone": "$phone",
        "gender": "$gender",
      });
      if (response.statusCode == 200 && response.data["status"] == false) {
        emit(ErrorDataRegisterUserState());
        Fluttertoast.showToast(
            msg: response.data["message"]["email"].first,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.statusCode == 200 &&
          response.data["status"] == true) {
        emit(SuccessRegisterUserState());
        Fluttertoast.showToast(
            msg: "تم التسجيل بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PinCodeVerificationScreen(),
          ),
        );
        return response;
      }

      // if (!(response.statusCode! >= 200 && response.statusCode! <= 300)) {
      //   print(response.statusCode);
      //   emit(SuccessRegisterUserState());
      //   Fluttertoast.showToast(
      //       msg: "تم التسجيل بنجاح",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   print(response.data);
      //   if (response.data['message'] != null) {
      //     throw Exception(response.data['message']);
      //   } else if (response.data['errors'] != null) {
      //     Map map = response.data['errors'];
      //     List list = map.entries.first.value;
      //     throw list.first;
      //   } else {
      //     throw Exception('Unknown error happened');
      //   }
      // }
    } catch (error) {
      Fluttertoast.showToast(
          msg: "${error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(ErrorRegisterUserState()
        ..ErrPrint(error.toString(), "Error Register"));
    }
  }

  ///Gender Value

  String? genderValue;

  changeGenderValue(value) {
    genderValue = value;
    emit(ChangeGenderValue());
  }

  ///OTP Screen
  bool hasError = false;

  changeErrorOTP(val) {
    hasError == val;
    emit(changeOTPErrorState());
  }

  var currentText;

  changeValueOfOTP(value) {
    currentText = value;
    emit(changeValueOfOTPState());
  }

  ///OTP Screen Forget Password
  bool hasErrror = false;

  changeErrrorOTP(val) {
    hasError == val;
    emit(changeOTPErorState());
  }

  var curentText;

  changeValueOfOTPForgetPassword(value) {
    curentText = value;
    emit(changeValueOfOTPForgetPasswordState());
  }

  ///TODO: Token for User
  String? userToken;
  List<ClientData>? dataOfClient;
  ResultCompanyVerifyModel? resultCompanyVerifyModel;

  Future sendOTP({otpValue, context}) async {
    emit(LoadingsendOTP());
    try {
      Response response = await DioHelper.postData(
        url: verifyOTP,
        data: {"token": otpValue},
      );
      if (response.statusCode == 200 && response.data["status"] == true) {
        debugPrint("OTP Responce:${response}");
        emit(SuccessSendOTP());
        Fluttertoast.showToast(
            msg: "تم تفعيل الحساب بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        resultCompanyVerifyModel =
            ResultCompanyVerifyModel.fromJson(response.data);
        ProfileCubit.get(context).getProfileData;
        userToken = resultCompanyVerifyModel?.token;
        accessType = resultCompanyVerifyModel?.type;
        Shared.prefClear();
        accessType != null
            ? await Shared.prefSetString(
                key: "accessType",
                value: accessType,
              )
            : print(accessType);
        userToken != null
            ? await Shared.prefSetString(
                key: "CompanyTokenVerify", value: userToken)
            : print(userToken);
        debugPrint("verify data ${userToken}");
        ProfileCubit.get(context).getProfileData();
        HomeCubit.get(context).getDataOfHome();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => NavigationDrawer(
              token: userToken.toString(),
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "${response.data["message"]["token"].first}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(ErrorInCodeOTP());
      }
    } catch (e) {
      debugPrint("Error OTP : ${e.toString()}");
    }
  }

  /// SignIn
  String? emailLogin;
  String? clientToken;

  Future logInAsUser({email, password, context}) async {
    debugPrint("${userToken}");
    emit(LoadingSignIn());
    Response response;
    LoginResultModel? loginResponse;
    try {
      response = await DioHelper.postData(
          url: authLoginURL, data: {"email": email, "password": password});
      if (response.data["status"] == false) {
        emit(ErrorInInputDataLogIn());
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (response.data["status"] == true && response.data["type"] == 0) {
        log(response.data.toString());
        debugPrint(response.data["message"]);
        emit(ErrorVerifyBeforeSignIn());
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => PinCodeVerificationScreen()));
        return response;
      } else if (response.data["status"] == true &&
          response.data["type"] == "company") {
        print(response.data);
        emit(SuccessSignIn());
        Shared.prefClear();
        loginResponse = LoginResultModel.fromJson(response.data);
        userToken = loginResponse.token;
        accessType = loginResponse.type;
        accessType != null
            ? await Shared.prefSetString(
                key: "accessType",
                value: accessType,
              )
            : print(accessType);
        userToken != null
            ? await Shared.prefSetString(
                key: "CompanyTokenVerify", value: userToken)
            : print("fff${userToken}");
        debugPrint(";;;;${userToken}");
        Fluttertoast.showToast(
            msg: "تم التسجيل بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => NavigationDrawerCompany(),
          ),
        );
        return response;
      } else if (response.data["status"] == true &&
          response.data["type"] == "client") {
        print(response.data);
        emit(SuccessSignIn());
        Shared.prefClear();
        loginResponse = LoginResultModel.fromJson(response.data);
        await ProfileCubit.get(context).getProfileData();
        userToken = loginResponse.token;
        accessType = loginResponse.type;
        accessType != null
            ? await Shared.prefSetString(
                key: "accessType",
                value: accessType,
              )
            : print(accessType);
        userToken != null
            ? await Shared.prefSetString(
                key: "CompanyTokenVerify", value: userToken)
            : print(userToken);
        debugPrint("hhhhhh]${userToken}");
        clientToken = userToken;
        await ProfileCubit.get(context).getProfileData();
        HomeCubit.get(context).getDataOfHome();
        Fluttertoast.showToast(
            msg: "تم التسجيل بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => NavigationDrawer(
              token: userToken.toString(),
            ),
          ),
        );
        return response;
      }
    } catch (e) {
      emit(ErrorSignInMain());
      print("${e.toString()}");
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 15,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  /// resend OTP
  String? emailRegister;
  String? emailLog;

  Future reSendOTP() async {
    emit(LoadingsendOTP());
    try {
      Response response = await DioHelper.postData(
        url: resendOTP,
        data: {
          "email": emailRegister == null
              ? emailLog == null
                  ? emailForgetPassword
                  : emailLog
              : emailRegister
        },
      );
      if (response.statusCode == 200 && response.data["status"] == true) {
        debugPrint("OTP Responce:${response}");
        emit(SuccessSendOTP());
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "${response.data["message"]["email"].first}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(ErrorInCodeOTP());
      }
    } catch (e) {
      debugPrint("Error OTP : ${e.toString()}");
    }
  }

  ///Log Out
  Future logOut({context}) async {
    final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingLogOut());
    debugPrint("${mainToken}");
    Response response;
    try {
      response = await DioHelper.postDataWithAuth(
        token: mainToken,
        url: logOutURL,
        data: {},
      );
      if (response.statusCode == 200 && response.data["status"] == true) {
        emit(SuccessLogOut());
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Shared.prefClear();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SignInView(),
          ),
        );
      } else if (response.statusCode == 200 &&
          response.data["status"] == false) {
        emit(ErrorInputDataLogOut());
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      emit(ErrorLogOut());
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  /// forget Passwword
  String? emailForgetPassword;

  forgetPassword({context}) async {
    emit(LoadingForgetPass());
    Response? response;
    try {
      response = await DioHelper.postData(
          url: forgetPasswordURL, data: {"email": emailForgetPassword});
      if (response.statusCode == 200 && response.data["status"] == true) {
        emit(SuccessForgetPass());
        Fluttertoast.showToast(
            msg: "success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OTPForgetPasswordScreen(),
          ),
        );
        debugPrint(response.data);
      } else if (response.statusCode == 200 &&
          response.data["status"] == false) {
        emit(ErrorInputForgetPass());
        debugPrint(response.data);
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      emit(ErrorForgetPass());
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  /// reset Password
  String? pass;
  String? passConfirm;

  Future resetPass({otpValue, context, pass, passConfirm}) async {
    emit(LoadingsendOTP());
    try {
      Response response = await DioHelper.postData(
        url: resetPasswordURL,
        data: {
          "token": otpValue,
          "password": pass,
          "password_confirmation": passConfirm
        },
      );
      print(pass);
      print(passConfirm);
      if (response.statusCode == 200 && response.data["status"] == true) {
        debugPrint("OTP Responce:${response}");
        emit(SuccessSendOTP());
        Fluttertoast.showToast(
            msg: "تم تفعيل الحساب بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        resultCompanyVerifyModel =
            ResultCompanyVerifyModel.fromJson(response.data);
        userToken = resultCompanyVerifyModel?.token;
        accessType = resultCompanyVerifyModel?.type;
        Shared.prefClear();
        accessType != null
            ? await Shared.prefSetString(
                key: "accessType",
                value: accessType,
              )
            : print(accessType);
        userToken != null
            ? await Shared.prefSetString(
                key: "CompanyTokenVerify", value: userToken)
            : print(userToken);
        debugPrint("verify data ${userToken}");
        ProfileCubit.get(context).getProfileData();
        HomeCubit.get(context).getDataOfHome();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => NavigationDrawer(
              token: userToken.toString(),
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "${response.data["message"]["token"].first}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(ErrorInCodeOTP());
      }
    } catch (e) {
      debugPrint("Error OTP : ${e.toString()}");
    }
  }
}

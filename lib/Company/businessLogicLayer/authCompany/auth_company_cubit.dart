import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/registerition/otpCompany/view.dart';
import 'package:osol/Company/dataLayer/dataModel/verifyCompanyModel.dart';
import 'package:osol/Shared/component/notify_helper.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signIn/view.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'auth_company_state.dart';

class AuthCompanyCubit extends Cubit<AuthCompanyState> {
  AuthCompanyCubit() : super(AuthCompanyInitial());

  static AuthCompanyCubit get(context) => BlocProvider.of(context);

  ///RegisterCubit
  File? imageData;

  changeImageData({imageFile}) {
    print("changeImageData $imageFile");

    imageData = imageFile;
    print("imageData $imageData");

    emit(ChangeImageState());
  }

  Future<dynamic> registerAsCompany({
    cityId,
    phone,
    countryCode,
    countryId,
    password,
    name,
    email,
    confirmPassword,
    context,
    type,
    address,
    about,
    branchNum,
    registerationNum,
  }) async {
    try {
      if (imageData == null) {
        NotifyHelper.showToast(
            "please choose company Image first!", Colors.red);

        return;
      }
      log("image path $imageData");
      emit(LoadingRegisterCompanyState());
      Response response =
          await DioHelper.postData(url: authRegisterCompanyURL, data: {
        "name": "$name",
        "image": await DioHelper.uploadFile(imageData!),
        "email": "$email",
        "password": "$password",
        "password_confirmation": "$confirmPassword",
        "country_id": "$countryId",
        "city_id": "$cityId",
        "phone": "$countryCode$phone",
        "type": "$type",
        "address": "$address",
        "about": "$about",
        "branches_num": "$branchNum",
        "regestration_num": "$registerationNum",
      });
      imageData = null;
      if (response.statusCode == 200 && response.data["status"] == false) {
        emit(ErrorDataRegisterCompanyState());
        NotifyHelper.showToast(
            response.data["message"].values.first.first, Colors.yellow);
      } else if (response.statusCode == 200 &&
          response.data["status"] == true) {
        emit(SuccessRegisterCompanyState());
        NotifyHelper.showToast("تم التسجيل بنجاح", Colors.green);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const PinCodeVerificationCompanyScreen(),
          ),
        );
        return response;
      }
    } catch (error, trace) {
      NotifyHelper.showToast(error.toString(), Colors.red);
      emit(ErrorRegisterCompanyState()
        ..ErrPrint(error.toString(), "Error Register"));
      log(error.toString());
      log(trace.toString());
    }
  }

  ///OTP Screen Company
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

  ///OTP Screen Forget Password Company
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

  /// resend OTP
  String? emailRegister;

  Future reSendOTP() async {
    emit(LoadingsendOTPCompany());
    try {
      Response response = await DioHelper.postData(
        url: resendOTPCompanyURL,
        data: {"email": emailRegister},
      );
      if (response.statusCode == 200 && response.data["status"] == true) {
        debugPrint("OTP Responce:$response");
        emit(SuccessSendOTP());
        log(response.data.toString());
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

  ///TODO: Token for Company
  String? userToken;
  String? accessType;
  ResultCompanyVerifyModel? resultCompanyVerifyModel;

  Future sendOTP({otpValue, context}) async {
    emit(LoadingsendOTPCompany());
    try {
      Response response = await DioHelper.postData(
        url: verifyCompanyAccountURL,
        data: {"token": otpValue},
      );
      if (response.statusCode == 200 && response.data["status"] == true) {
        debugPrint("OTP Responce:$response");
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
        debugPrint("verify data $userToken");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const NavigationDrawerCompany(),
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

  /// LogOut
  Future logOutCompany({context}) async {
    final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingLogOutCompany());
    debugPrint("mostafa:$mainToken");
    Response response;
    try {
      response = await DioHelper.postDataWithAuth(
        token: mainToken,
        url: logOutCompanyURL,
        data: {},
      );
      if (response.statusCode == 200 && response.data["status"] == true) {
        emit(SuccessLogOutCompany());
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Shared.prefClear();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SignInView(),
          ),
        );
      } else if (response.statusCode == 200 &&
          response.data["status"] == false) {
        emit(ErrorInputDataLogOutCompany());
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
      emit(ErrorLogOutCompany());
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

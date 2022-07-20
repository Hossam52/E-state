import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/profileModel/profileModel.dart';

import '../../../DataLayer/Model/modelOfData/profileModel/updatedProfileModel.dart';
import '../../../DataLayer/localDataLayer/localData.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  String? accessType;
  String? token;

  ProfileCubit({this.accessType, this.token}) : super(ProfileInitial());

  /// change password obs
  bool visb = true;

  changeVisi() {
    visb = !visb;
    emit(ChangeVisibility());
  }

  /// get profile data
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileModel? profileModel;
  List<ProfileModel> profileDate = [];

  Future<void> getProfileData() async {
    profileDate.clear();
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingGetProfileStatus());
    Response response;
    response = await DioHelper.getData(
      url: getProfileDataURL,
      token: coToken,
    );
    if (response.statusCode == 200) {
      profileModel = ProfileModel.fromJson(response.data);
      profileDate.add(profileModel!);
      debugPrint("profile:$profileModel");
      emit(SuccessGetProfileStatus());
    }
  }

  ///change password
  ChangePassModel? changePassModel;

  Future<void> changePassword({
    required String oldPass,
    required String newPass,
    required String confPass,
  }) async {
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingChangePassStatus());
    Response response;
    response = await DioHelper.postDataWithAuth(
      url: changeClientPass,
      token: coToken,
      data: {
        "oldPassword": oldPass,
        "password": newPass,
        "password_confirmation": confPass,
      },
    );
    if (response.statusCode == 200) {
      changePassModel = ChangePassModel.fromJson(response.data);
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: "${changePassModel?.message}",
        backgroundColor:
            response.data["status"] == true ? Colors.green : Colors.red,
      );
      emit(SuccessChangePassStatus());
    } else {
      emit(ErrorChangePassStatus());
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: "Error in change Password",
        backgroundColor: Colors.red,
      );
    }
  }

  ///RegisterCubit
  File? imageData;

  changeImageData({imageFile}) {
    imageData = imageFile;
    emit(ChangeImageState());
  }

  ///Update Profile
  UploadedDataModel? uploadedDataModel;
  List<UploadedDataModel> uploadedList = [];

  Future<void> updateProfile({
    required String name,
    required String countryId,
    required String cityId,
    required String gender,
    required String phone,
  }) async {
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingUploadStatus());
    Response response;
    response = await DioHelper.postDataWithAuth(
      url: updateClientProfile,
      token: coToken,
      data: {
        "user_name": name,
        "country_id": countryId,
        "city_id": cityId,
        "image": await DioHelper.uploadFile(imageData!),
        "gender": gender,
        "phone": phone,
      },
    );
    if (response.statusCode == 200) {
      uploadedDataModel = UploadedDataModel.fromJson(response.data);
      uploadedList.add(uploadedDataModel!);
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: "Data Uploaded Successfully",
        backgroundColor: Colors.green,
      );
      emit(SuccessUploadStatus());
    } else {
      emit(ErrorUploadStatus());
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: "Error in change Password",
        backgroundColor: Colors.red,
      );
    }
  }

  ///message data
  String? messageText;

  Future<void> changeMessageText(String? v) async {
    messageText = v;
    emit(ChangeMessageText());
  }
}

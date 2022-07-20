import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/dataLayer/dataModel/banners/getAllBannersModel.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/Shared/constants.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit() : super(BannersInitial());

  static BannersCubit get(context) => BlocProvider.of(context);

  ///Get All Bannners
  GetAllBannersCompanyModel? getAllBannersCompanyModel;
  List<Data> bannerData = [];

  Future getAllBanners() async {
    final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingGetAllBannersCompany());
    debugPrint("mostafa:${mainToken}");
    Response response;
    try {
      response = await DioHelper.postDataWithAuth(
        token: mainToken,
        url: getBannersURL,
        data: {},
      );
      if (response.statusCode == 200) {
        emit(SuccessGetAllBannersCompany());
        getAllBannersCompanyModel =
            GetAllBannersCompanyModel.fromJson(response.data);
        getAllBannersCompanyModel?.banners?.data?.forEach((items) {
          bannerData.add(items);
        });
        debugPrint("my bnner:${getAllBannersCompanyModel?.banners?.data}");
        print(bannerData[0].title);
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorGetAllBannersCompany());
    }
  }

  /// change OverLay
  bool overLaySheet = false;

  changeOverLaySheet(bool overLayState) {
    overLayState = overLayState;
    emit(changeOverLaySheetState());
  }

  ///Pick date

  String title = "";

  changeDate(val) async {
    title = val;
    emit(ChangeDateState());
  }

  ///Add Banner

  File? imageBannerData;

  changeImageBannerData({imageFile}) {
    imageBannerData = imageFile;
    emit(ChangeImageState());
  }

  Future<void> AddBanner({
    required String videoURL,
    required String description,
    required String endDate,
    required String title,
    required context,
  }) async {
    final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingAddBannerState());
    Response response;
    try {
      response = await DioHelper.postDataWithAuth(
          url: addNewBannerURL,
          data: {
            "title": title,
            "video_url": videoURL,
            "end_date": endDate,
            "description": description,
            "image": await DioHelper.uploadFile(imageBannerData!),
          },
          token: mainToken);
      if (response.statusCode == 200 && response.data["status"] == true) {
        print("${response.data}");
        CustomToast(color: Colors.green, msg: "تمت الأضافه بنجاح");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => NavigationDrawerCompany()));
        emit(SuccessAddBannerState());
      } else if (response.statusCode == 200 &&
          response.data["status"] == false) {
        CustomToast(
            color: Colors.green,
            msg: "${response.data["message"].value.first.first}");
        emit(ErrorAddDataOfBannerState());
      }
    } catch (e) {
      CustomToast(msg: e.toString(), color: Colors.red);
      emit(ErrorPushBannerState());
    }
  }
}

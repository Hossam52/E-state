import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/Company/dataLayer/dataModel/companyProfile/companyProfileModel.dart';
import 'package:osol/Company/dataLayer/dataModel/companyProfile/getProfileDataModel.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/Shared/constants.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'profile_company_state.dart';

class ProfileCompanyCubit extends Cubit<ProfileCompanyState> {
  ProfileCompanyCubit() : super(ProfileCompanyInitial());

  static ProfileCompanyCubit get(context) => BlocProvider.of(context);

  ///Get Profile Company
  GetProfileDataModel? _companyGetProfileData;
  List<Company> companyGetProfileData = [];
  int? id;
  String? name;
  String? email;
  String? country;
  String? city;
  String? motherCompany;
  String? image;
  String? address;
  String? about;
  int? branchesNum;
  String? type;
  String? regestrationNum;
  String? phone;

  List<GetProfileDataModel> companyAllProfileData = [];

  getProfileCompany() async {
    emit(LoadingGetProfileDataStatus());
    companyAllProfileData.clear();
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    response = await DioHelper.getData(
      url: getProfileCompanyURL,
      token: coToken,
    );
    if (response.statusCode == 200) {
      _companyGetProfileData = GetProfileDataModel.fromJson(response.data);
      companyAllProfileData.add(_companyGetProfileData!);
      id = _companyGetProfileData?.rC?.id;
      name = _companyGetProfileData?.rC?.name;
      email = _companyGetProfileData?.rC?.email;
      country = _companyGetProfileData?.rC?.country;
      city = _companyGetProfileData?.rC?.city;
      motherCompany = _companyGetProfileData?.rC?.motherCompany;
      image = _companyGetProfileData?.rC?.image;
      address = _companyGetProfileData?.rC?.address;
      about = _companyGetProfileData?.rC?.about;
      branchesNum = _companyGetProfileData?.rC?.branchesNum;
      type = _companyGetProfileData?.rC?.type;
      regestrationNum = _companyGetProfileData?.rC?.regestrationNum;
      phone = _companyGetProfileData?.rC?.phone;
      print("mostafa profile${email}");
      emit(SuccessGetProfileDataStatus());
    }
  }

  ///Update Profile Company

  File? imageData;

  changeImageData({imageFile}) {
    imageData = imageFile;
    emit(ChangeImageUpdateState());
  }

  Company? _companyProfileData;
  List<Company> companyProfileData = [];

  UpddateProfileCompany({
    required String name,
    required String countryId,
    required String cityId,
    required String type,
    required String phone,
    required String about,
    required String address,
    required String registerNum,
    required String branchNum,
  }) async {
    emit(LoadingpdateCompanyProfile());

    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    response = await DioHelper.postDataWithAuth(
        url: updateProfileCompanyURL,
        data: {
          "name": name,
          "country_id": countryId,
          "city_id": cityId,
          "image": await DioHelper.uploadFile(imageData!),
          "type": type,
          "phone": phone,
          "about": about,
          "address": address,
          "regestration_num": registerNum,
          "branches_num": branchNum,
        },
        token: coToken);
    if (response.statusCode == 200 && response.data["status"] == true) {
      _companyProfileData = Company.fromJson(response.data);
      companyProfileData.add(_companyProfileData!);
      print("comapny ProfileData:$companyProfileData");
      emit(SuccessUpdateCompanyProfile());
    } else {
      emit(ErrorUpdateData());
    }
  }
}

import 'dart:io';

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
  GetProfileDataModel? _profileResponse;
  CompanyProfile? get companyProfile => _profileResponse?.companyProfile;

  getProfileCompany() async {
    try {
      emit(LoadingGetProfileDataStatus());
      final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      Response response;
      response = await DioHelper.getData(
        url: getProfileCompanyURL,
        token: coToken,
      );
      _profileResponse = GetProfileDataModel.fromJson(response.data);
      if (_profileResponse?.status ?? false) {
        emit(SuccessGetProfileDataStatus());
      } else {
        throw 'Error happened when get profile';
      }
    } catch (e) {
      _profileResponse = null;
      emit(ErrorGetProfileDataStatus());
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
          if (companyProfile!.phone! != phone) "phone": phone,
          if (companyProfile!.about! != about) "about": about,
          "address": address,
          if (companyProfile!.regestrationNum! != registerNum)
            "regestration_num": registerNum,
          if (companyProfile!.branchesNum!.toString() != branchNum)
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

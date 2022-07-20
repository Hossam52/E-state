import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/companyModel/CompanyModel.dart';

import '../../DataLayer/Model/modelOfData/companyModel/cmpanyDetectedModel.dart';
import '../../DataLayer/Model/modelOfData/companyModel/companyDetectedReview.dart';
import '../../DataLayer/localDataLayer/localData.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());

  static CompanyCubit get(context) => BlocProvider.of(context);
  int indexTogleIcons = 0;

  changeTogleIconsState(index) {
    indexTogleIcons = index;
    emit(ChangeIconsCompanyState());
  }

  /// get company id
  String? currentCompanyId;

  changeCurrentCompanyId(String newID) {
    currentCompanyId = newID;
    emit(ChangeNewId());
  }

  String nextCompanyId = "next";

  changeNextCompanyId(String newID) {
    nextCompanyId = newID;
    emit(ChangeNextId());
  }

  /// get unit by id
  CompanyDetectedData? companyNewModel;
  List<CompanyDetectedData> companyDetectedData = [];
  List imgDetectedUnit = [];

  getCompanyById() async {
    companyDetectedData.clear();
    debugPrint("sss$currentCompanyId");
    debugPrint("sss$nextCompanyId");
    emit(LoadingGetDetectedCompany());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getAllCompanyUnitID,
        data: {
          "company_id":
              nextCompanyId == "next" ? currentCompanyId : nextCompanyId
        },
        token: coToken);
    if (response.statusCode == 200) {
      companyNewModel = CompanyDetectedData.fromJson(response.data["company"]);
      companyDetectedData.add(companyNewModel!);
      imgDetectedUnit.add(companyNewModel?.image);
      debugPrint("${companyNewModel?.email}");
      nextCompanyId = "next";
      emit(SuccessGetDetectedCompany());
    } else {
      emit(ErrorGetDetectedCompany());
      debugPrint("Error on get detected Company data");
    }
  }

  /// get company details
  CompanyModel? companyModel;
  List<CompanyData> companyData = [];

  Future<void> getAllComanyData() async {
    companyData.clear();
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingGetDataAllCompany());
    Response response;
    response = await DioHelper.postDataWithAuth(
        url: getAllCompanyDataURL, data: {}, token: coToken);
    if (response.statusCode == 200) {
      companyModel = CompanyModel.fromJson(response.data);
      companyModel?.company?.data?.forEach((element) {
        companyData.add(element);
      });
      emit(SuccessGetDataAllCompany());
    }
  }

  /// add review about company
  CompanyReview? companyReview;
  List<DataOfReview> dataOfCompanyReview = [];
  int? totalReview;
  dynamic? currentReview = "";
  int id = 1;

  zeroId() {
    id = 1;
    emit(ChangeZeroIdOfPage());
  }

  changeId() {
    id++;
    emit(ChangeIdOfPage());
  }

  getReviewsForDetectedCompany() async {
    emit(LoadingGetAllReviews());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getCompanyReviewResponse,
        query: {"page": id},
        data: {
          "company_id": nextCompanyId=="next"?currentCompanyId:nextCompanyId,
        },
        token: coToken);
    if (response.statusCode == 200) {
      debugPrint("Successful get projects of Company");
      companyReview = CompanyReview.fromJson(response.data["reviews"]);
      companyReview?.data?.forEach((element) {
        dataOfCompanyReview.add(element);
      });
      totalReview = companyReview?.meta?.total;
      currentReview = companyReview?.links?.next;
      emit(SuccessfulGetAllReviews());
      getCompanyById();
    } else {
      debugPrint("Error on get projects of Company");
      emit(ErrorGetAllReviews());
    }
  }

  /// add review about company
  storeReviewAboutCompany(String body, double strNum) async {
    emit(LoadingAddedReview());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: createReviewClientURL,
        data: {
          "body": body,
          "company_id":nextCompanyId=="next"? currentCompanyId:nextCompanyId,
          "strNum": strNum,
        },
        token: coToken);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Review added successfully!",
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
      );
      emit(SuccessfulAddedReview());
      getCompanyById();
    } else {
      Fluttertoast.showToast(
        msg: "Error on added!",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
      );
      emit(ErrorAddedReview());
    }
  }
}

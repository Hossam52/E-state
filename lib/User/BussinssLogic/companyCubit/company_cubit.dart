import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/ProjectsofCompany.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/companyModel/CompanyModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/companyModel/user_company_projects.dart';
import 'package:osol/common_models/all_units_model.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../DataLayer/Model/modelOfData/companyModel/cmpanyDetectedModel.dart';
import '../../DataLayer/Model/modelOfData/companyModel/companyDetectedReview.dart';
import '../../DataLayer/localDataLayer/localData.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit({this.companyId}) : super(CompanyInitial());
  String? companyId; //If provided means that this cubit is for show user
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
  CompanyDetectedData? company;
  bool get isLoadedCompany => company != null;

  // List<CompanyDetectedData> companyDetectedData = [];
  // List imgDetectedUnit = [];

  Future getCompanyById() async {
    // companyDetectedData.clear();
    debugPrint("sss$currentCompanyId");
    debugPrint("sss$nextCompanyId");
    emit(LoadingGetDetectedCompany());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getAllCompanyUnitID,
        data: {
          "company_id": companyId,
          // nextCompanyId == "next" ? currentCompanyId : nextCompanyId
        },
        token: coToken);
    if (response.statusCode == 200) {
      company = CompanyDetectedData.fromJson(response.data["company"]);
      // companyDetectedData.add(company!);
      // imgDetectedUnit.add(company?.image);
      debugPrint("${company?.email}");
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

  Future<void> getAllComanyData(BuildContext context) async {
    final searchText = FilterCubit.instance(context).searchText;
    // if (searchText.isEmpty && companyModel != null) return;
    companyData.clear();
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    emit(LoadingGetDataAllCompany());
    Response response;
    response = await DioHelper.postDataWithAuth(
        url: getAllCompanyDataURL, data: {'name': searchText}, token: coToken);
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

  bool isReviewsLoading = false;
  getReviewsForDetectedCompany() async {
    isReviewsLoading = true;
    emit(LoadingGetAllReviews());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getCompanyReviewResponse,
        query: {"page": id},
        data: {
          "company_id": companyId
          // nextCompanyId == "next" ? currentCompanyId : nextCompanyId,
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
    } else {
      debugPrint("Error on get projects of Company");
      emit(ErrorGetAllReviews());
    }
    isReviewsLoading = false;
  }

  //Company projects
  UserCompanyProjects? _companyProjects;
  List<DataOfProjects> get projects => _companyProjects?.projects.data ?? [];
  bool isProjectsLoading = false;
  Future<void> getCompanyProjects() async {
    isProjectsLoading = true;
    emit(CompanyProjectsLoadingState());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getDetectedCompanyProjects,
        data: {
          "company_id": companyId
          // nextCompanyId == "next" ? currentCompanyId : nextCompanyId,
        },
        token: coToken);
    if (response.statusCode == 200) {
      _companyProjects = UserCompanyProjects.fromMap(response.data);

      emit(CompanyProjectsSuccessState());
    } else {
      emit(CompanyProjectsErrorState(error: ''));
    }
    isProjectsLoading = false;
  }

  /// add review about company
  storeReviewAboutCompany(String body, double strNum) async {
    emit(LoadingAddedReview());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: createReviewClientURL,
        data: {
          "body": body,
          "company_id": companyId,
          // nextCompanyId == "next" ? currentCompanyId : nextCompanyId,
          "strNum": strNum,
        },
        token: coToken);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Review added successfully!",
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
      );
      final review = DataOfReview.fromJson(response.data['review']);
      dataOfCompanyReview.insert(0, review);
      emit(SuccessfulAddedReview());
    } else {
      Fluttertoast.showToast(
        msg: "Error on added!",
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
      );
      emit(ErrorAddedReview());
    }
  }

  //Company Units
  AllUnitsModel? _allUnits;
  bool get isLoadedUnits => _allUnits != null;
  List<UnitModel> get units => _allUnits?.data ?? [];
  bool isUnitsLoading = false;
  Future<void> getCompanyListing() async {
    isUnitsLoading = true;
    emit(CompanyListingLoadingState());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getCompanyUnits,
        data: {
          "company_id": companyId
          // nextCompanyId == "next" ? currentCompanyId : nextCompanyId,
        },
        token: coToken);
    log(response.data.toString());
    if (response.statusCode == 200) {
      if (response.data['units'] != null) {
        _allUnits = AllUnitsModel.fromJson(response.data['units']);
      }

      emit(CompanyListingSuccessState());
    } else {
      emit(CompanyListingErrorState(error: ''));
    }
    isUnitsLoading = false;
  }

  Future<void> loadCompany() async {
    await getCompanyById();
    getReviewsForDetectedCompany();
    getCompanyProjects();
    getCompanyListing();
  }
}

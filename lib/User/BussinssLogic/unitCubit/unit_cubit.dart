import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/savedCubit/saved_cubit.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../../Shared/constants.dart';
import '../../DataLayer/Model/modelOfData/unitClientModel/getAllReviewData.dart';
import '../../DataLayer/Model/modelOfData/unitClientModel/getAllUnitsDetailsModel.dart';
import '../../DataLayer/Model/modelOfData/unitClientModel/getUnitByIdModel.dart';
import '../../DataLayer/Model/modelOfData/unitClientModel/unitRevewModel.dart';
import '../../DataLayer/localDataLayer/localData.dart';

part 'unit_state.dart';

class UnitClientCubit extends Cubit<UnitClientState> {
  UnitClientCubit() : super(UnitInitial());

  static UnitClientCubit get(context) => BlocProvider.of(context);

  UnitModel? getUnitByIdModel;
  UnitModel? unitById;
  List imagesData = [];
  String? image;
  var unitId;

  Future getUnitId(newUnitId) async {
    unitId = newUnitId;
    debugPrint("$unitId");
    emit(GetUnitIdState());
  }

  List unitDetectedId = [];
  List<UnitModel> firstUnit = [];
  List<UnitModel> secondUnit = [];
  UnitModel? getUnitByIdFirstModel;
  UnitModel? getUnitByIdSecondModel;

  getUnitById(int unitId) async {
    try {
      unitById = null;
      emit(LoadingGetUnitById());
      final clienToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      log(clienToken.toString());

      Response response = await DioHelper.postData(
        url: getAllUnitByIdURL,
        data: {"unit_id": unitId},
        token: clienToken,
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        getUnitByIdModel = UnitModel.fromJson(response.data["units"]);
        unitById = (getUnitByIdModel!);
        getUnitByIdModel?.images?.forEach((element) {
          imagesData.add(element);
          print("dd${element}");
        });
        print("print body ${unitAllReviewList}");
        emit(SuccessGetUnitById());
      } else {
        debugPrint("Error Get Unit By Id1");
        emit(ErrorGetUnitById());
      }
    } catch (e) {
      emit(ErrorGetUnitById());
    }
  }

  Future getUnitByIdFirstUnit() async {
    firstUnit.clear();
    debugPrint("sasss${unitDetectedId[0]}");
    emit(LoadingGetFirstUnitById());
    final String clienToken =
        await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postData(
      url: getAllUnitByIdURL,
      data: {"unit_id": unitDetectedId[0]},
      token: clienToken,
    );
    if (response.statusCode == 200) {
      getUnitByIdFirstModel = UnitModel.fromJson(response.data["units"]);
      firstUnit.add(getUnitByIdFirstModel!);
      print("print body ${firstUnit}");
      emit(SuccessGetFirstUnitById());
    } else {
      debugPrint("Error Get Unit By Id2");
      emit(ErrorGetFirstUnitById());
    }
  }

  Future getCompareDataUnit() async {
    getUnitByIdFirstUnit();
    getUnitByIdSecondUnit();
  }

  getUnitByIdSecondUnit() async {
    secondUnit.clear();
    emit(LoadingGetSecondUnitById());
    debugPrint("sasss${unitDetectedId[1]}");

    final String clienToken =
        await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postData(
      url: getAllUnitByIdURL,
      data: {"unit_id": unitDetectedId[1]},
      token: clienToken,
    );
    if (response.statusCode == 200) {
      getUnitByIdSecondModel = UnitModel.fromJson(response.data["units"]);

      secondUnit.add(getUnitByIdSecondModel!);
      print("print body ${secondUnit}");
      emit(SuccessGetSecondUnitById());
    } else {
      debugPrint("Error Get Unit By Id3");
      emit(ErrorGetSecondUnitById());
    }
  }

  /// add Review
  Review? unitReviewModel;
  List<Review> unitReviewList = [];
  AllReviews? unitAllReviewModel;
  List<DataAllReview> unitAllReviewList = [];
  int? metaUnitReviewLastPage;
  int? totalUnitReview;
  dynamic nextPage = "";
  int id = 1;

  zeroId() {
    id = 1;
    emit(ChangeZeroIdOfPage());
  }

  changeId() {
    id++;
    emit(ChangeIdOfPage());
  }

  Future getAllUnitReview() async {
    try {
      debugPrint("my id  page$id}");
      emit(LoadingGetAllReviewState());
      final String clienToken =
          await Shared.prefGetString(key: "CompanyTokenVerify");
      Response response = await DioHelper.postDataWithAuth(
        url: getAllReviewByUnitIdURL,
        query: {"page": id},
        data: {
          "unit_id": await unitId,
        },
        token: clienToken,
      );
      if (response.statusCode == 200) {
        unitAllReviewModel = AllReviews.fromJson(response.data["reviews"]);
        unitAllReviewModel?.data?.forEach((element) {
          unitAllReviewList.add(element);
        });
        metaUnitReviewLastPage = unitAllReviewModel?.meta?.lastPage;
        nextPage = unitAllReviewModel?.links?.next;
        totalUnitReview = unitAllReviewModel?.meta?.total;
        debugPrint("all unit review${unitAllReviewList}");
        emit(SuccessGetAllReviewState());
      } else {
        debugPrint("Error On Add Review");
        emit(ErrorGetAllReviewState());
      }
    } catch (e) {
      emit(ErrorGetAllReviewState());
    }
  }

  Future addUnitReview(
      {required String reviewBody, required double starNum}) async {
    emit(LoadingAddReviewState());
    debugPrint("ddd$unitId");
    final String clienToken =
        await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
      url: createReviewClientURL,
      data: {
        "unit_id": await unitId,
        "body": reviewBody,
        "strNum": starNum == null ? "0" : starNum,
      },
      token: clienToken,
    );
    if (response.statusCode == 200) {
      debugPrint("sasas${response.data}");
      unitReviewModel = Review.fromJson(response.data);
      unitReviewList.add(unitReviewModel!);
      debugPrint("unit review${unitReviewList}");
      emit(SuccessAddReviewState());
    } else {
      debugPrint("Error On Add Review2");
      emit(ErrorAddReviewState());
    }
  }

  ///Filter Screen
  int filterIndex = 0;
  int filterNewIndex = 0;

  changeIndexInFilter(index) {
    filterNewIndex = index;
    emit(ChangeIndexInFilter());
  }

  String filterNewIndexFinishType = "Any";

  changeIndexInFilterFinishType(String index) {
    filterNewIndexFinishType = index;
    emit(ChangeIndexInFilterFinishType());
  }

  String requiredField = "Any";

  changeIndexInFilterrequiredField(String index) {
    requiredField = index;
    emit(ChangeIndexInFilterRequiredField());
  }

  int advistor = 0;

  changeIndexInAdvistor(index) {
    advistor = index;
    emit(ChangeIndexInAdvistor());
  }

  String typeFilter = "Any";

  changePropType(index) {
    typeFilter = index;
    emit(ChangePropTypeState());
  }

  double start = 0;
  double end = 100000000;

  changeRangeSlider(value) {
    start = value.start;
    end = value.end;
    emit(ChangeValueOfSlider());
    print("${start},$end");
  }

  int indexOfTypeOfFilter = 2;

  changeTypeOfFilter(index) {
    indexOfTypeOfFilter = index;
    print(indexOfTypeOfFilter);
    emit(ChangeTypeOfFilter());
  }

  ///get all unit details
  String? cToken;
  GetAllUnitsDetailsModel? getAllUnitsDetailsModel;
  List<UnitModel> getAllDataList = [];

  getAllData() {
    getUnitByIdFirstUnit();
    getUnitByIdSecondUnit();
  }

  Future getAllUnitDetails(BuildContext context) async {
    try {
      final filterResultsMap =
          FilterCubit.instance(context).getFilterResults.toMap();
      final searchText = FilterCubit.instance(context).searchText;
      filterResultsMap.addAll({'text': searchText});
      getAllDataList.clear();
      emit(LoadingGetAllUnitClientDetails());
      cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      Response response = await DioHelper.postDataWithAuth(
          url: getAllUnitsdetails, data: filterResultsMap, token: cToken);
      if (response.statusCode == 200) {
        debugPrint("get All unit Details data${response.data}");
        getAllUnitsDetailsModel =
            GetAllUnitsDetailsModel.fromJson(response.data);
        getAllUnitsDetailsModel?.units?.data?.forEach((element) {
          if (comparedUnits.indexWhere(
                  (comparedUnit) => element.id == comparedUnit.id) ==
              -1) {
            getAllDataList.add(element);
          }
        });
        emit(SuccessGetAllUnitClientDetails());
      } else {
        debugPrint("Error On Add Review 3--");
        emit(ErrorGetUnitClientDetails());
      }
    } catch (e) {
      emit(ErrorGetUnitClientDetails());
    }
  }

  Future getAllFilterUnitDetails() async {
    getAllDataList.clear();
    emit(LoadingGetAllUnitClientDetails());
    cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response = await DioHelper.postDataWithAuth(
        url: getAllUnitsdetails,
        data: {
          "purpose": indexOfTypeOfFilter == 0 ? "Sale" : "Rent",
          "type": "${typeFilter == "" ? null : typeFilter}",
        },
        token: cToken);
    if (response.statusCode == 200) {
      debugPrint("get All unit Details data${response.data}");
      getAllUnitsDetailsModel = GetAllUnitsDetailsModel.fromJson(response.data);
      getAllUnitsDetailsModel?.units?.data?.forEach((element) {
        getAllDataList.add(element);
      });
      emit(SuccessGetAllUnitClientDetails());
    } else {
      debugPrint("Error On Add Review 3");
      emit(ErrorGetUnitClientDetails());
    }
  }

  ///compare Screen
  List<UnitModel> comparedUnits = [];
  void addUnitToCompare(UnitModel unit) {
    if (comparedUnits.length == 2) return;
    if (getAllDataList.indexWhere((element) => unit.id == element.id) == -1) {
      return;
    }
    getAllDataList.removeWhere((element) => element.id == unit.id);
    comparedUnits.add(unit);
    emit(changeInCompareList());
  }

  void toggleCompareItem(UnitModel unit) {
    log(isUnitAddedToCompare(unit).toString());
    if (isUnitAddedToCompare(unit)) {
      removeUnitFromCompare(unit);
    } else {
      addUnitToCompare(unit);
    }
  }

  bool isUnitAddedToCompare(UnitModel unit) {
    return comparedUnits.isEmpty
        ? false
        : comparedUnits.indexWhere((element) => unit.id == element.id) != -1;
  }

  // addCompareToList(Widget widget, {id}) {
  //   compareList.add(widget);
  //   compareUnitId.add(id);
  //   newIndex++;
  //   emit(changeInCompareList());
  // }
  void removeUnitFromCompare(UnitModel unit) {
    comparedUnits.removeWhere((element) => element.id == unit.id);
    getAllDataList.add(unit);
    emit(RemoveIndexFromCompareList());
  }
  // removeIndexFromCompareList(index, indexnum) {
  //   compareList.removeAt(index);
  //   unitDetectedId.removeAt(index);
  //   compareUnitId.removeAt(index);
  //   newIndex = indexnum;
  //   emit(RemoveIndexFromCompareList());
  // }

  void toggleFavorite(BuildContext context, UnitModel unit) {
    SavedCubit.get(context).setSave(unitId: unit.id);
    // getFeatureOfClientHome();
    unit.toggleFavorite();
    emit(ToggleFavorite());
  }

  /// map Screen
  ScrollController scrollController = new ScrollController();
  double _width = sizeFromWidth(1.5);

  void scrollToIndex(index) {
    scrollController.animateTo(_width * index,
        duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
  }
}

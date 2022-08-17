import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/PopularListModel/PopularListModel.dart';
import 'package:osol/Company/dataLayer/dataModel/pobular/company_unit_category_filter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/common_models/filter_displayed_units_model.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit({this.context}) : super(PopularInitial()) {
    FilterCubit.instance(context!).resetSearchText();
  }
  final BuildContext? context;
  static PopularCubit get(context) => BlocProvider.of(context);
  late List<CompanyUnitCategory> allCateogires = [
    CompanyCustomCategoryFilter(
        onCategoryTapped: ({bool forceTap = false}) async {
      log('Custom tapped');
      changeUnitCategoryIndex(0, forceTap);
    }),
    CompanyAllUnitsCategory(onCategoryTapped: ({bool forceTap = false}) async {
      log('All tapped');
      changeUnitCategoryIndex(1, forceTap);
    }),
    CompanySaleUnitsCategory(onCategoryTapped: ({bool forceTap = false}) async {
      log('sale tapped');
      changeUnitCategoryIndex(2, forceTap);
    }),
    CompanyRentUnitCategory(onCategoryTapped: ({bool forceTap = false}) async {
      log('rent tapped');
      changeUnitCategoryIndex(3, forceTap);
    }),
    CompanyCompoundUnitCategory(
        onCategoryTapped: ({bool forceTap = false}) async {
      log('compund tapped');
      changeUnitCategoryIndex(4, forceTap);
    }),
    CompanyEstateUnitCategory(
        onCategoryTapped: ({bool forceTap = false}) async {
      log('estate tapped');
      changeUnitCategoryIndex(5, forceTap);
    }),
  ];
  CompanyUnitCategory get selectedCategory =>
      allCateogires[selectedUnitCategoryIndex];

  UnitCategory get selectedUnitCategory =>
      allCateogires[selectedUnitCategoryIndex] as UnitCategory;
  bool get isCategoryLoadedData => selectedCategory.units != null;
  List<UnitModel> get displayedUnits => selectedCategory.units ?? [];
  int selectedUnitCategoryIndex = 1;
  void changeUnitCategoryIndex(int index, bool isForceTapped) {
    selectedUnitCategory.toggleIsSelected();
    selectedUnitCategoryIndex = index;
    selectedUnitCategory.toggleIsSelected();

    emit(changeIndexOfTapped());
    fetchData(isForceTapped: isForceTapped);
  }

  void fetchData({bool isForceTapped = false}) {
    if (selectedUnitCategoryIndex == 0) {
      getCustomPopularList();
    } else {
      getDetectedPopularList(isForceTapped: isForceTapped);
    }
  }

  void showResFromFilter() {
    (allCateogires.first as UnitCategory).onTapped();
  }

  int currentIndex = 0;

  int index = 0;

  int indexBottomSheet = 0;

  changeIndexBottomSheet(int index) {
    indexBottomSheet = index;
    emit(ChangeIndexBottomSheet());
  }

  int? tappedIndex;

  getTappedIndex(int index) {
    selectedCategory.changeStatusIndex(index);
    // tappedIndex = index;
    // debugPrint("${tappedIndex}");
    // getDetectedPopularList();
    emit(changeIndexOfTapped());
    fetchData();
  }

  String? tappedContainer;

  getTappedContainer(String tab) {
    // tappedContainer = tab;
    // debugPrint("${tab}");
    // getDetectedPopularList();
    // emit(changeIndexOfTapped());
  }

  ///Get Popular Data
  PopularListModel? popularListModel;
  List<UnitModel> detectedUnitList = [];

  Future getDetectedPopularList({bool isForceTapped = false}) async {
    log(isForceTapped.toString());

    if (!isForceTapped && selectedCategory.units != null) return;
    final filterCubit = FilterCubit.instance(context!);
    Map<String, dynamic> data = {
      "add_type": "Popular",
      "status": selectedCategory.selecteddStatus.status,
      "title": filterCubit.searchText
    };
    if (selectedCategory is SaleUnitsCategory ||
        selectedCategory is RentUnitCategory) {
      data.addAll({
        "purpose": selectedUnitCategory.type,
      });
    } else if (selectedCategory is! AllUnitsCategory) {
      data.addAll({
        "type": selectedUnitCategory.type,
      });
    }
    try {
      detectedUnitList.clear();
      Response response;
      emit(LoadingGetPopularListData());
      final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      response = await DioHelper.postDataWithAuth(
          url: getFeatureAndPopularUnitURL,
          data: data,
          // selectedCategory is SaleUnitsCategory ||
          //         selectedCategory is RentUnitCategory
          //     ? {
          //         "add_type": "Popular",
          //         "purpose": selectedUnitCategory.type,
          //         "status": selectedCategory.selecteddStatus.status,
          //       }
          //     : selectedCategory is AllUnitsCategory
          //         ? {
          //             "add_type": "Popular",
          //             "type": "",
          //             "status": selectedCategory.selecteddStatus.status,
          //           }
          //         : {
          //             "add_type": "Popular",
          //             "type": selectedUnitCategory.type,
          //             "status": selectedCategory.selecteddStatus.status,
          //           },
          token: mainToken);
      if (response.statusCode == 200) {
        popularListModel = PopularListModel.fromJson(response.data);
        detectedUnitList.clear();
        popularListModel?.units?.data.forEach((element) {
          detectedUnitList.add(element);
        });
        selectedCategory.units = List.from(detectedUnitList);
        emit(SuccessGetPopularListData());
      }
    } catch (e) {
      emit(ErrorGetListOfData());
    }
  }

  Future getCustomPopularList() async {
    final filterCubit = FilterCubit.instance(context!);

    final filterResultsMap = filterCubit.getFilterResults.toMap();
    filterResultsMap.addAll({
      //TODO: Add addType parameter
      // "add_type": "Popular",
      "title": filterCubit.searchText,
      "status": selectedCategory.selecteddStatus.status,
    });
    try {
      detectedUnitList.clear();
      Response response;
      emit(LoadingGetPopularListData());
      final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      response = await DioHelper.postDataWithAuth(
          url: getFeatureAndPopularUnitURL,
          data: filterResultsMap,
          token: mainToken);
      if (response.statusCode == 200) {
        popularListModel = PopularListModel.fromJson(response.data);
        detectedUnitList.clear();
        if (popularListModel != null && popularListModel!.units != null) {
          for (var element in popularListModel!.units!.data) {
            detectedUnitList.add(element);
          }
        }
        selectedCategory.units = List.from(detectedUnitList);
        emit(SuccessGetPopularListData());
      }
    } catch (e) {
      emit(ErrorGetListOfData());
    }
  }
}

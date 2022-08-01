import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/PopularListModel/PopularListModel.dart';
import 'package:osol/Company/dataLayer/dataModel/pobular/company_unit_category_filter.dart';
import 'package:osol/Company/dataLayer/dataModel/pobular/popularModel.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/common_models/unit_model.dart';
import 'package:osol/shared/Customicon.dart';
import 'package:osol/common_models/filter_displayed_units_model.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit({this.context}) : super(PopularInitial());
  final BuildContext? context;
  static PopularCubit get(context) => BlocProvider.of(context);
  late List<CompanyUnitCategory> allCateogires = [
    CompanyCustomCategoryFilter(onCategoryTapped: () async {
      log('Custom tapped');
      changeUnitCategoryIndex(0);
    }),
    CompanyAllUnitsCategory(onCategoryTapped: () async {
      log('All tapped');
      changeUnitCategoryIndex(1);
    }),
    CompanySaleUnitsCategory(onCategoryTapped: () async {
      log('sale tapped');
      changeUnitCategoryIndex(2);
    }),
    CompanyRentUnitCategory(onCategoryTapped: () async {
      log('rent tapped');
      changeUnitCategoryIndex(3);
    }),
    CompanyCompoundUnitCategory(onCategoryTapped: () async {
      log('compund tapped');
      changeUnitCategoryIndex(4);
    }),
    CompanyEstateUnitCategory(onCategoryTapped: () async {
      log('estate tapped');
      changeUnitCategoryIndex(5);
    }),
  ];
  CompanyUnitCategory get selectedCategory =>
      allCateogires[selectedUnitCategoryIndex];

  UnitCategory get selectedUnitCategory =>
      allCateogires[selectedUnitCategoryIndex] as UnitCategory;
  bool get isCategoryLoadedData => selectedCategory.units != null;
  List<UnitModel> get displayedUnits => selectedCategory.units ?? [];
  int selectedUnitCategoryIndex = 1;
  void changeUnitCategoryIndex(int index) {
    selectedUnitCategory.toggleIsSelected();
    selectedUnitCategoryIndex = index;
    selectedUnitCategory.toggleIsSelected();

    emit(changeIndexOfTapped());
    if (index == 0) {
      getCustomPopularList();
    } else {
      getDetectedPopularList();
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
    getDetectedPopularList();
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

  Future getDetectedPopularList() async {
    if (selectedCategory.units != null) return;
    try {
      detectedUnitList.clear();
      Response response;
      emit(LoadingGetPopularListData());
      final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      response = await DioHelper.postDataWithAuth(
          url: getFeatureAndPopularUnitURL,
          data: selectedCategory is SaleUnitsCategory ||
                  selectedCategory is RentUnitCategory
              ? {
                  "add_type": "Popular",
                  "purpose": selectedUnitCategory.type,
                  "status": selectedCategory.selecteddStatus.status,
                }
              : selectedCategory is AllUnitsCategory
                  ? {
                      "add_type": "Popular",
                      "type": "",
                      "status": selectedCategory.selecteddStatus.status,
                    }
                  : {
                      "add_type": "Popular",
                      "type": selectedUnitCategory.type,
                      "status": selectedCategory.selecteddStatus.status,
                    },
          token: mainToken);
      if (response.statusCode == 200) {
        popularListModel = PopularListModel.fromJson(response.data);
        detectedUnitList.clear();
        popularListModel?.units?.data?.forEach((element) {
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
    final filterResultsMap =
        FilterCubit.instance(context!).getFilterResults.toMap();
    filterResultsMap.addAll({
      "add_type": "Popular",
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
        popularListModel?.units?.data?.forEach((element) {
          detectedUnitList.add(element);
        });
        selectedCategory.units = List.from(detectedUnitList);
        emit(SuccessGetPopularListData());
      }
    } catch (e) {
      emit(ErrorGetListOfData());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:osol/Company/dataLayer/dataModel/PopularListModel/PopularListModel.dart';
import 'package:osol/Company/dataLayer/dataModel/pobular/popularModel.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(PopularInitial());

  static PopularCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  int index = 0;

  int indexBottomSheet = 0;

  changeIndexBottomSheet(int index) {
    indexBottomSheet = index;
    emit(ChangeIndexBottomSheet());
  }

  int? tappedIndex;

  getTappedIndex(int index) {
    tappedIndex = index;
    debugPrint("${tappedIndex}");
    getDetectedPopularList();
    emit(changeIndexOfTapped());
  }

  String? tappedContainer;

  getTappedContainer(String tab) {
    tappedContainer = tab;
    debugPrint("${tab}");
    getDetectedPopularList();
    emit(changeIndexOfTapped());
  }

  ///Get Popular Data
  PopularListModel? popularListModel;
  List<DataDetected> detectedUnitList = [];

  Future getDetectedPopularList() async {
    detectedUnitList.clear();
    Response response;
    emit(LoadingGetPopularListData());
    final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    response = await DioHelper.postDataWithAuth(
        url: getAllUnitsdetails,
        data: tappedContainer == "Sale" || tappedContainer == "Rent"
            ? {
                "add_type":"Popular",
                "purpose": tappedContainer,
              }
            : {
                "add_type": "Popular",
                "type": "",
              },
        token: mainToken);
    if (response.statusCode == 200) {
      popularListModel = PopularListModel.fromJson(response.data);
      detectedUnitList.clear();
      popularListModel?.units?.data?.forEach((element) {
        detectedUnitList.add(element);
        print("${element}");
      });
      debugPrint("dettttt:${popularListModel?.units?.data}**********");
      emit(SuccessGetPopularListData());
      debugPrint("popular length${detectedUnitList.length}");
    }
  }
}

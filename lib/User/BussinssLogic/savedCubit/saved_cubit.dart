import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/savedModel/SavedModel.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../DataLayer/localDataLayer/localData.dart';

part 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit(this.context) : super(SavedInitial());
  final BuildContext context;
  static SavedCubit get(context) => BlocProvider.of(context);
  final token = Shared.prefGetString(key: "CompanyTokenVerify");

  /// set saved data
  bool status = false;

  Future<void> setSave({unitId}) async {
    emit(LoadingSavedData());
    Response response;
    response = await DioHelper.postDataWithAuth(
        url: setSavedData, data: {"unit_id": unitId}, token: token);
    if (response.statusCode == 200) {
      status = response.data["status"];
      emit(SuccessSavedData());
    }
  }

  ///saved screen
  int toggleSaved = 0;

  changeTogleSavedState(index) {
    toggleSaved = index;
    emit(ChangeIconsSavedState());
  }

  SavedModel? savedGetModel;
  List<UnitModel> dataUnit = [];

  getMySavedData() async {
    try {
      //  final filterResultsMap =
      //     FilterCubit.instance(context).getFilterResults.toMap();
      // final searchText = FilterCubit.instance(context).searchText;
      // filterResultsMap.addAll({'text': searchText});
      dataUnit.clear();
      emit(LoadingGetSavedData());
      Response response;
      response = await DioHelper.getData(
        url: getMyFavoriteDataURL,
        token: token,
      );
      if (response.statusCode == 200) {
        savedGetModel = SavedModel.fromJson(response.data);
        if (savedGetModel != null && savedGetModel!.units != null) {
          for (var element in savedGetModel!.units!.data) {
            dataUnit.add(element);
            debugPrint("Saved unit $dataUnit");
            emit(SuccessGetSavedData());
          }
        }
      } else {
        print("error");
      }
      print("data unit:$dataUnit");
    } catch (e) {
      emit(ErrorGetSavedData());
      // TODO
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
    print("$start,$end");
  }

  int indexOfTypeOfFilter = 2;

  changeTypeOfFilter(index) {
    indexOfTypeOfFilter = index;
    print(indexOfTypeOfFilter);
    emit(ChangeTypeOfFilter());
  }
}

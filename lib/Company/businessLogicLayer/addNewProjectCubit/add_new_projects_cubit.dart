import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/addNewProjectModel.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'add_new_projects_state.dart';

class AddNewProjectsCubit extends Cubit<AddNewProjectsState> {
  AddNewProjectsCubit() : super(AddNewProjectsInitial());

  static AddNewProjectsCubit get(context) => BlocProvider.of(context);

  ///Add Image

  File? imageBannerData;

  changeImageData({imageFile}) {
    imageBannerData = imageFile;
    emit(ChangeImageState());
  }

  ///add new Project

  String title = "";

  changeDate(val) async {
    title = val;
    emit(ChangeDateState());
  }

  AddNewProjectModel? addNewProjectModel;
  List<Project> addedProjects = [];

  addNewProject({
    title,
    deliveryDate,
    descrip,
    numOfUnit,
  }) async {
    addedProjects.clear();
    emit(LoadingAddNewProject());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    response = await DioHelper.postDataWithAuth(
        url: addNewProjectURl,
        data: {
          "title": title,
          "long": "1225452.2511",
          "lat": "1225452.2511",
          "delivery_date": deliveryDate,
          "description": descrip,
          "image": await DioHelper.uploadFile(imageBannerData!),
          //TODO: static data
          "num_of_units": "5",
          "country_id":"3",
          "city_id":"5",

        },
        token: coToken);
    if (response.statusCode == 200 && response.data["status"] == true) {
      addNewProjectModel = AddNewProjectModel.fromJson(response.data);
      debugPrint("${addNewProjectModel?.project?.title}");
      emit(SuccessAddNewProject());
    } else {
      debugPrint("Error");
      emit(ErrorAddNewProject());
    }
  }
}

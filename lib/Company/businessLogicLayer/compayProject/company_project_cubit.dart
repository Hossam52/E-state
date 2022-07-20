import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/ProjectsofCompany.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'company_project_state.dart';

class CompanyProjectCubit extends Cubit<CompanyProjectState> {
  CompanyProjectCubit() : super(CompanyProjectInitial());

  static CompanyProjectCubit get(context) => BlocProvider.of(context);
  AllProjectsModel? _allProjectsModel;
  Response? response;
  List<DataOfProjects> dataOfProjects = [];

  getAllCompanyProjects() async {
    dataOfProjects.clear();
    emit(LoadingGetAllProjects());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    response = await DioHelper.postDataWithAuth(
        url: getMyProjectURL, data: {}, token: coToken);
    if (response?.statusCode == 200) {
      _allProjectsModel = AllProjectsModel.fromJson(response?.data);
      _allProjectsModel?.project?.data?.forEach((element) {
        dataOfProjects.add(element);
        debugPrint("data Of Projects: ${element.id}");
      });
      emit(SuccessGetAllProjects());
    } else {
      debugPrint("error");
      CustomToast(msg: "يجب ان تكون البيانات صحيحه", color: Colors.yellow);
      emit(ErrorGettheProjectsOfCompany());
    }
  }

  ///Add Image

  File? imageUploadedData;

  changeImageData({imageFile}) {
    imageUploadedData = imageFile;
    emit(ChangeImageState());
  }

  ///add new Project

  String title = "";

  changeDate(val) async {
    title = val;
    emit(ChangeDateState());
  }

  int? id;

  changeId({newId}) {
    id = newId;
    debugPrint("$newId");
    emit(ChangeIdState());
  }

  UpdateProjectsOfCampany({title, deliveryDate, descrip, numOfUnit, id}) async {
    emit(LoadingUpdateProjectstate());
    print("$id");
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    response = await DioHelper.postDataWithAuth(
        url: companyProjectUpdatedURL,
        data: {
          "title": title,
          "long": "1225452.25112",
          "lat": "1225452.25112",
          "delivery_date": deliveryDate,
          "description": descrip,
          "image": await DioHelper.uploadFile(imageUploadedData!),
          "num_of_units": numOfUnit,
          "project_id": id,
        },
        token: coToken);
    if (response.statusCode == 200 && response.data["status"] == true) {
      emit(SuccessUpdateProjectDataState());
    } else {
      debugPrint("Error");
      CustomToast(msg: "ادخل البيانات بشكل صحيح", color: Colors.yellow);
      emit(ErrorUpdateDate());
    }
  }

  ///DeleteProject

  deleteProject({projectId}) async {
    emit(LoadingDeleteProject());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    response = await DioHelper.postData(
        url: deleteProjectURl,
        data: {
        "project_id": projectId,
        },
        token: coToken);
    if (response.statusCode == 200 && response.data["status"] == true) {
      CustomToast(color: Colors.red, msg: "${response.data["message"]}");
      emit(SuccessDeleteProject());
    } else {
      print("Error");
      emit(ErrorDeleteProject());
    }
  }
}

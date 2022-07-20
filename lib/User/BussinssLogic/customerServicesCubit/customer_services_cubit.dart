import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/Shared/constants.dart';

import '../../DataLayer/localDataLayer/localData.dart';

part 'customer_services_state.dart';

class CustomerServicesCubit extends Cubit<CustomerServicesState> {
  CustomerServicesCubit() : super(CustomerServicesInitial());

  static CustomerServicesCubit get(context) => BlocProvider.of(context);
  final token = Shared.prefGetString(key: "CompanyTokenVerify");

  bool sent = false;

  sendMessageToCustomerServices({
    required String name,
    required String phone,
    required String problem,
    required String email,
  }) async {
    emit(LoadingSendMessageToCustomerServices());
    Response response;
    try {
      response = await DioHelper.postDataWithAuth(
          url: sendMessageToServicesURL,
          data: {
            "name": name,
            "email": email,
            "phone": phone,
            "problem": problem,
          },
          token: token);
      if (response.statusCode == 200 && response.data["status"] == true) {
        sent = response.data["status"];
        emit(SuccesSendMessageToCustomerServises());
      } else {
        print("Error");
        CustomToast(
            msg: "${response.data["message"]["email"].first}", color: Colors.yellow);
        emit(ErrorInputTypedataCustmerServices());
      }
    } catch (e) {
      debugPrint("error");
      emit(ErrorSendMessageToCustomerServises());
    }
  }
}

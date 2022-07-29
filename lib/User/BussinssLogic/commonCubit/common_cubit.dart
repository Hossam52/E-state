import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/countryModel/modelOfData.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  String? token;
  String? accessType;

  CommonCubit({this.token, this.accessType}) : super(CommonInitial());

  static CommonCubit get(context) => BlocProvider.of(context);

  ///Drop down
  List<Cities>? city;
  String? Value;

  ///Get CountryData
  CountryModel? countryModel;
  List<Countries> countryData = [];
  int? selectedCountry;
  List<Cities> cityData = [];
  int? cityIndex;
  Countries? dropDownCountryValue;
  int? areaIndex;
  List<Areas> areasData = [];

  changeCountryValue(value) {
    dropDownCountryValue = value;
    emit(ChangeDropDownCountry());
  }

  void changeSelectedLocationById(
      {required String countryId,
      required String cityId,
      required String areaId}) {
    if (countryData
        .where((e) => e.id.toString() == countryId)
        .toList()
        .isNotEmpty) {
      dropDownCountryValue = countryData
          .firstWhere((element) => element.id.toString() == countryId);

      selectedCountry = dropDownCountryValue!.id;
      city = dropDownCountryValue!.cities;
      getCityData(dropDownCountryValue!.id);
      valueCountryId = dropDownCountryValue!.id;
    }
    areasData.clear();
    if (cityData.where((e) => e.id.toString() == cityId).toList().isNotEmpty) {
      final selectedCity =
          cityData.firstWhere((element) => element.id.toString() == cityId);
      changeSelectedCites(selectedCity);
      cityIndex = selectedCity.id;
      selectedCity.areas?.forEach((element) {
        changeSelectedAreas(element);
        changeSelectedAreasId(element.id);
        getAreaData(element.id).then((value) => print("${areasData}"));
        print("id:${newAreasIdValue}");
      });
    }
    if (areasData.where((e) => e.id.toString() == areaId).toList().isNotEmpty) {
      final selectedArea =
          areasData.firstWhere((element) => element.id.toString() == areaId);
      changeSelectedAreas(selectedArea);
      areaIndex = selectedArea.id;
    }
  }

  int? valueCountryId;

  getCityData(i) {
    emit(GetCityData());
    cityData.clear();
    countryData[i - 3].cities?.forEach((element) {
      cityData.add(element);
      print(element);
    });
  }

  Cities? newValue;

  changeSelectedCites(value) {
    newValue = value;
    emit(ChangeCity());
  }

  Areas? newAreasValue;

  changeSelectedAreas(value) {
    newAreasValue = value;
    emit(ChangeAreas());
  }

  int? newAreasIdValue;

  changeSelectedAreasId(value) {
    newAreasIdValue = value;
    emit(ChangeAreasId());
  }

  Future getAreaData(i) async {
    areasData.clear();
    newAreasIdValue != null
        ? cityData[newAreasIdValue!].areas?.forEach((element) {
            areasData.add(element);
            print("areas element${element.name}");
          })
        : print("value equla null");
    print(areasData.length);
    emit(GetAreasData());
  }

  String? genderValue;

  changeGenderValue(value) {
    genderValue = value;
    emit(ChangeGenderValue());
  }

  Future<void> getCountry() async {
    emit(LoadingGetCountry());
    try {
      Response response = await DioHelper.getData(url: getCountryURL);
      if (response.statusCode == 200) {
        print("Country Data:${response.data}");
        emit(SuccessGetCountry());
        countryModel = CountryModel.fromJson(response.data);
        countryModel?.countries?.forEach((element) {
          countryData.add(element);
          print(element.name);
        });
      }
      ;

      if (state is SuccessGetCountry) {
        print("mostata:$countryData");
      }
    } catch (err) {
      emit(
        ErrorGetCountry()..ErrPrint(err.toString(), "Error Get Country:"),
      );
    }
  }

  ///OTP Screen
  bool hasError = false;

  changeErrorOTP(val) {
    hasError == val;
    emit(changeOTPErrorState());
  }

  var currentText;

  changeValueOfOTP(value) {
    currentText = value;
    emit(changeValueOfOTPState());
  }

  ///OTP Screen Forget Password
  bool hasErrror = false;

  changeErrrorOTP(val) {
    hasError == val;
    emit(changeOTPErorState());
  }

  var curentText;

  changeValueOfOTPForgetPassword(value) {
    curentText = value;
    emit(changeValueOfOTPForgetPasswordState());
  }
}

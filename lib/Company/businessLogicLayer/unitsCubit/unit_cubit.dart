import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_location_picker/open_location_picker.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/addUnit/addUnitModel.dart';
import 'package:osol/Company/dataLayer/dataModel/features/featuresModel.dart';
import 'package:osol/Company/dataLayer/dataModel/pobular/popularModel.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../../User/DataLayer/localDataLayer/localData.dart';

part 'unit_state.dart';

enum SearchInEnum {
  feature,
  popular,
}

class UnitCubit extends Cubit<UnitState> {
  UnitCubit(this.context) : super(UnitInitial());
  final BuildContext context;
  static UnitCubit get(context) => BlocProvider.of(context);

  ///ListIn addUnit
  List<String> description = ["aprtment", "vial"];
  List<String> requiredFields = [
    "Residential",
    "Vacation",
    "Commercial",
    "Medical"
  ];

  List<String> Views = ["front", "back"];
  List<String> adsType = ["Feature", "Popular"];
  List<String> purpose = ['Sale', 'Rent'];
  List<String> paymentMethod = ["Cash", "Installment"];
  List<String> finishType = [
    "without",
    "Half",
    "Full",
    "lux",
    "Super Lux",
    "Ultra Luxe",
    "Deluxe",
    "Super Deluxe"
  ];
  List<String> styleType = [
    "Apartment",
    "Duplex",
    "Office",
    "Store",
    "Studio",
    "Town House",
    "Twin House",
    "Penthouse",
    "Villa"
  ];
  List<String> availableDate = ["Available", "Not Available"];
  String? ViewsValue;
  String? adsTypeValue;
  String? dropDownStyleTypeValue;
  String? finishTypeValue;
  String? purposeValue;
  String? requiredFieldsValue;
  String? descriptionValue;
  String? availabe;
  String? paymentMethodValue;

  void initAdsType(String? val) {
    adsTypeValue = val;
  }

  void initDropDownValues(CommonCubit commonCubit, UnitModel unit) {
    ViewsValue = unit.view;
    adsTypeValue = unit.addType;
    dropDownStyleTypeValue = unit.type;
    finishTypeValue = unit.finishedType;
    purposeValue = unit.purpose;
    requiredFieldsValue = unit.requiredFields;
    descriptionValue = unit.description;
    availabe = unit.available ?? false ? availableDate[0] : availableDate[1];
    paymentMethodValue = unit.paymentMethod;

    numRoom = unit.rooms ?? 0;
    numBathRoom = unit.bathroom ?? 0;
    numFloor = unit.floor ?? 0;
    numBedRoom = unit.bedrooms ?? 0;

    trainDistance = unit.train?.toString();
    metroDistance = unit.metro?.toString();
    BusDistance = unit.bus?.toString();
    pharmacyDistance = unit.pharmacy?.toString();
    coffeDistance = unit.coffe?.toString();
    restDistance = unit.resturant?.toString();
    BakaryDistance = unit.bakary?.toString();
    beachDistance = unit.beach?.toString();

    valueAirCondition = unit.gasLine?.contains('on') ?? false;
    valueCableTV = unit.cableTv?.contains('on') ?? false;
    valueComputer = unit.computer?.contains('on') ?? false;
    valueGasline = unit.gasLine?.contains('on') ?? false;
    valueDishwasher = unit.dishwasher?.contains('on') ?? false;
    valueInternet = unit.internet?.contains('on') ?? false;
    valueHeater = unit.heater?.contains('on') ?? false;
    valueMicrowave = unit.microwave?.contains('on') ?? false;
    valuebalcony = unit.balcony?.contains('on') ?? false;
    valueLift = unit.lift?.contains('on') ?? false;
    valueGrill = unit.grill?.contains('on') ?? false;
    valuePool = unit.pool?.contains('on') ?? false;
    valueParking = unit.parking?.contains('on') ?? false;
    valueSecurity = unit.security?.contains('on') ?? false;

    latitude = double.tryParse(unit.lat ?? '0') ?? 0;
    longitude = double.tryParse(unit.long ?? '0') ?? 0;

    commonCubit.changeSelectedLocationById(
      countryId: unit.countryId!,
      cityId: unit.cityId!,
      areaId: unit.areaId!,
    );
  }

  changeAvailableValue(value) {
    availabe = value;
    emit(ChangeAvailableState());
  }

  changeDescriptionValue(value) {
    descriptionValue = value;
    emit(ChangeDropDownDescripUnitState());
  }

  changeRequiredFieldsValue(value) {
    requiredFieldsValue = value;
    emit(ChangeDropDownRequiredFieldUnitState());
  }

  changePaymentMethodValue(value) {
    paymentMethodValue = value;
    emit(ChangeDropDownPaymentMethodUnitState());
  }

  changePurposeValue(value) {
    purposeValue = value;
    emit(ChangeDropDownPurposeUnitState());
  }

  changeFinishTypeValue(value) {
    finishTypeValue = value;
    emit(ChangeDropDownFinishTypeUnitState());
  }

  changeDropDownStyleTypeValue(value) {
    dropDownStyleTypeValue = value;
    emit(ChangeDropDownStyleTypeUnitState());
  }

  changeViewsValue(value) {
    ViewsValue = value;
    emit(ChangeDropDownViewUnitState());
  }

  changeadsTypeValue(value) {
    adsTypeValue = value;
    emit(ChangeDropDownAdsTypeUnitState());
  }

  ///Add unit
  List<XFile>? imageData = [];

  changeImageData({imageFile}) {
    imageData = imageFile;
    emit(ChangeImageUnitState());
  }

  List<File> imagesFile = [];

  changeListData() {
    imagesFile.clear();
    for (XFile image in imageData!) {
      imagesFile.add(
        File(image.path),
      );
    }
    emit(ChangeImageFileUnitState());
  }

  AddUnitModel? addUnitModel;
  Unit? unitData;
  Future addUnit({
    required String title,
    required String downPayment,
    required String monthlyPayment,
    required String deposite,
    required String numYears,
    required String area,
    required String yearBuild,
    required String price,
    required String video,
    required BuildContext context,
  }) async {
    List<MultipartFile> myImage = [];
    for (var i = 0; i < imagesFile.length; i++) {
      log('For loop');
      myImage.add(
        await DioHelper.uploadFile(imagesFile[i]),
      );
    }
    UnitModel unit;
    log(myImage.length.toString());

    emit(LoadingAddUnitState());
    Response response;

    debugPrint("print:${myImage.length.toString()}");
    final companyToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    try {
      await changeListData();
      final cityId = CommonCubit.get(context).cityIndex.toString();
      final countryId = CommonCubit.get(context).valueCountryId.toString();
      final areaId = CommonCubit.get(context).areaIndex.toString();
      debugPrint("print beforeRes:${myImage.length.toString()}");
      response = await DioHelper.postDataWithAuth(
          token: companyToken,
          url: setUnitURL,
          data: {
            "title": title,
            "type": dropDownStyleTypeValue,
            "required_fields": requiredFields,
            "view": ViewsValue,
            "description": description,
            "purpose": purpose,
            "down_payment": downPayment,
            "monthly_payment": monthlyPayment,
            "deposite": deposite,
            "num_years": numYears,
            "price": price,
            "payment_method": paymentMethodValue,
            "country_id": countryId,
            "city_id": cityId,
            "area_id": areaId,
            "available": availabe == "available" ? 1 : 0,
            "available_date": null,
            "lat": latitude,
            "long": longitude,
            "video": video,
            "rooms": numRoom,
            "bathroom": numBathRoom,
            "floor": numFloor,
            "year_build": yearBuild,
            "area": area,
            "bedrooms": numBedRoom,
            "finished_type": finishTypeValue,
            "metro": metroDistance,
            "train": trainDistance,
            "bus": BusDistance,
            "pharmacy": pharmacyDistance,
            "beach": beachDistance,
            "bakary": BakaryDistance,
            "resturant": restDistance,
            "coffe": coffeDistance,
            "air_condition": valueAirCondition ? "on" : null,
            "cable_tv": valueCableTV ? "on" : null,
            "computer": valueComputer ? "on" : null,
            "gas_line": valueGasline ? "on" : null,
            "dishwasher": valueDishwasher ? "on" : null,
            "internet": valueInternet ? "on" : null,
            "heater": valueHeater ? "on" : null,
            "microwave": valueMicrowave ? "on" : null,
            "balcony": valuebalcony ? "on" : null,
            "lift": valueLift ? "on" : null,
            "grill": valueGrill ? "on" : null,
            "pool": valuePool ? "on" : null,
            "parking": valueParking ? "on" : null,
            "recption": null,
            "security": valueSecurity ? "on" : null,
            "add_type": adsTypeValue,
            "image[]": myImage,
          });
      print(imagesFile[0]);
      if (response.statusCode == 200) {
        addUnitModel = AddUnitModel.fromJson(response.data);
        if (response.data["status"] == false) {
          CustomToast(
            color: Colors.yellow,
            msg: response.data["message"].values.first.first,
          );
          emit(ErrorDataStauts());
        } else if (response.data["status"] == true) {
          unitData = addUnitModel?.unit;
          emit(SuccesAddingDataState());
          CustomToast(
            color: Colors.green,
            msg: "تمت الاضافه بنجاح",
          );
          // Navigator.of(context).pop();
          print(unitData);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorAddUnit());
      CustomToast(
        color: Colors.yellow,
        msg: "ادخل البيانات كامله",
      );
    }
  }

  void removeUnitById(int? unitId) {
    getDataFeature.removeWhere((element) => element.id == unitId);
    getDataPopular.removeWhere((element) => element.id == unitId);
    emit(RemoveUnitByIdState());
  }

  ///Get Features
  GetAllFeaturesCompanyModel? getAllFeaturesCompanyModel;
  List<UnitModel> getDataFeature = [];
  List<String> images = [];
  int? currentPage;
  int? lastPage;
  int detactedPage = 1;

  chaangeCurrentPage() {
    lastPage != currentDetailsScreen
        ? detactedPage++
        : debugPrint("$detactedPage");
    emit(ChangeCurrentPageInUnit());
  }

  Future getAllFeatures({bool useFilters = false}) async {
    final companyToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    try {
      emit(LoadingGetFeaturesData());
      final Map<String, dynamic> data = {
        'add_type': 'Feature',
        'status': 'Accepted'
      };
      if (useFilters) {
        final filters = FilterCubit.instance(context).getFilterResults.toMap();
        final searchText = FilterCubit.instance(context).searchText;
        data.addAll(filters);
        data.addAll({'text': searchText});
      }
      response = await DioHelper.postDataWithAuth(
          url: getFeatureAndPopularUnitURL,
          data: data,
          // {
          //   "add_type": "Feature",
          //   "status": "Accepted",
          // },
          token: companyToken);
      if (response.statusCode == 200) {
        getDataFeature.clear();
        getAllFeaturesCompanyModel =
            GetAllFeaturesCompanyModel.fromJson(response.data);
        if (getAllFeaturesCompanyModel != null &&
            getAllFeaturesCompanyModel!.units != null) {
          for (var element in getAllFeaturesCompanyModel!.units!.data) {
            getDataFeature.add(element);
          }
        }
        currentPage = getAllFeaturesCompanyModel?.units?.meta!.currentPage;
        lastPage = getAllPobularCompanyModel?.units?.meta!.lastPage;

        if (state is SuccessGetFeaturesData) {
          for (var element in getDataFeature) {
            element.images?.forEach((element) {
              images.add(element);
            });
          }
          print(images[0]);
          emit(SuccessGetImageData());
        }
        log("$getDataFeature");
        print("momom:${getDataFeature[0].images?.first}");
        emit(SuccessGetFeaturesData());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorGetFeaturesData());
    }
  }

  ///Get Pobular Data
  PopularModel? getAllPobularCompanyModel;
  List<UnitModel> getDataPopular = [];
  List<String> imagesPobular = [];

  Future getAllPobular({bool useFilters = false}) async {
    try {
      emit(LoadingGetPopularData());
      final companyToken =
          await Shared.prefGetString(key: "CompanyTokenVerify");
      Response response;
      final Map<String, dynamic> data = {
        'add_type': 'Popular',
        'status': 'Accepted'
      };
      if (useFilters) {
        final filters = FilterCubit.instance(context).getFilterResults.toMap();
        final searchText = FilterCubit.instance(context).searchText;
        data.addAll(filters);
        data.addAll({'text': searchText});
      }
      response = await DioHelper.postDataWithAuth(
          url: getFeatureAndPopularUnitURL,
          data: data,
          // {
          //   "add_type": "Popular",
          //   "status": "Accepted",
          // },
          token: companyToken);
      if (response.statusCode == 200) {
        getAllPobularCompanyModel = PopularModel.fromJson(response.data);
        getDataPopular.clear();
        if (getAllPobularCompanyModel != null &&
            getAllPobularCompanyModel!.units != null) {
          for (var element in getAllPobularCompanyModel!.units!.data) {
            getDataPopular.add(element);
          }
        }
        if (state is SuccessGetPopularData) images.clear();
        for (var element in getDataPopular) {
          element.images?.forEach((element) {
            images.add(element);
          });
        }
        emit(SuccessGetPopularImageData());
      }
      log("$getDataPopular");
      emit(SuccessGetPopularData());
    } catch (e) {
      emit(ErrorGetPopularData());
    }
  }

  Future getAllFunction() async {
    getAllFeatures();
    getAllPobular();
  }

  ///Pick date

  String title = "";

  changeDate(val) async {
    title = val;
    emit(ChangeDateState());
  }

  ///Pick Location
  SelectedLocation? selectedLocation;
  FormattedLocation? formattedLocation;

  double? latitude;
  double? longitude;

  getLatAndLongFromLocation(double lat, double long) {
    latitude = lat;
    longitude = long;
    emit(ChangeLocationState());
  }

  removeLatLngLocation() {
    latitude = null;
    longitude = null;
    emit(ChangeLocationState());
  }

  void addLocation(SelectedLocation value) {
    selectedLocation = value;
    print("value of addLoc: $value");
    emit(changeValueOfLocation());
  }

  ///Change Number value
  int numBedRoom = 0;
  int numFloor = 0;
  int numRoom = 0;
  int numBathRoom = 0;

  changeNumBedRoomsPlus() {
    numBedRoom++;
    emit(PlusNumberState());
  }

  changeNumBedRoomsMinus() {
    numBedRoom == 0 ? null : numBedRoom--;
    emit(MinusNumberState());
  }

  changeNumRoomsPlus() {
    numRoom++;
    emit(PlusNumberState());
  }

  changeNumRoomsMinus() {
    numRoom == 0 ? null : numRoom--;
    emit(MinusNumberState());
  }

  changeNumFloorPlus() {
    numFloor++;
    emit(PlusNumberState());
  }

  changeNumFloorMinus() {
    numFloor == 0 ? null : numFloor--;
    emit(MinusNumberState());
  }

  changeNumBathPlus() {
    numBathRoom++;
    emit(PlusNumberState());
  }

  changeNumBathMinus() {
    numBathRoom == 0 ? null : numBathRoom--;
    emit(MinusNumberState());
  }

  ///Change Screen in Details
  int currentDetailsScreen = 0;

  //change distance data
  String? trainDistance;

  changeDistanceToTrain(String val) {
    trainDistance = val;
    emit(ChangeDistanceOfTrain());
  }

  String? metroDistance;

  changeDistanceToMetro(String val) {
    metroDistance = val;
    emit(ChangeDistanceOfMetro());
  }

  String? BusDistance;

  changeDistanceToBus(String val) {
    BusDistance = val;
    emit(ChangeDistanceOfBus());
  }

  String? pharmacyDistance;

  changeDistanceToPharmacy(String val) {
    pharmacyDistance = val;
    emit(ChangeDistanceOfPharmacy());
  }

  String? coffeDistance;

  changeDistanceToCoffe(String val) {
    coffeDistance = val;
    emit(ChangeDistanceOfCoffe());
  }

  String? restDistance;

  changeDistanceRest(String val) {
    restDistance = val;
    emit(ChangeDistanceOfRest());
  }

  String? BakaryDistance;

  changeDistanceToBakary(String val) {
    BakaryDistance = val;
    emit(ChangeDistanceOfBakary());
  }

  String? beachDistance;

  changeDistanceToBeach(String val) {
    beachDistance = val;
    emit(ChangeDistanceOfBeach());
  }

  //change outdoor and indoor data

  // changeScreenOfDetails(int val) {
  //   currentDetailsScreen = val;
  //   emit(ChangeCurrentIndexOfScreenDetails());
  // }

  bool valueAirCondition = false;

  changeAirConditionValue(bool val) {
    valueAirCondition = val;
    emit(ChangeAirCondationState());
  }

  bool valueCableTV = false;

  changeCableTVValue(bool val) {
    valueCableTV = val;
    emit(ChangeCableTvState());
  }

  bool valueComputer = false;

  changeComputerValue(bool val) {
    valueComputer = val;
    emit(ChangeComputerState());
  }

  bool valueGasline = false;

  changeGaslineValue(bool val) {
    valueGasline = val;
    emit(ChangeGaslineState());
  }

  bool valueDishwasher = false;

  changeDishwasherValue(bool val) {
    valueDishwasher = val;
    emit(ChangeDishWasherState());
  }

  bool valueInternet = false;

  changeInternetValue(bool val) {
    valueInternet = val;
    emit(ChangeInternetState());
  }

  bool valueHeater = false;

  changeHeaterValue(bool val) {
    valueHeater = val;
    emit(ChangeHeaterState());
  }

  bool valueMicrowave = false;

  changeMicrowaveValue(bool val) {
    valueMicrowave = val;
    emit(ChangeMicrowaveState());
  }

  bool valuebalcony = false;

  changeBalconyValue(bool val) {
    valuebalcony = val;
    emit(ChangeBalconyState());
  }

  bool valueLift = false;

  changeLiftValue(bool val) {
    valueLift = val;
    emit(ChangeLiftState());
  }

  bool valueGrill = false;

  changeGrillValue(bool val) {
    valueGrill = val;
    emit(ChangeGrillState());
  }

  bool valuePool = false;

  changePoolValue(bool val) {
    valuePool = val;
    emit(ChangePoolState());
  }

  bool valueSecurity = false;

  changeSecurityValue(bool val) {
    valueSecurity = val;
    emit(ChangePoolState());
  }

  bool valueParking = false;

  changeParkingValue(bool val) {
    valueParking = val;
    emit(ChangeParkingState());
  }

  ///Update the Unit
  AddUnitModel? updateUnitModel;
  Unit? unitUpdateData;
  int? newId;

  changeId({id}) {
    newId = id;
    emit(ChangeIdOfUnit());
  }

  updateUnit({
    required String title,
    required String downPayment,
    required String monthlyPayment,
    required String deposite,
    required String numYears,
    required String area,
    required String yearBuild,
    required String price,
    required String video,
    required BuildContext context,
    required String unitId,
  }) async {
    emit(LoadingUpdateUnitState());
    Response response;
    List<MultipartFile> myImage = [];
    for (var i = 0; i < imagesFile.length; i++) {
      myImage.add(
        await DioHelper.uploadFile(imagesFile[i]),
      );
    }
    debugPrint("print:${myImage.length.toString()}");
    final companyToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    try {
      final cityId = CommonCubit.get(context).cityIndex.toString();
      final countryId = CommonCubit.get(context).valueCountryId.toString();
      final areaId = CommonCubit.get(context).areaIndex.toString();
      response = await DioHelper.postDataWithAuth(
        url: companyUnitUpdateURL,
        data: {
          // "title": title,
          // "type": type,
          // "required_fields": required_fields,
          // "view": view,
          // "description": description,
          // "purpose": purpose,
          // "down_payment": down_payment,
          // "monthly_payment": monthly_payment,
          // "deposite": deposite,
          // "num_years": num_years,
          // "price": price,
          // "payment_method": payment_method,
          // "country_id": country_id,
          // "city_id": city_id,
          // "area_id": area_id,
          // "available": available,
          // "available_date": available_date,
          // "lat": lat,
          // "long": long,
          // "video": video,
          // "rooms": rooms,
          // "bathroom": bathroom,
          // "floor": floor,
          // "year_build": year_build,
          // "area": area,
          // "bedrooms": bedrooms,
          // "finished_type": finished_type,
          // "metro": metro,
          // "train": train,
          // "bus": bus,
          // "pharmacy": pharmacy,
          // "beach": beach,
          // "bakary": bakary,
          // "resturant": resturant,
          // "coffe": coffe,
          // "air_condition": air_condition,
          // "cable_tv": cable_tv,
          // "computer": computer,
          // "gas_line": gas_line,
          // "dishwasher": dishwasher,
          // "internet": internet,
          // "heater": heater,
          // "microwave": microwave,
          // "balcony": balcony,
          // "lift": lift,
          // "grill": grill,
          // "pool": pool,
          // "parking": parking,
          // "recption": recption,
          // "security": security,
          // "add_type": add_type,
          // "image[]": await myImage,
          "title": title,
          "type": dropDownStyleTypeValue,
          "required_fields": requiredFields,
          "view": ViewsValue,
          "description": description,
          "purpose": purpose,
          "down_payment": downPayment,
          "monthly_payment": monthlyPayment,
          "deposite": deposite,
          "num_years": numYears,
          "price": price,
          "payment_method": paymentMethodValue,
          "country_id": countryId,
          "city_id": cityId,
          "area_id": areaId,
          "available": availabe == "available" ? 1 : 0,
          "available_date": null,
          "lat": latitude,
          "long": longitude,
          "video": video,
          "rooms": numRoom,
          "bathroom": numBathRoom,
          "floor": numFloor,
          "year_build": yearBuild,
          "area": area,
          "bedrooms": numBedRoom,
          "finished_type": finishTypeValue,
          "metro": metroDistance,
          "train": trainDistance,
          "bus": BusDistance,
          "pharmacy": pharmacyDistance,
          "beach": beachDistance,
          "bakary": BakaryDistance,
          "resturant": restDistance,
          "coffe": coffeDistance,
          "air_condition": valueAirCondition ? "on" : null,
          "cable_tv": valueCableTV ? "on" : null,
          "computer": valueComputer ? "on" : null,
          "gas_line": valueGasline ? "on" : null,
          "dishwasher": valueDishwasher ? "on" : null,
          "internet": valueInternet ? "on" : null,
          "heater": valueHeater ? "on" : null,
          "microwave": valueMicrowave ? "on" : null,
          "balcony": valuebalcony ? "on" : null,
          "lift": valueLift ? "on" : null,
          "grill": valueGrill ? "on" : null,
          "pool": valuePool ? "on" : null,
          "parking": valueParking ? "on" : null,
          "recption": null,
          "security": valueSecurity ? "on" : null,
          "add_type": adsTypeValue,
          "image[]": myImage,
          "unit_id": unitId,
        },
        token: companyToken,
      );
      if (response.statusCode == 200) {
        updateUnitModel = AddUnitModel.fromJson(response.data);
        if (response.data["status"] == false) {
          CustomToast(
            color: Colors.yellow,
            msg: response.data["message"].values.first.first,
          );
          emit(ErrorUpadateUnitDataStauts());
        } else if (response.data["status"] == true) {
          unitUpdateData = addUnitModel?.unit;
          emit(SuccesUpdateDataState());
          CustomToast(
            color: Colors.green,
            msg: "تم التعديل بنجاح",
          );
          Navigator.of(context).pop(true);
          print(unitData);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorAddUnit());
      CustomToast(
        color: Colors.yellow,
        msg: "ادخل البيانات كامله",
      );
    }
  }

  ///deleteUnit

  deleteUnit() async {
    emit(LoadingDeleteUnitState());
    final coToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    Response response;
    response = await DioHelper.postDataWithAuth(
      url: deleteUnitURL,
      data: {"unit_id": newId},
      token: coToken,
    );
    if (response.statusCode == 200 && response.data["status"] == true) {
      emit(SuccessDeleteUnitState());
    } else {
      emit(ErrorDeleteUnitState());
    }
  }

  //For displaying unit
  UnitModel? unit;
  Future<void> getUnitById(String unitId) async {
    try {
      emit(GetUnitLoadingState());
      final companyToken =
          await Shared.prefGetString(key: "CompanyTokenVerify");

      Response response = await DioHelper.postDataWithAuth(
        url: companyGetUnitById,
        data: {"unit_id": unitId},
        token: companyToken,
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        unit = UnitModel.fromJson(response.data["units"]);
      }
      emit(GetUnitSuccessState());
    } catch (e) {
      emit(GetUnitErrorState(error: e.toString()));
    }
  }

//For searching in units [Featured,populars]
  SearchInEnum selectedSearchIn = SearchInEnum.feature;
  void changeSelectedSearchType(SearchInEnum type) async {
    selectedSearchIn = type;
    emit(ChangeSelectedSearchType());
    await searchInUnits();
  }

  Future<void> searchInUnits() async {
    switch (selectedSearchIn) {
      case SearchInEnum.feature:
        await getAllFeatures(useFilters: true);
        break;
      case SearchInEnum.popular:
        await getAllPobular(useFilters: true);
        break;
      default:
    }
  }

  List<UnitModel> get getUnitsBySearchType {
    switch (selectedSearchIn) {
      case SearchInEnum.feature:
        return getDataFeature;
      case SearchInEnum.popular:
        return getDataPopular;
    }
  }
}

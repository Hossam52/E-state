import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/BannerModel/bannerModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/featureModel/getFeatureModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/popularModel/PopularModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/popularModel/user_unit_category_filter.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/MapScreen/mapDetails.dart';
import 'package:osol/User/PresentaionLayer/compareScreen/view.dart';
import 'package:osol/User/PresentaionLayer/compniesScreen/view.dart';
import 'package:osol/User/PresentaionLayer/moreScreen/view.dart';
import 'package:osol/common_models/filter_displayed_units_model.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../DataLayer/localDataLayer/localData.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  String? accessType;
  String? token;
  final BuildContext context;
  HomeCubit({required this.context, this.accessType, this.token})
      : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final clienToken = Shared.prefGetString(key: "CompanyTokenVerify");

  /// Home ==> start
  int currentIndex = 0;
  bool drawerOpen = false;

  changeIndexOfBody(int index) {
    currentIndex = index;
    emit(ChangeIndexBody());
  }

  List<Widget> screen = [
    HomeViewData(),
    MapScreen(),
    CompaniesViewData(),
    CompareView(),
    MoreViewScreen(),
  ];

  changeDrawerState() {
    drawerOpen = !drawerOpen;
    emit(ChangeDrawerState());
  }

  ///change color of unit save
  bool color = false;

  changeColor() {
    color = !color;
    emit(ChangeColorSave());
  }

  int currentHomeBoardIndex = 0;

  changePageViewInHome(index) {
    currentHomeBoardIndex = index;
    emit(ChangeHomeOnBoard());
  }

  ///Label List
  // int currentLabelindex = 0;
  late final List<UserUnitCategory> _allCategories = [
    UserCustomUnitsCategory(onCategoryTapped: () async {
      log('Custom tapped');
      changeUnitCategoryIndex(0);
    }),
    UserAllUnitsCategory(onCategoryTapped: () async {
      log('All tapped');
      changeUnitCategoryIndex(1);
    }),
    UserSaleUnitsCategory(onCategoryTapped: () async {
      log('sale tapped');
      changeUnitCategoryIndex(2);
    }),
    UserRentUnitCategory(onCategoryTapped: () async {
      log('rent tapped');
      changeUnitCategoryIndex(3);
    }),
    UserCompoundUnitCategory(onCategoryTapped: () async {
      log('compund tapped');
      changeUnitCategoryIndex(4);
    }),
    UserEstateUnitCategory(onCategoryTapped: () async {
      log('estate tapped');
      changeUnitCategoryIndex(5);
    }),
  ];
  List<UserUnitCategory> allCategories(bool displayCustomFilter) {
    if (displayCustomFilter) {
      return _allCategories;
    } else {
      return _allCategories.getRange(1, _allCategories.length).toList();
    }
  }

  UserUnitCategory get selectedCategory =>
      _allCategories[selectedUnitCategoryIndex];

  UnitCategory get selectedUnitCategory =>
      _allCategories[selectedUnitCategoryIndex] as UnitCategory;
  bool get isFeaturedLoaded => selectedCategory.features != null;
  List<UnitModel> get featuresUnits => selectedCategory.features ?? [];

  bool get isPopularLoaded => selectedCategory.popular != null;
  List<UnitModel> get popularUnits => selectedCategory.popular ?? [];
  int selectedUnitCategoryIndex = 1;

  void changeUnitCategoryIndex(int index) {
    selectedUnitCategory.toggleIsSelected();
    selectedUnitCategoryIndex = index;
    selectedUnitCategory.toggleIsSelected();
    if (selectedUnitCategory is CustomUnitsCategory) {
      getCustomFilterFeatureOfClientHome();
      getCustomFilterPopularOfClientHome();
    } else {
      if (selectedCategory.features == null) {
        getFeatureOfClientHome();
      }
      if (selectedCategory.popular == null) {
        getPopularOfClientHome();
      }
    }
    emit(ChangeSelectedCategoryIndex());
  }

  void showFilterResults() {
    changeUnitCategoryIndex(0);
  }

  // changeLabel(index) {
  //   // currentLabelindex = index;
  //   imagesFeature.clear();
  //   dataFeature.clear();
  //   imagesPopular.clear();
  //   dataPopular.clear();
  //   getFeatureOfClientHome();
  //   getPopularOfClientHome();
  //   emit(ChangeLabelIndex());
  // }

  // List<ListViewLabelModel> listData = [
  //   ListViewLabelModel(icon: FontAwesomeIcons.ellipsisVertical, txt: "All"),
  //   ListViewLabelModel(icon: FontAwesomeIcons.tag, txt: "Sale"),
  //   ListViewLabelModel(icon: OsolIcon.calendar, txt: "Rent"),
  //   ListViewLabelModel(icon: OsolIcon.home_3, txt: "Compound"),
  //   ListViewLabelModel(icon: OsolIcon.estate, txt: "Estate"),
  // ];

  /// Index Bottom Sheet
  int indexBottomSheet = 0;

  changeBottomSheetEstate(index) {
    indexBottomSheet = 0;
    emit(ChangeIndexOfBottomSheet());
  }

  /// Compare Screen
  List<HomeScreenSliderModel> homeScreenSliderData = [
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/pic1.png", Text: "60%"),
  ];

  /// custom appBar
  bool numberIcon = false;

  appBarChangeIcon() {}

  /// saved Screen
  int toggleSaved = 0;

  changeTogleSavedState(index) {
    toggleSaved = index;
    emit(ChangeIconsSavedState());
  }

  int indexTogleIcons = 0;

  ///getTokenByShared
  String? sharedToken;

  Future getToken() async {
    sharedToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    debugPrint("dddd${sharedToken}");
  }

  changeTogleIconsState(index) {
    indexTogleIcons = index;
    emit(ChangeIconsCompanyState());
  }

  /// Map Screen
  ScrollController scrollController = new ScrollController();
  double _width = sizeFromWidth(1.5);

  void scrollToIndex(index) {
    scrollController.animateTo(_width * index,
        duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
  }

  // getMarker(id, latLng, imageData) {
  //   Marker(
  //     markerId: MarkerId("$id"),
  //     position: latLng,
  //     draggable: false,
  //     icon: BitmapDescriptor.fromBytes(imageData),
  //     zIndex: 2,
  //     anchor: Offset(0.5, 0.5),
  //     flat: true,
  //   );
  // }
  //
  // var myMarkers = HashSet<Marker>();
  // Uint8List? imagedata;
  // OnMapcreated() async {
  //   Uint8List imageData = await getLabelMarker();
  //
  // }

  // addMrkers() {
  //   myMarkers.add(getMarker(
  //     "me",
  //     LatLng(30.005493, 31.477898),
  //     imagedata,
  //   ));
  // }

  Future<Uint8List> getLabelMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/maplabel.png");
    return byteData.buffer.asUint8List();
  }

// getAddMarkers(){
//   myMarkers.addAll(latLong);
// }
  /// Search Screen
  ///Filter Screen
  int filterIndex = 0;
  int filterNewIndex = 0;

  changeIndexInFilter(index) {
    filterNewIndex = index;
    emit(ChangeIndexInFilter());
  }

  int filterNewIndexFinishType = 0;

  changeIndexInFilterFinishType(index) {
    filterNewIndexFinishType = index;
    emit(ChangeIndexInFilterFinishType());
  }

  String requiredField = "";

  changeIndexInFilterrequiredField(String index) {
    requiredField = index;
    emit(ChangeIndexInFilterRequiredField());
  }

  int advistor = 0;

  changeIndexInAdvistor(index) {
    advistor = index;
    emit(ChangeIndexInAdvistor());
  }

  int propType = 0;

  changePropType(index) {
    propType = index;
    emit(ChangePropTypeState());
  }

  double start = 300;
  double end = 500;

  changeRangeSlider(value) {
    start = value.start;
    end = value.end;
    emit(ChangeValueOfSlider());
    print("${start},$end");
  }

  int indexOfTypeOfFilter = 0;

  changeTypeOfFilter(index) {
    indexOfTypeOfFilter = index;
    print(indexOfTypeOfFilter);
    emit(ChangeTypeOfFilter());
  }

  ///get token
  String? myToken;

  getMyToken() async {
    myToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    print("get my Token  $myToken");
    emit(GetMyToken());
    return myToken;
  }

  ///get data of banner client
  ClientBannerModel? clientBannerModel;
  List<DataOfBanner> dataBanner = [];

  Future<void> getBannerOfClientHome() async {
    dataBanner.clear();
    final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    debugPrint("mmmmmmmm${cToken}");
    emit(LoadingGetBannerOfHomeState());
    Response response;
    try {
      response = await DioHelper.getData(
        url: getBannerGuestURL,
        token: cToken,
      );
      if (response.statusCode == 200) {
        clientBannerModel = ClientBannerModel.fromJson(response.data);
        clientBannerModel?.banners?.data?.forEach((element) {
          dataBanner.add(element);
          debugPrint("saaaa${element}");
        });
        emit(SuccesGetDataOfBannerState());
      }
    } catch (e) {
      emit(ErrorDrtBannerClient());
      debugPrint("${e.toString()}");
    }
  }

  ///get feature data of client
  ClientFeatureModel? clientFeatureModel;

  Future<void> getFeatureOfClientHome() async {
    final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    debugPrint("mmmmmmmm${cToken}");
    emit(LoadingGetFeatureState());
    Response response;
    final Map<String, dynamic> data = {'add_type': 'Feature'};
    if (selectedCategory is SaleUnitsCategory ||
        selectedCategory is RentUnitCategory) {
      data['purpose'] = selectedUnitCategory.type;
    } else {
      data['type'] = selectedUnitCategory.type;
    }
    response = await DioHelper.postDataWithAuth(
      url: getFeatureURL,
      // data: currentLabelindex == 0
      //     ? {
      //         "add_type": "Feature",
      //       }
      //     : currentLabelindex == 1
      //         ? {
      //             "purpose": "Sale",
      //             "add_type": "Feature",
      //           }
      //         : currentLabelindex == 2
      //             ? {
      //                 "purpose": "Rent",
      //                 "add_type": "Feature",
      //               }
      //             : currentLabelindex == 3
      //                 ? {
      //                     "type": "Compound",
      //                     "add_type": "Feature",
      //                   }
      //                 : {
      //                     "type": "Estate",
      //                     "add_type": "Feature",
      //                   },
      data: data,
    );
    if (response.statusCode == 200) {
      clientFeatureModel = ClientFeatureModel.fromJson(response.data);

      selectedCategory.features =
          List.from(clientFeatureModel?.units?.data ?? []);
      emit(SuccesGetFeatureState());

      // for (int i = 0; i < dataFeature.length; i++) {
      //   dataFeature[i].images?.forEach((element) {
      //     print("$i ${element}");
      //     imagesFeature.add(element);
      //   });

      //   emit(SuccessGetFeatureImage());
      // }
    }
    // } catch (e) {
    //   emit(ErrorGetFeatureState());
    //   debugPrint("${e.toString()}");
    // }
  }

  Future<void> getCustomFilterFeatureOfClientHome() async {
    final filterResultsMap =
        FilterCubit.instance(context).getFilterResults.toMap();
    filterResultsMap.addAll({
      "add_type": "Feature",
    });
    try {
      final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
      emit(LoadingGetFeatureState());
      Response response;

      response = await DioHelper.postDataWithAuth(
        url: getFeatureURL,
        data: filterResultsMap,
      );
      if (response.statusCode == 200) {
        clientFeatureModel = ClientFeatureModel.fromJson(response.data);

        selectedCategory.features =
            List.from(clientFeatureModel?.units?.data ?? []);
        emit(SuccesGetFeatureState());
      }
    } catch (e) {
      emit(ErrorGetFeatureState());
    }
  }

  ///get popular data

  ClientPopularModel? clientPopularModel;
  // List<UnitModel> dataPopular = [];
  // List<String> imagesPopular = [];

  Set<Marker> _convertUnitsToMarker(List<UnitModel> units) {
    return units
        .map((e) => Marker(
              markerId: MarkerId(e.id.toString()),
              position: LatLng(double.parse(e.lat!.toString()),
                  double.parse(e.long!.toString())),
              draggable: false,
              icon: markerLabel != null
                  ? BitmapDescriptor.fromBytes(markerLabel!)
                  : BitmapDescriptor.defaultMarker,
              zIndex: 2,
              anchor: Offset(0.5, 0.5),
              flat: false,
              onTap: () {
                scrollToIndex(
                  e.id,
                );
              },
            ))
        .toSet();
  }

  Set<Marker> get getMapMarkers {
    final Set<Marker> markers = {};
    if (selectedCategory.popular != null) {
      markers.addAll(_convertUnitsToMarker(selectedCategory.popular!).toSet());
    }
    if (selectedCategory.features != null) {
      markers.addAll(_convertUnitsToMarker(selectedCategory.features!).toSet());
    }
    return markers;
  }

  Uint8List? markerLabel;
  Future<void> loadMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/maplabel.png");
    markerLabel = byteData.buffer.asUint8List();
  }

  Future<void> getPopularOfClientHome() async {
    final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    debugPrint("ed${cToken}");

    emit(LoadingGetPopularState());
    Response response;
    final Map<String, dynamic> data = {'add_type': 'Popular'};
    if (selectedCategory is SaleUnitsCategory ||
        selectedCategory is RentUnitCategory) {
      data['purpose'] = selectedUnitCategory.type;
    } else {
      data['type'] = selectedUnitCategory.type;
    }
    response = await DioHelper.postDataWithAuth(url: getFeatureURL, data: data);
    if (response.statusCode == 200) {
      clientPopularModel = ClientPopularModel.fromJson(response.data);
      // clientPopularModel?.units?.data?.forEach((element) {
      //   dataPopular.add(element);
      //   debugPrint("home Popular:${element.purpose}");
      // });
      selectedCategory.popular =
          List.from(clientPopularModel?.units?.data ?? []);

      emit(SuccesGetPopularState());
      // if (dataPopular.length != null) {
      //   for (int i = 0; i < dataPopular.length; i++) {
      //     dataPopular[i].images?.forEach((element) {
      //       imagesPopular.add(element);
      //       debugPrint("fdfdaa${element}");
      //     });
      //   }
      //   emit(SuccessGetPopularImage());
      // }
    }
    emit(ErrorGetPopularState());
  }

  Future<void> getCustomFilterPopularOfClientHome() async {
    final filterResultsMap =
        FilterCubit.instance(context).getFilterResults.toMap();
    filterResultsMap.addAll({
      "add_type": "Popular",
    });
    final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");

    emit(LoadingGetPopularState());
    Response response;

    response = await DioHelper.postDataWithAuth(
        url: getFeatureURL, data: filterResultsMap);
    if (response.statusCode == 200) {
      clientPopularModel = ClientPopularModel.fromJson(response.data);

      selectedCategory.popular =
          List.from(clientPopularModel?.units?.data ?? []);

      emit(SuccesGetPopularState());
    } else {
      emit(ErrorGetPopularState());
    }
  }

  getDataOfHome() async {
    getBannerOfClientHome();
    getFeatureOfClientHome();
    getPopularOfClientHome();
    getMyToken();
  }
}

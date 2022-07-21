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
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/BannerModel/bannerModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/featureModel/getFeatureModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/popularModel/PopularModel.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/MapScreen/mapDetails.dart';
import 'package:osol/User/PresentaionLayer/compareScreen/view.dart';
import 'package:osol/User/PresentaionLayer/compniesScreen/view.dart';
import 'package:osol/User/PresentaionLayer/moreScreen/view.dart';

import '../../DataLayer/localDataLayer/localData.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  String? accessType;
  String? token;

  HomeCubit({this.accessType, this.token}) : super(HomeInitial());

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
  int currentLabelindex = 0;

  changeLabel(index) {
    currentLabelindex = index;
    imagesFeature.clear();
    dataFeature.clear();
    imagesPopular.clear();
    dataPopular.clear();
    getFeatureOfClientHome();
    getPopularOfClientHome();
    emit(ChangeLabelIndex());
  }

  List<ListViewLabelModel> listData = [
    ListViewLabelModel(icon: FontAwesomeIcons.ellipsisVertical, txt: "All"),
    ListViewLabelModel(icon: FontAwesomeIcons.tag, txt: "Sale"),
    ListViewLabelModel(icon: OsolIcon.calendar, txt: "Rent"),
    ListViewLabelModel(icon: OsolIcon.home_3, txt: "Compound"),
    ListViewLabelModel(icon: OsolIcon.estate, txt: "Estate"),
  ];

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
  List<FeatureData> dataFeature = [];
  List<String> imagesFeature = [];

  Future<void> getFeatureOfClientHome() async {
    dataFeature.clear();
    final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    debugPrint("mmmmmmmm${cToken}");
    emit(LoadingGetFeatureState());
    Response response;

      response = await DioHelper.postDataWithAuth(
        url: getFeatureURL,
        data: currentLabelindex == 0
            ? {
                "add_type": "Feature",
              }
            : currentLabelindex == 1
                ? {
                    "purpose": "Sale",
                    "add_type": "Feature",
                  }
                : currentLabelindex == 2
                    ? {
                        "purpose": "Rent",
                        "add_type": "Feature",
                      }
                    : currentLabelindex == 3
                        ? {
                            "type": "Compound",
                            "add_type": "Feature",
                          }
                        : {
                            "type": "Estate",
                            "add_type": "Feature",
                          },
      );
      dataFeature.clear();
      if (response.statusCode == 200) {
        clientFeatureModel = ClientFeatureModel.fromJson(response.data);
        clientFeatureModel?.units?.data?.forEach((element) {
          dataFeature.add(element);
        });
        emit(SuccesGetFeatureState());

        for (int i = 0; i < dataFeature.length; i++) {
          dataFeature[i].images?.forEach((element) {
            print("$i ${element}");
            imagesFeature.add(element);
          });

          emit(SuccessGetFeatureImage());
        }
      }
    // } catch (e) {
    //   emit(ErrorGetFeatureState());
    //   debugPrint("${e.toString()}");
    // }
  }

  ///get popular data

  ClientPopularModel? clientPopularModel;
  List<PopularData> dataPopular = [];
  List<String> imagesPopular = [];
  Set<Marker> myMarker = Set();

  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/maplabel.png");
    return byteData.buffer.asUint8List();
  }

  Future<void> getPopularOfClientHome() async {
    Uint8List imageData = await getMarker();
    dataPopular.clear();
    final cToken = await Shared.prefGetString(key: "CompanyTokenVerify");
    debugPrint("ed${cToken}");

    emit(LoadingGetPopularState());
    Response response;

    response = await DioHelper.postDataWithAuth(
      url: getFeatureURL,
      data: currentLabelindex == 0
          ? {
              "add_type": "Popular",
            }
          : currentLabelindex == 1
              ? {
                  "purpose": "Sale",
                  "add_type": "Popular",
                }
              : currentLabelindex == 2
                  ? {
                      "purpose": "Rent",
                      "add_type": "Popular",
                    }
                  : currentLabelindex == 3
                      ? {
                          "type": "Compound",
                          "add_type": "Popular",
                        }
                      : {
                          "type": "Estate",
                          "add_type": "Popular",
                        },
    );
    if (response.statusCode == 200) {
      clientPopularModel = ClientPopularModel.fromJson(response.data);
      clientPopularModel?.units?.data?.forEach((element) {
        dataPopular.add(element);
        debugPrint("home Popular:${element.purpose}");
      });
      myMarker = clientPopularModel!.units!.data!
          .map(
            (e) => Marker(
              markerId: MarkerId(e.id.toString()),
              position: LatLng(double.parse(e.lat!.toString()),
                  double.parse(e.long!.toString())),
              draggable: false,
              icon: BitmapDescriptor.fromBytes(imageData),
              zIndex: 2,
              anchor: Offset(0.5, 0.5),
              flat: false,
              onTap: () {
                scrollToIndex(
                  e.id,
                );
              },
            ),
          )
          .toSet();
      emit(SuccesGetPopularState());
      if (dataPopular.length != null) {
        for (int i = 0; i < dataPopular.length; i++) {
          dataPopular[i].images?.forEach((element) {
            imagesPopular.add(element);
            debugPrint("fdfdaa${element}");
          });
        }
        emit(SuccessGetPopularImage());
      }
    }
    emit(ErrorGetPopularState());
  }

  getDataOfHome() async {
    getBannerOfClientHome();
    getFeatureOfClientHome();
    getPopularOfClientHome();
    getMyToken();
  }
}

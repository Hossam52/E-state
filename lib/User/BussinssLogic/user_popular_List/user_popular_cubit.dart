// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:osol/Company/dataLayer/dataModel/PopularListModel/PopularListModel.dart';
// import 'package:osol/Company/dataLayer/dataModel/pobular/popularModel.dart';
// import 'package:osol/Shared/CustomToast.dart';
// import 'package:osol/Shared/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
// import 'package:osol/common_models/unit_model.dart';
// import 'package:osol/shared/Customicon.dart';

// import '../../../User/DataLayer/localDataLayer/localData.dart';

// part 'user_popular_state.dart';

// class UserPopularCubit extends Cubit<PopularState> {
//   UserPopularCubit() : super(PopularInitial());

//   static UserPopularCubit get(context) => BlocProvider.of(context);
//   late List<CompanyUnitCategory> allCateogires = [
//     AllUnitsCategory(onCategoryTapped: () async {
//       log('All tapped');
//       changeUnitCategoryIndex(0);
//     }),
//     SaleUnitsCategory(onCategoryTapped: () async {
//       log('sale tapped');
//       changeUnitCategoryIndex(1);
//     }),
//     RentUnitCategory(onCategoryTapped: () async {
//       log('rent tapped');
//       changeUnitCategoryIndex(2);
//     }),
//     CompoundUnitCategory(onCategoryTapped: () async {
//       log('compund tapped');
//       changeUnitCategoryIndex(3);
//     }),
//     EstateUnitCategory(onCategoryTapped: () async {
//       log('estate tapped');
//       changeUnitCategoryIndex(4);
//     }),
//   ];
//   CompanyUnitCategory get selectedCategory =>
//       allCateogires[selectedUnitCategoryIndex];
//   bool get isCategoryLoadedData => selectedCategory.units != null;
//   List<UnitModel> get displayedUnits => selectedCategory.units ?? [];
//   int selectedUnitCategoryIndex = 0;
//   void changeUnitCategoryIndex(int index) {
//     allCateogires[selectedUnitCategoryIndex].toggleIsSelected();
//     selectedUnitCategoryIndex = index;
//     allCateogires[index].toggleIsSelected();

//     emit(changeIndexOfTapped());
//     getDetectedPopularList();
//   }

//   int currentIndex = 0;

//   int index = 0;

//   int indexBottomSheet = 0;

//   changeIndexBottomSheet(int index) {
//     indexBottomSheet = index;
//     emit(ChangeIndexBottomSheet());
//   }

//   int? tappedIndex;

//   getTappedIndex(int index) {
//     selectedCategory.changeStatusIndex(index);
//     // tappedIndex = index;
//     // debugPrint("${tappedIndex}");
//     // getDetectedPopularList();
//     emit(changeIndexOfTapped());
//     getDetectedPopularList();
//   }

//   String? tappedContainer;

//   getTappedContainer(String tab) {
//     // tappedContainer = tab;
//     // debugPrint("${tab}");
//     // getDetectedPopularList();
//     // emit(changeIndexOfTapped());
//   }

//   ///Get Popular Data
//   PopularListModel? popularListModel;
//   List<UnitModel> detectedUnitList = [];

//   Future getDetectedPopularList() async {
//     if (selectedCategory.units != null) return;
//     try {
//       detectedUnitList.clear();
//       Response response;
//       emit(LoadingGetPopularListData());
//       final mainToken = await Shared.prefGetString(key: "CompanyTokenVerify");
//       response = await DioHelper.postDataWithAuth(
//           url: getFeatureAndPopularUnitURL,
//           // data: tappedContainer == "Sale" || tappedContainer == "Rent"
//           //     ? {
//           //         "add_type": "Popular",
//           //         "purpose": tappedContainer,
//           //       }
//           //     : {
//           //         "add_type": "Popular",
//           //         "type": "",
//           //       },
//           data: selectedCategory is SaleUnitsCategory ||
//                   selectedCategory is RentUnitCategory
//               ? {
//                   "add_type": "Popular",
//                   "purpose": selectedCategory.type,
//                   "status": selectedCategory.selecteddStatus.status,
//                 }
//               : selectedCategory is AllUnitsCategory
//                   ? {
//                       "add_type": "Popular",
//                       "type": "",
//                       "status": selectedCategory.selecteddStatus.status,
//                     }
//                   : {
//                       "add_type": "Popular",
//                       "type": selectedCategory.type,
//                       "status": selectedCategory.selecteddStatus.status,
//                     },
//           token: mainToken);
//       if (response.statusCode == 200) {
//         popularListModel = PopularListModel.fromJson(response.data);
//         detectedUnitList.clear();
//         popularListModel?.units?.data?.forEach((element) {
//           detectedUnitList.add(element);
//         });
//         selectedCategory.units = List.from(detectedUnitList);
//         emit(SuccessGetPopularListData());
//       }
//     } catch (e) {
//       emit(ErrorGetListOfData());
//     }
//     AllUnitsCategory(onCategoryTapped: () async {
//       return;
//     });
//   }
// }

// abstract class UnitCategory {
//   String get title;
//   String get type; //For data sent in api
//   String get apiCall;
//   IconData get icon;
//   bool _isSelected = false;
//   bool get isSelected;
//   void toggleIsSelected() => _isSelected = !_isSelected;
//   List<UnitModel>? units;
//   Future<void> onTapped();
// }

// abstract class CompanyUnitCategory extends UnitCategory {
//   List<CompanyUnitStatus> statues = [
//     AcceptedUnitStatus(),
//     RejectedUnitStatus(),
//     ExpiredUnitStatus(),
//     PendingUnitStatus(),
//   ];
//   int selectedStatusIndex = 0;
//   CompanyUnitStatus get selecteddStatus => statues[selectedStatusIndex];

//   @override
//   List<UnitModel>? get units => selecteddStatus.units;
//   @override
//   set units(List<UnitModel>? list) => selecteddStatus.units = list;

//   void changeStatusIndex(int index) {
//     statues[selectedStatusIndex].toggleSelected();
//     selectedStatusIndex = index;
//     statues[index].toggleSelected();
//   }

//   @override
//   String get apiCall => getFeatureAndPopularUnitURL;
// }

// class AllUnitsCategory extends CompanyUnitCategory {
//   AllUnitsCategory({required this.onCategoryTapped}) {
//     _isSelected = true;
//   }
//   Future<void> Function() onCategoryTapped;

//   @override
//   String get type => '';
//   @override
//   IconData get icon => FontAwesomeIcons.ellipsisVertical;

//   @override
//   bool get isSelected => _isSelected;

//   @override
//   String get title => 'All';

//   @override
//   Future<void> onTapped() => onCategoryTapped();
// }

// class SaleUnitsCategory extends CompanyUnitCategory {
//   SaleUnitsCategory({required this.onCategoryTapped});
//   Future<void> Function() onCategoryTapped;

//   @override
//   String get type => 'Sale';
//   @override
//   IconData get icon => FontAwesomeIcons.tag;

//   @override
//   bool get isSelected => _isSelected;

//   @override
//   String get title => 'Sale';

//   @override
//   Future<void> onTapped() => onCategoryTapped();
// }

// class RentUnitCategory extends CompanyUnitCategory {
//   RentUnitCategory({required this.onCategoryTapped});
//   Future<void> Function() onCategoryTapped;

//   @override
//   String get type => 'Rent';
//   @override
//   IconData get icon => OsolIcon.calendar;

//   @override
//   bool get isSelected => _isSelected;

//   @override
//   String get title => 'Rent';

//   @override
//   Future<void> onTapped() => onCategoryTapped();
// }

// class CompoundUnitCategory extends CompanyUnitCategory {
//   CompoundUnitCategory({required this.onCategoryTapped});
//   Future<void> Function() onCategoryTapped;

//   @override
//   String get type => 'Compound';
//   @override
//   IconData get icon => OsolIcon.home_3;

//   @override
//   bool get isSelected => _isSelected;

//   @override
//   String get title => 'Compound';

//   @override
//   Future<void> onTapped() => onCategoryTapped();
// }

// class EstateUnitCategory extends CompanyUnitCategory {
//   EstateUnitCategory({required this.onCategoryTapped});
//   Future<void> Function() onCategoryTapped;

//   @override
//   String get type => 'Estate';
//   @override
//   IconData get icon => OsolIcon.estate;

//   @override
//   bool get isSelected => _isSelected;

//   @override
//   String get title => 'Estate';

//   @override
//   Future<void> onTapped() => onCategoryTapped();
// }

// abstract class CompanyUnitStatus {
//   String get title;
//   String get status; //For data sent in api

//   bool isSelected = false;
//   List<UnitModel>? units;
//   void toggleSelected() => isSelected = !isSelected;
// }

// class AcceptedUnitStatus extends CompanyUnitStatus {
//   AcceptedUnitStatus() {
//     isSelected = true;
//   }
//   @override
//   String get status => 'Accepted';
//   @override
//   String get title => 'Accepted';
// }

// class RejectedUnitStatus extends CompanyUnitStatus {
//   @override
//   String get status => 'Rejected';
//   @override
//   String get title => 'Rejected';
// }

// class ExpiredUnitStatus extends CompanyUnitStatus {
//   @override
//   String get status => 'Expired';
//   @override
//   String get title => 'Expired';
// }

// class PendingUnitStatus extends CompanyUnitStatus {
//   @override
//   String get status => 'Pending';
//   @override
//   String get title => 'Pending';
// }

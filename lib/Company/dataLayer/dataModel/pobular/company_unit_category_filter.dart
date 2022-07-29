import 'package:osol/common_models/unit_model.dart';
import 'package:osol/common_models/filter_displayed_units_model.dart';
import 'package:osol/shared/constants.dart';

abstract class CompanyUnitCategory {
  List<CompanyUnitStatus> statues = [
    AcceptedUnitStatus(),
    RejectedUnitStatus(),
    ExpiredUnitStatus(),
    PendingUnitStatus(),
  ];
  int selectedStatusIndex = 0;
  CompanyUnitStatus get selecteddStatus => statues[selectedStatusIndex];

  List<UnitModel>? get units => selecteddStatus.units;
  set units(List<UnitModel>? list) => selecteddStatus.units = list;

  void changeStatusIndex(int index) {
    statues[selectedStatusIndex].toggleSelected();
    selectedStatusIndex = index;
    statues[index].toggleSelected();
  }

  String get apiCall => getProfileCompanyURL;
}

class CompanyCustomCategoryFilter extends CustomUnitsCategory
    with CompanyUnitCategory {
  CompanyCustomCategoryFilter(
      {required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class CompanyAllUnitsCategory extends AllUnitsCategory
    with CompanyUnitCategory {
  CompanyAllUnitsCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class CompanySaleUnitsCategory extends SaleUnitsCategory
    with CompanyUnitCategory {
  CompanySaleUnitsCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class CompanyRentUnitCategory extends RentUnitCategory
    with CompanyUnitCategory {
  CompanyRentUnitCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class CompanyCompoundUnitCategory extends CompoundUnitCategory
    with CompanyUnitCategory {
  CompanyCompoundUnitCategory(
      {required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class CompanyEstateUnitCategory extends EstateUnitCategory
    with CompanyUnitCategory {
  CompanyEstateUnitCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

abstract class CompanyUnitStatus {
  String get title;
  String get status; //For data sent in api

  bool isSelected = false;
  List<UnitModel>? units;
  void toggleSelected() => isSelected = !isSelected;
}

class AcceptedUnitStatus extends CompanyUnitStatus {
  AcceptedUnitStatus() {
    isSelected = true;
  }
  @override
  String get status => 'Accepted';
  @override
  String get title => 'Accepted';
}

class RejectedUnitStatus extends CompanyUnitStatus {
  @override
  String get status => 'Rejected';
  @override
  String get title => 'Rejected';
}

class ExpiredUnitStatus extends CompanyUnitStatus {
  @override
  String get status => 'Expired';
  @override
  String get title => 'Expired';
}

class PendingUnitStatus extends CompanyUnitStatus {
  @override
  String get status => 'Pending';
  @override
  String get title => 'Pending';
}

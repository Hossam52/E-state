import 'package:osol/common_models/unit_model.dart';
import 'package:osol/common_models/filter_displayed_units_model.dart';

abstract class UserUnitCategory {
  List<UnitModel>? features;
  List<UnitModel>? popular;

  String get apiCall => '';
}

class UserCustomUnitsCategory extends CustomUnitsCategory
    with UserUnitCategory {
  UserCustomUnitsCategory(
      {required Future<void> Function({bool forceTap}) onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserAllUnitsCategory extends AllUnitsCategory with UserUnitCategory {
  UserAllUnitsCategory(
      {required Future<void> Function({bool forceTap}) onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserSaleUnitsCategory extends SaleUnitsCategory with UserUnitCategory {
  UserSaleUnitsCategory(
      {required Future<void> Function({bool forceTap}) onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserRentUnitCategory extends RentUnitCategory with UserUnitCategory {
  UserRentUnitCategory(
      {required Future<void> Function({bool forceTap}) onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserCompoundUnitCategory extends CompoundUnitCategory
    with UserUnitCategory {
  UserCompoundUnitCategory(
      {required Future<void> Function({bool forceTap}) onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserEstateUnitCategory extends EstateUnitCategory with UserUnitCategory {
  UserEstateUnitCategory(
      {required Future<void> Function({bool forceTap}) onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

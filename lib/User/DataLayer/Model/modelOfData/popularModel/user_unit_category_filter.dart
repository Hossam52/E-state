import 'package:osol/common_models/unit_model.dart';
import 'package:osol/common_models/filter_displayed_units_model.dart';
import 'package:osol/shared/constants.dart';

abstract class UserUnitCategory {
  List<UnitModel>? features;
  List<UnitModel>? popular;

  String get apiCall => '';
}

class UserAllUnitsCategory extends AllUnitsCategory with UserUnitCategory {
  UserAllUnitsCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserSaleUnitsCategory extends SaleUnitsCategory with UserUnitCategory {
  UserSaleUnitsCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserRentUnitCategory extends RentUnitCategory with UserUnitCategory {
  UserRentUnitCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserCompoundUnitCategory extends CompoundUnitCategory
    with UserUnitCategory {
  UserCompoundUnitCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

class UserEstateUnitCategory extends EstateUnitCategory with UserUnitCategory {
  UserEstateUnitCategory({required Future<void> Function() onCategoryTapped})
      : super(onCategoryTapped: onCategoryTapped);
}

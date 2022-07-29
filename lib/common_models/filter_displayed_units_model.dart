import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/common_models/unit_model.dart';
import 'package:osol/shared/Customicon.dart';

abstract class UnitCategory {
  String get title;
  String get type; //For data sent in api
  String get apiCall;
  IconData get icon;
  bool _isSelected = false;
  bool get isSelected;
  void toggleIsSelected() => _isSelected = !_isSelected;
  Future<void> onTapped();
}

abstract class CustomUnitsCategory extends UnitCategory {
  CustomUnitsCategory({required this.onCategoryTapped});
  Future<void> Function() onCategoryTapped;

  @override
  String get type => '';
  @override
  IconData get icon => Icons.settings;

  @override
  bool get isSelected => _isSelected;

  @override
  String get title => 'Custom';

  @override
  Future<void> onTapped() => onCategoryTapped();
}

abstract class AllUnitsCategory extends UnitCategory {
  AllUnitsCategory({required this.onCategoryTapped}) {
    _isSelected = true;
  }
  Future<void> Function() onCategoryTapped;

  @override
  String get type => '';
  @override
  IconData get icon => FontAwesomeIcons.ellipsisVertical;

  @override
  bool get isSelected => _isSelected;

  @override
  String get title => 'All';

  @override
  Future<void> onTapped() => onCategoryTapped();
}

abstract class SaleUnitsCategory extends UnitCategory {
  SaleUnitsCategory({required this.onCategoryTapped});
  Future<void> Function() onCategoryTapped;

  @override
  String get type => 'Sale';
  @override
  IconData get icon => FontAwesomeIcons.tag;

  @override
  bool get isSelected => _isSelected;

  @override
  String get title => 'Sale';

  @override
  Future<void> onTapped() => onCategoryTapped();
}

abstract class RentUnitCategory extends UnitCategory {
  RentUnitCategory({required this.onCategoryTapped});
  Future<void> Function() onCategoryTapped;

  @override
  String get type => 'Rent';
  @override
  IconData get icon => OsolIcon.calendar;

  @override
  bool get isSelected => _isSelected;

  @override
  String get title => 'Rent';

  @override
  Future<void> onTapped() => onCategoryTapped();
}

abstract class CompoundUnitCategory extends UnitCategory {
  CompoundUnitCategory({required this.onCategoryTapped});
  Future<void> Function() onCategoryTapped;

  @override
  String get type => 'Compound';
  @override
  IconData get icon => OsolIcon.home_3;

  @override
  bool get isSelected => _isSelected;

  @override
  String get title => 'Compound';

  @override
  Future<void> onTapped() => onCategoryTapped();
}

abstract class EstateUnitCategory extends UnitCategory {
  EstateUnitCategory({required this.onCategoryTapped});
  Future<void> Function() onCategoryTapped;

  @override
  String get type => 'Estate';
  @override
  IconData get icon => OsolIcon.estate;

  @override
  bool get isSelected => _isSelected;

  @override
  String get title => 'Estate';

  @override
  Future<void> onTapped() => onCategoryTapped();
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './filter_states.dart';

//Bloc builder and bloc consumer methods
typedef FilterBlocBuilder = BlocBuilder<FilterCubit, FilterStates>;
typedef FilterBlocConsumer = BlocConsumer<FilterCubit, FilterStates>;

//
class FilterCubit extends Cubit<FilterStates> {
  FilterCubit() : super(IntitalFilterState());
  static FilterCubit instance(BuildContext context) =>
      BlocProvider.of<FilterCubit>(context);

  FilterType filterType = FilterType();
  PropertyTypeFilter propertyTypeFilter = PropertyTypeFilter();
  RequiredFieldsFilter requiredFieldsFilter = RequiredFieldsFilter();
  PaymentGatewayFilter paymentGatewayFilter = PaymentGatewayFilter();
  AdvisorFilter advisorFilter = AdvisorFilter();
  FinishedTypeFilter finishedTypeFilter = FinishedTypeFilter();

  double minPriceSlider = 0;
  double maxPriceSlider = 1e6;

  double startFilterPrice = 0;
  double endFilterPrice = 1e6;

  void changeFilterType(int index) {
    filterType.changeSelected(index);
    emit(ChangeFilterIndex());
  }

  void changePropertyIndex(int index) {
    propertyTypeFilter.changeSelected(index);
    emit(ChangeFilterIndex());
  }

  void changeRequiredFieldsIndex(int index) {
    requiredFieldsFilter.changeSelected(index);
    emit(ChangeFilterIndex());
  }

  void changePaymentGatwayIndex(int index) {
    paymentGatewayFilter.changeSelected(index);
    emit(ChangeFilterIndex());
  }

  void changeFinishedTypeIndex(int index) {
    finishedTypeFilter.changeSelected(index);
    emit(ChangeFilterIndex());
  }

  void changeAdvisorIndex(int index) {
    advisorFilter.changeSelected(index);
    emit(ChangeFilterIndex());
  }

  void changePriceRange(RangeValues range) {
    startFilterPrice = range.start;
    endFilterPrice = range.end;
    emit(ChangeFilterPrice());
  }

  void resetFilters() {
    filterType.reset();
    propertyTypeFilter.reset();
    requiredFieldsFilter.reset();
    paymentGatewayFilter.reset();
    finishedTypeFilter.reset();
    advisorFilter.reset();

    startFilterPrice = minPriceSlider;
    endFilterPrice = maxPriceSlider;

    emit(ResetFilters());
  }

  FilterResults get getFilterResults {
    return FilterResults(
      filterType: filterType.getSelectedItem,
      propertyType: propertyTypeFilter.getSelectedItem,
      requiredFields: requiredFieldsFilter.getSelectedItem,
      payment: paymentGatewayFilter.getSelectedItem,
      finishedType: finishedTypeFilter.getSelectedItem,
      advertisor: advisorFilter.getSelectedItem,
      startPrice: startFilterPrice,
      endPrice: endFilterPrice,
    );
  }
}

class FilterResults {
  final String filterType;
  final String propertyType;
  final String requiredFields;
  final String payment;
  final String finishedType;
  final String advertisor;
  final double startPrice;
  final double endPrice;

  FilterResults(
      {required this.filterType,
      required this.propertyType,
      required this.requiredFields,
      required this.payment,
      required this.finishedType,
      required this.advertisor,
      required this.startPrice,
      required this.endPrice});
  Map<String, dynamic> toMap() {
    return {
      "purpose": filterType,
      "type": propertyType,
      "required_fields": requiredFields,
      "finished_type": finishedType,
      "price_from": startPrice,
      "price_to": endPrice,
    };
  }
}

abstract class _FilterContentAbstract {
  _FilterContentAbstract({required this.list});
  List<String>? list;
  int selectedIndex = 0;
  String get getSelectedItem =>
      (list?[selectedIndex] ?? '') == 'Any' ? '' : list![selectedIndex];
  void changeSelected(int index) => selectedIndex = index;
  void reset() => selectedIndex = 0;
}

class PropertyTypeFilter extends _FilterContentAbstract {
  PropertyTypeFilter()
      : super(list: [
          "Any",
          "Apartment",
          "Duplex",
          "Office",
          "Store",
          "Studio",
          "Town House",
          "Twin House",
          "Penthouse",
          "Villa",
        ]);
}

class FinishedTypeFilter extends _FilterContentAbstract {
  FinishedTypeFilter()
      : super(list: [
          "Any",
          "without",
          "Half",
          "Full",
          "lux",
          "Super Lux",
          "Ultra Luxe",
          "Deluxe",
          "Super Deluxe"
        ]);
}

class RequiredFieldsFilter extends _FilterContentAbstract {
  RequiredFieldsFilter()
      : super(list: [
          "Any",
          "Vacation",
          "medical",
          "commercial",
          "Residential",
        ]);
}

class PaymentGatewayFilter extends _FilterContentAbstract {
  PaymentGatewayFilter()
      : super(list: [
          "Any",
          "Cash",
          "Installment",
        ]);
}

class AdvisorFilter extends _FilterContentAbstract {
  AdvisorFilter()
      : super(list: [
          "Any",
          "Owner",
          "Company",
        ]);
}

class FilterType extends _FilterContentAbstract {
  FilterType()
      : super(list: [
          'Any',
          'Sale',
          'Rent',
        ]);
}

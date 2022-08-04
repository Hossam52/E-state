part of 'unit_cubit.dart';

@immutable
abstract class UnitState {}

class ChangeImageUnitState extends UnitState {}

class ChangeImageFileUnitState extends UnitState {}

class UnitInitial extends UnitState {}

class ChangeDropDownPurposeUnitState extends UnitState {}

class ChangeDropDownPaymentMethodUnitState extends UnitState {}

class ChangeDropDownDescripUnitState extends UnitState {}

class ChangeDropDownStyleTypeUnitState extends UnitState {}

class ChangeDropDownViewUnitState extends UnitState {}

class ChangeDropDownAdsTypeUnitState extends UnitState {}

class ChangeDropDownFinishTypeUnitState extends UnitState {}

class ChangeDropDownRequiredFieldUnitState extends UnitState {}

class ChangeAvailableState extends UnitState {}

///Add Unit
class LoadingAddUnitState extends UnitState {}

class ErrorDataStauts extends UnitState {}

class ErrorAddUnit extends UnitState {}

class SuccesAddingDataState extends UnitState {}

class ChangeCurrentPageInUnit extends UnitState {}

class LoadingGetFeaturesData extends UnitState {}

class SuccessGetFeaturesData extends UnitState {}

class ErrorGetFeaturesData extends UnitState {}

class SuccessGetImageData extends UnitState {}

class LoadingGetPopularData extends UnitState {}

class SuccessGetPopularImageData extends UnitState {}

class ErrorGetPopularData extends UnitState {}

class SuccessGetPopularData extends UnitState {}

class changeValueOfLocation extends UnitState {}

class PlusNumberState extends UnitState {}

class MinusNumberState extends UnitState {}

class ChangeCurrentIndexOfScreenDetails extends UnitState {}

class ChangeAirCondationState extends UnitState {}

class ChangeCableTvState extends UnitState {}

class ChangeComputerState extends UnitState {}

class ChangeGaslineState extends UnitState {}

class ChangeDishWasherState extends UnitState {}

class ChangeInternetState extends UnitState {}

class ChangeHeaterState extends UnitState {}

class ChangeMicrowaveState extends UnitState {}

class ChangeBalconyState extends UnitState {}

class ChangeLiftState extends UnitState {}

class ChangeGrillState extends UnitState {}

class ChangePoolState extends UnitState {}

class ChangeParkingState extends UnitState {}

class ChangeLocationState extends UnitState {}

class ChangeDistanceOfTrain extends UnitState {}

class ChangeDistanceOfMetro extends UnitState {}

class ChangeDistanceOfBus extends UnitState {}

class ChangeDistanceOfPharmacy extends UnitState {}

class ChangeDistanceOfCoffe extends UnitState {}

class ChangeDistanceOfRest extends UnitState {}

class ChangeDistanceOfBakary extends UnitState {}

class ChangeDistanceOfBeach extends UnitState {}

class ChangeDateState extends UnitState {}

///Update Unit
class LoadingUpdateUnitState extends UnitState {}

class ErrorUpadateUnitDataStauts extends UnitState {}

class SuccesUpdateDataState extends UnitState {}

class ChangeIdOfUnit extends UnitState {}

class LoadingDeleteUnitState extends UnitState {}

class SuccessDeleteUnitState extends UnitState {}

class ErrorDeleteUnitState extends UnitState {}

//GetUnit online fetch data
class GetUnitLoadingState extends UnitState {}

class GetUnitSuccessState extends UnitState {}

class GetUnitErrorState extends UnitState {
  final String error;
  GetUnitErrorState({required this.error});
}

class RemoveUnitByIdState extends UnitState {}

//For searching
class ChangeSelectedSearchType extends UnitState {}

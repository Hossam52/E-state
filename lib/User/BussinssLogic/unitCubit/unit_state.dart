part of 'unit_cubit.dart';

@immutable
abstract class UnitClientState {}

class UnitInitial extends UnitClientState {}

class GetUnitIdState extends UnitClientState {}

class LoadingGetUnitById extends UnitClientState {}

class SuccessGetUnitById extends UnitClientState {}

class ErrorGetUnitById extends UnitClientState {}

class LoadingGetFirstUnitById extends UnitClientState {}

class SuccessGetFirstUnitById extends UnitClientState {}

class ErrorGetFirstUnitById extends UnitClientState {}

class LoadingGetSecondUnitById extends UnitClientState {}

class SuccessGetSecondUnitById extends UnitClientState {}

class ErrorGetSecondUnitById extends UnitClientState {}

class LoadingGetAllReviewState extends UnitClientState {}

class ChangeIdOfPage extends UnitClientState{}
class ChangeZeroIdOfPage extends UnitClientState{}

class SuccessGetAllReviewState extends UnitClientState {}

class ErrorGetAllReviewState extends UnitClientState {}

class LoadingAddReviewState extends UnitClientState {}

class SuccessAddReviewState extends UnitClientState {}

class ErrorAddReviewState extends UnitClientState {}

class changeInCompareList extends UnitClientState {}

class ClearCompareList extends UnitClientState {}

class RemoveIndexFromCompareList extends UnitClientState {}

class LoadingGetAllUnitClientDetails extends UnitClientState {}

class SuccessGetAllUnitClientDetails extends UnitClientState {}

class ErrorGetUnitClientDetails extends UnitClientState {}

class ChangeIndexInFilter extends UnitClientState {}

class ChangeIndexInFilterFinishType extends UnitClientState {}

class ChangeIndexInFilterRequiredField extends UnitClientState {}

class ChangeIndexInAdvistor extends UnitClientState {}

class ChangePropTypeState extends UnitClientState {}

class ChangeValueOfSlider extends UnitClientState {}

class ChangeTypeOfFilter extends UnitClientState {}

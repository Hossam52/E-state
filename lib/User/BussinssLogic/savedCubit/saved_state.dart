part of 'saved_cubit.dart';

@immutable
abstract class SavedState {}

class SavedInitial extends SavedState {}

class LoadingSavedData extends SavedState {}

class SuccessSavedData extends SavedState {}

class ChangeIconsSavedState extends SavedState {}

class LoadingGetSavedData extends SavedState {}

class SuccessGetSavedData extends SavedState {}

class ErrorGetSavedData extends SavedState {}

class ChangeIndexInFilter extends SavedState {}

class ChangeIndexInFilterFinishType extends SavedState {}

class ChangeIndexInAdvistor extends SavedState {}

class ChangeIndexInFilterRequiredField extends SavedState {}

class ChangePropTypeState extends SavedState {}

class ChangeValueOfSlider extends SavedState {}

class ChangeTypeOfFilter extends SavedState {}

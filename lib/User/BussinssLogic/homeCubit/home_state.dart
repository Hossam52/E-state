part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeIndexBody extends HomeState {}

class openLogInScreenState extends HomeState {}

class ChangeDrawerState extends HomeState {}

class ChangeColorSave extends HomeState {}

class ChangeLabelIndex extends HomeState {}

class ChangeIndexOfBottomSheet extends HomeState {}

class ChangeIconsCompanyState extends HomeState {}

class ChangeIconsSavedState extends HomeState {}

class onMapCreated extends HomeState {}

class AddMarker extends HomeState {}

class ChangeIndexInFilter extends HomeState {}

class ChangeIndexInFilterFinishType extends HomeState {}

class ChangeIndexInFilterRequiredField extends HomeState {}

class ChangeIndexInAdvistor extends HomeState {}

class ChangePropTypeState extends HomeState {}

class ChangeValueOfSlider extends HomeState {}

class ChangeValueOfSliderEnd extends HomeState {}

class ChangeTypeOfFilter extends HomeState {}

class ChangeHomeOnBoard extends HomeState {}

///get data of banner
class LoadingGetBannerOfHomeState extends HomeState {}

class GetMyToken extends HomeState {}

class SuccesGetDataOfBannerState extends HomeState {}

class ErrorDrtBannerClient extends HomeState {}

///get data of feature
class LoadingGetFeatureState extends HomeState {}

class SavedIconColorChangeState extends HomeState {}

class SuccesGetFeatureState extends HomeState {}

class SuccessGetFeatureImage extends HomeState {}

class ErrorGetFeatureState extends HomeState {}

///get data of popular
class LoadingGetPopularState extends HomeState {}

class SuccesGetPopularState extends HomeState {}

class SuccessGetPopularImage extends HomeState {}

class ErrorGetPopularState extends HomeState {}

/// get profie data
class LoadingGetProfileStatus extends HomeState {}

class SuccessGetProfileStatus extends HomeState {}

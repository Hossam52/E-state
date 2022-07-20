part of 'banners_cubit.dart';

@immutable
abstract class BannersState {}

class BannersInitial extends BannersState {}

class LoadingGetAllBannersCompany extends BannersState {}

class ErrorGetAllBannersCompany extends BannersState {}

class SuccessGetAllBannersCompany extends BannersState {}

class ChangeImageState extends BannersState {}

class ChangeDateState extends BannersState {}

class LoadingAddBannerState extends BannersState {}

class SuccessAddBannerState extends BannersState {}

class ErrorAddDataOfBannerState extends BannersState {}

class ErrorPushBannerState extends BannersState {}
class changeOverLaySheetState extends BannersState{}
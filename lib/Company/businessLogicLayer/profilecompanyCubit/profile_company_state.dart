part of 'profile_company_cubit.dart';

@immutable
abstract class ProfileCompanyState {}

class ProfileCompanyInitial extends ProfileCompanyState {}

class LoadingpdateCompanyProfile extends ProfileCompanyState {}

class SuccessUpdateCompanyProfile extends ProfileCompanyState {}

class LoadingGetProfileDataStatus extends ProfileCompanyState {}

class SuccessGetProfileDataStatus extends ProfileCompanyState {}

class ChangeImageUpdateState extends ProfileCompanyState {}

class ErrorUpdateData extends ProfileCompanyState {}

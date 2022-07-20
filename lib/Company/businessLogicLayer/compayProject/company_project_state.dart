part of 'company_project_cubit.dart';

@immutable
abstract class CompanyProjectState {}

class CompanyProjectInitial extends CompanyProjectState {}

class LoadingGetAllProjects extends CompanyProjectState {}

class SuccessGetAllProjects extends CompanyProjectState {}

class ErrorGettheProjectsOfCompany extends CompanyProjectState {}

class ChangeImageState extends CompanyProjectState {}

class ChangeDateState extends CompanyProjectState {}

class LoadingUpdateProjectstate extends CompanyProjectState {}

class SuccessUpdateProjectDataState extends CompanyProjectState {}

class ErrorUpdateDate extends CompanyProjectState {}

class ChangeIdState extends CompanyProjectState {}

class LoadingDeleteProject extends CompanyProjectState {}

class SuccessDeleteProject extends CompanyProjectState {}

class ErrorDeleteProject extends CompanyProjectState {}

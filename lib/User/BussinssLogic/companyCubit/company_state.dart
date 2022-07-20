part of 'company_cubit.dart';

@immutable
abstract class CompanyState {}

class CompanyInitial extends CompanyState {}

class LoadingGetDataAllCompany extends CompanyState {}

class SuccessGetDataAllCompany extends CompanyState {}

class ErrorGetDataAllCompany extends CompanyState {}

class ChangeIconsCompanyState extends CompanyState {}

class ChangeNewId extends CompanyState {}

class ChangeNextId extends CompanyState {}


class LoadingGetDetectedCompany extends CompanyState {}

class SuccessGetDetectedCompany extends CompanyState {}

class ErrorGetDetectedCompany extends CompanyState {}

class LoadingAddedReview extends CompanyState {}

class ErrorAddedReview extends CompanyState {}

class SuccessfulAddedReview extends CompanyState {}

class LoadingGetAllReviews extends CompanyState {}

class ErrorGetAllReviews extends CompanyState {}

class SuccessfulGetAllReviews extends CompanyState {}

class ChangeZeroIdOfPage extends CompanyState {}

class ChangeIdOfPage extends CompanyState {}

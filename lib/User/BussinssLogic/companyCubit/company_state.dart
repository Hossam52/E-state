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

//CompanyProjects online fetch data
class CompanyProjectsLoadingState extends CompanyState {}

class CompanyProjectsSuccessState extends CompanyState {}

class CompanyProjectsErrorState extends CompanyState {
  final String error;
  CompanyProjectsErrorState({required this.error});
}

//CompanyListing online fetch data
class CompanyListingLoadingState extends CompanyState {}

class CompanyListingSuccessState extends CompanyState {}

class CompanyListingErrorState extends CompanyState {
  final String error;
  CompanyListingErrorState({required this.error});
}

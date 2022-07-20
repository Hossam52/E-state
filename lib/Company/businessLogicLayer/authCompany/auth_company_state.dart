part of 'auth_company_cubit.dart';

@immutable
abstract class AuthCompanyState {}

class AuthCompanyInitial extends AuthCompanyState {}

class LoadingRegisterCompanyState extends AuthCompanyState {}

class SuccessRegisterCompanyState extends AuthCompanyState {}

class ErrorDataRegisterCompanyState extends AuthCompanyState {}

class ErrorRegisterCompanyState extends AuthCompanyState {
  ErrPrint(err, errType) {
    print("$errType:${err.toString()}");
  }
}

class ChangeImageState extends AuthCompanyState{}

class ChangeValueOfDropDown extends AuthCompanyState {}

///Get Country

class LoadingGetCountry extends AuthCompanyState {}

class SuccessGetCountry extends AuthCompanyState {}

class ErrorGetCountry extends AuthCompanyState {
  ErrPrint(err, errType) {
    print("$errType:${err.toString()}");
  }
}

class GetCityData extends AuthCompanyState {}

class ChangeCity extends AuthCompanyState {}

class ChangeGenderValue extends AuthCompanyState {}

class ChangeDropDownCountry extends AuthCompanyState {}

///Forget password
class LoadingForgetPass extends AuthCompanyState {}

class SuccessForgetPass extends AuthCompanyState {}

///OTP
class changeOTPErorState extends AuthCompanyState {}

class changeValueOfOTPForgetPasswordState extends AuthCompanyState {}

class LoadingsendOTPCompany extends AuthCompanyState {}

class ErrorInCodeOTP extends AuthCompanyState {}

class SuccessSendOTP extends AuthCompanyState {}

class ErrorSendOTP extends AuthCompanyState {}

class changeValueOfOTPState extends AuthCompanyState {}

class changeOTPErrorState extends AuthCompanyState {}

class LoadingLogOutCompany extends AuthCompanyState {}

class SuccessLogOutCompany extends AuthCompanyState {}

class ErrorInputDataLogOutCompany extends AuthCompanyState {}

class ErrorLogOutCompany extends AuthCompanyState {}

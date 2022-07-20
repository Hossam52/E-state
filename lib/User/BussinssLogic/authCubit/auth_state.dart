part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

///Register
class LoadingRegisterUserState extends AuthState {}

class ErrorDataRegisterUserState extends AuthState {}

class SuccessRegisterUserState extends AuthState {}

class ChangeInSuffixIcon extends AuthState {}

class ErrorRegisterUserState extends AuthState {
  ErrPrint(err, errType) {
    print("$errType:${err.toString()}");
  }
}

class ChangeValueOfDropDown extends AuthState {}

///Get Country

class LoadingGetCountry extends AuthState {}

class SuccessGetCountry extends AuthState {}

class ErrorGetCountry extends AuthState {
  ErrPrint(err, errType) {
    print("$errType:${err.toString()}");
  }
}

class GetCityData extends AuthState {}

class ChangeCity extends AuthState {}

class ChangeGenderValue extends AuthState {}

class ChangeDropDownCountry extends AuthState {}

///LogIn
class SuccessSignIn extends AuthState {}

class ErrorInInputDataLogIn extends AuthState {}

class ErrorVerifyBeforeSignIn extends AuthState {}

class LoadingSignIn extends AuthState {}

class ErrorSignIn extends AuthState {}

class ErrorSignInMain extends AuthState {}

/// LogOut
class LoadingLogOut extends AuthState {}

class SuccessLogOut extends AuthState {}

class ErrorInputDataLogOut extends AuthState {}

class ErrorLogOut extends AuthState {}

///OTP
class LoadingsendOTP extends AuthState {}

class ErrorInCodeOTP extends AuthState {}

class SuccessSendOTP extends AuthState {}

class ErrorSendOTP extends AuthState {}

class changeValueOfOTPState extends AuthState {}

class changeOTPErrorState extends AuthState {}

/// First Step In Forget Password
class LoadingForgetPass extends AuthState {}

class SuccessForgetPass extends AuthState {}

class ErrorInputForgetPass extends AuthState {}

class ErrorForgetPass extends AuthState {}

/// OTP Forget Password

class ErorSendOTP extends AuthState {}

class changeValueOfOTPForgetPasswordState extends AuthState {}

class changeOTPErorState extends AuthState {}

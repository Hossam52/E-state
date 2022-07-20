part of 'common_cubit.dart';

@immutable
abstract class CommonState {}

class CommonInitial extends CommonState {}


///Get Country

class LoadingGetCountry extends CommonState {}

class SuccessGetCountry extends CommonState {}

class ErrorGetCountry extends CommonState {
  ErrPrint(err, errType) {
    print("$errType:${err.toString()}");
  }
}

class GetCityData extends CommonState {}

class ChangeCity extends CommonState {}

class GetAreasData extends CommonState {}

class ChangeAreas extends CommonState {}
class ChangeAreasId extends CommonState {}

class ChangeGenderValue extends CommonState {}

class ChangeDropDownCountry extends CommonState {}

class changeOTPErrorState extends CommonState {}

class changeValueOfOTPState extends CommonState{}

class changeOTPErorState extends CommonState{}

class changeValueOfOTPForgetPasswordState extends CommonState {}
part of 'popular_cubit.dart';

@immutable
abstract class PopularState {}

class PopularInitial extends PopularState {}

class ChangeIndexBottomSheet extends PopularState {}

class changeIndexOfTapped extends PopularState {}

class changeStringOfTapped extends PopularState {}

class LoadingGetPopularListData extends PopularState{}
class SuccessGetPopularListData extends PopularState{}

class ErrorGetListOfData extends PopularState{}
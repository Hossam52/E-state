import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(AppSettingInitial());
  static AppSettingCubit get(context)=>BlocProvider.of(context);
  ///change mode
bool isDark=false;
chandeDarkMode(bool value){
  isDark=value;
  emit(ChangeDarkModeState());
}
}

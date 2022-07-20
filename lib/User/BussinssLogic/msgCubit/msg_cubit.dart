import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'msg_state.dart';

class MsgCubit extends Cubit<MsgState> {
  MsgCubit() : super(MsgInitial());
}

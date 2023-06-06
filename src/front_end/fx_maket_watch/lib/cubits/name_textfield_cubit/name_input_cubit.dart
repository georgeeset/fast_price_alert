import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'name_input_state.dart';

class NameInputCubit extends Cubit<NameInputState> {
  NameInputCubit() : super(NameInputInitial());
}

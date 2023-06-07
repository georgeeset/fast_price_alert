import 'package:bloc/bloc.dart';

class InterestSelectCubit extends Cubit<List<String>> {
  InterestSelectCubit() : super([]);

  addSelected(item) {
    state.add(item);
    emit(state);
  }

  removeSelected(item) {
    state.remove(item);
    emit(state);
  }
}

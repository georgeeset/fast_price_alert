import 'package:bloc/bloc.dart';

class InterestSelectCubit extends Cubit<List<String>> {
  InterestSelectCubit() : super([]);

  addSelected(item) {
    final List<String> newList = List.from(state)..add(item);
    emit(newList);
  }

  removeSelected(item) {
    final List<String> newList = List.from(state)..remove(item);
    emit(newList);
  }
}

import 'package:bloc/bloc.dart';

class ActiveMenuCubit extends Cubit<int> {
  ActiveMenuCubit() : super(0);

  setActiveMenu(int number) {
    // print(number);
    int newActive = number;
    emit(newActive);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Ui/Task2/MainScreen/Cubit/MainPageCubitStates.dart';

class MainPageCubit extends Cubit<MainPageCubitStates> {
  MainPageCubit() : super(InitialState());


  void bannerFetch() {
    emit(BannersState());
  }
  void cartResult() {
    emit(CartResultState());
  }
}

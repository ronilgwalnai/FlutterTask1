import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Ui/ProductScreen/Cubit/CubitStates.dart';

import '../../ResultScreen/ResultScreen.dart';
import '../Models/productModels.dart';

class productCubit extends Cubit<CubitState> {
  productCubit() : super(InitialState());

  void setHeading(String? heading, String? subHeading) {
    emit(TextHeading(heading: heading ?? "", subHeading: subHeading ?? ""));
  }

  void nextScreenClick(BuildContext context, List<Data>? model) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: ResultScreen(
              list: model,
            ));
      }),
    );
  }
}

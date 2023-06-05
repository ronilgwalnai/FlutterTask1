import 'package:flutter/material.dart';
import 'package:task/Helpers/Constants.dart';

import '../ProductScreen/Models/productModels.dart';

class ResultScreen extends StatelessWidget {
  List<Data>? list;

  ResultScreen({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < list!.length; i++) {
      if (list![i].quantity == 0) {
        list!.removeAt(i);
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.confirmation)),
      body: ListView.builder(
          itemCount: list?.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${(index + 1)}  ${list![index].toString()}'),
            );
          }),
    );
  }
}

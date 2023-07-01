import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Helpers/Constants.dart';
import '../../../Helpers/HelperFunctions.dart';
import '../../../Network/Apis.dart';
import '../../../Network/CallApi.dart';
import '../ProductCategories/Models/CategoryData.dart';
import 'Models/CategoryModel.dart';

class ProductCategoryPage extends StatelessWidget {
  ProductCategoryPage({super.key});

  MyApiCalls categoryCall = MyApiCalls(url: Apis.getCategories);
  StreamController<List<CategoryData>> categoryController = StreamController();

  @override
  Widget build(BuildContext context) {
    fetchCategoryList();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(55, 143, 167, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  onBackPress(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            const Text(
              Strings.categories,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromRGBO(55, 143, 167, 1),
        ),
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: StreamBuilder<List<CategoryData>>(
              stream: categoryController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data != null) {
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, mainAxisExtent: 130),
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return gridItem(item.productCategoryName!,
                            item.productCategoryImage!);
                      });
                } else {
                  return const Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  );
                }
              }),
        )
      ]),
    );
  }

  void fetchCategoryList() {
    HashMap<String, String> hashMap = HashMap();
    hashMap['user_id'] = '23';
    hashMap['user_token'] = 'UNuoFzzibgcN6LmVk2xU';
    categoryCall.postRequest(hashMap, (response) {
      var jsonData = json.decode(response);
      var model = CategoryModel.fromJson(jsonData);
      if (model.status == ResponseTypes.valid) {
        categoryController.add(model.data ?? []);
      }
    }, (error) {});
  }
}

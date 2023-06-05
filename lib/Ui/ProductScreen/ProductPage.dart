import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Ui/ProductScreen/Cubit/CubitStates.dart';
import 'package:task/Ui/ProductScreen/Models/productModels.dart';

import '../../Helpers/Constants.dart';
import '../../Network/Apis.dart';
import '../../Network/CallApi.dart';
import 'Cubit/productCubit.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  MyApiCalls productDataCall = MyApiCalls(url: Apis.availableProducts);
  num amount = 0;
  StreamController dataController = StreamController();
  StreamController<num> bottomAmount = StreamController();

  @override
  Widget build(BuildContext context) {
    _getList(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 235, 210, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(221, 235, 210, 1.0),
        title: SizedBox(
          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios),
                    )),
                const Expanded(
                    flex: 10,
                    child: SizedBox(
                        height: 35,
                        child: Image(image: AssetImage(ImagesPath.logo)))),
                const Expanded(
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Image(image: AssetImage(ImagesPath.help))))),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Text('Help'),
                )
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: BlocBuilder<productCubit, CubitState>(
                  builder: (context, state) {
                return state is TextHeading
                    ? Text(
                        state.heading,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )
                    : const SizedBox.shrink();
              }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: BlocBuilder<productCubit, CubitState>(
                  builder: (context, state) {
                return state is TextHeading
                    ? Text(
                        state.subHeading,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.orange),
                      )
                    : const SizedBox.shrink();
              }),

              // child: Text(
              //   Strings.note,
              //   style: TextStyle(fontSize: 15, color: Colors.orange),
              // ),
            ),
            StreamBuilder(
                stream: dataController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                            itemCount: snapshot.data!.data!.length,
                            // shrinkWrap: true, // Ensure inner ListView scrolls within the ListTile
                            // physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _foodLayout(snapshot.data!.data![index]);
                            }),
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator(),);
                }),
            StreamBuilder<num>(
                stream: bottomAmount.stream,
                builder: (context, snapshot) {
                  return AnimatedContainer(
                    color: Colors.deepOrange,
                    duration: const Duration(seconds: 1),
                    height: snapshot.hasData&&snapshot.data! > 0 ? 60 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15),
                          child: Text(
                            '₹$amount',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15),
                          child: ElevatedButton(
                              onPressed: () {
                                context.read<productCubit>().nextScreenClick(context,model.data);

                              },
                              child: const Text(
                                Strings.placeMyOrder,
                                style: TextStyle(color: Colors.deepOrange),
                              )),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  _foodLayout(Data model) {
    StreamController<bool> addOnsLayoutController = StreamController();
    StreamController<int> quantityController = StreamController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        // adjust the radius as per your preference

                        child: Container(
                          color: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                              model.productImage!,
                              width: 120,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.productName!,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        Text(
                          "₹${model.price!}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          model.productDescription!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (model.quantity > 0) {
                                    model.quantity--;
                                    quantityController.add(model.quantity);
                                    if (model.quantity == 0) {
                                      addOnsLayoutController.add(false);
                                      for (int i = 0;
                                          i < model.addOns!.length;
                                          i++) {
                                        var temp = model.addOns![i];
                                        if (temp.quantity > 0) {
                                          amount = amount -
                                              (temp.quantity *
                                                  int.parse(
                                                      temp.price.toString()));
                                          temp.quantity = 0;
                                        }
                                      }
                                    }
                                    amount = amount -
                                        int.parse(model.price.toString());
                                    bottomAmount.add(amount);
                                  }
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 3),
                                  child: StreamBuilder<int>(
                                      stream: quantityController.stream,
                                      builder: (context, snapshot) {
                                        return Text(
                                          model.quantity.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        );
                                      }),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  model.quantity++;
                                  if (model.quantity == 1) {
                                    addOnsLayoutController.add(true);
                                  }
                                  amount = amount +
                                      int.parse(model.price.toString());
                                  bottomAmount.add(amount);
                                  quantityController.add(model.quantity);
                                },
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<bool>(
                stream: addOnsLayoutController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Text(
                                  Strings.addOns,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  // Ensure inner ListView scrolls within the ListTile
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: model.addOns?.length ?? 0,
                                  itemBuilder: (context, position) {
                                    return  _addonsLayout(
                                        model.addOns![position]);
                                  }),
                            ],
                          )
                        : const SizedBox.shrink();
                  } else {
                    return const SizedBox(
                      height: 10,
                    );
                  }
                }),
            // _addonsLayout(model.addOns![0]),
          ],
        ),
      ),
    );
  }

  _addonsLayout(AddOns addOn) {
    StreamController<int> quantityController = StreamController();
    StreamController checkboxController = StreamController();
    bool checked = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              StreamBuilder(
                  stream: checkboxController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data is bool) {
                      checked = snapshot.data;
                    }
                    return Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Checkbox(
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors
                                  .green; // return your desired color for selected state
                            }
                            return Colors
                                .grey; // return the default color for other states
                          }),
                          value: checked,
                          onChanged: (value) {
                            if (value == true && addOn.quantity == 0) {
                              addOn.quantity++;
                              amount =
                                  amount + int.parse(addOn.price.toString());

                              quantityController.add(addOn.quantity);
                            } else if (value == false && addOn.quantity > 0) {
                              amount = amount -
                                  addOn.quantity *
                                      int.parse(addOn.price.toString());
                              addOn.quantity = 0;
                              quantityController.add(addOn.quantity);
                            }
                            bottomAmount.add(amount);
                            checkboxController.add(value);
                          }),
                    );
                  }),
              Text(
                addOn.productName!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (addOn.quantity > 0) {
                        addOn.quantity--;
                        quantityController.add(addOn.quantity);
                        if (checked && addOn.quantity == 0) {
                          checked = false;
                          checkboxController.add(checked);
                        }
                        amount = amount - int.parse(addOn.price.toString());
                        bottomAmount.add(amount);
                      }
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: StreamBuilder<int>(
                          stream: quantityController.stream,
                          builder: (context, snapshot) {
                            return Text(
                              addOn.quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            );
                          }),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addOn.quantity++;
                      quantityController.add(addOn.quantity);
                      if (!checked) {
                        checked = true;
                        checkboxController.add(checked);
                      }
                      amount = amount + int.parse(addOn.price.toString());
                      bottomAmount.add(amount);
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "₹${addOn.price!}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  late ProductModel model;

  _getList(BuildContext context) async {
    HashMap parms = HashMap();
    parms[Parms.pincode] = '530016';
    parms[Parms.subscription_product_id] = '9';
    productDataCall.postRequest(parms, (response) {
      var jsonData = json.decode(response);
       model = ProductModel.fromJson(jsonData);
      context.read<productCubit>().setHeading(model.heading, model.subheading);
      dataController.add(model);
    }, (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
      ));
    });
  }
}

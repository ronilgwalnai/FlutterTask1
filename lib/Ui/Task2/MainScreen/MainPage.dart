import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Helpers/Constants.dart';
import 'package:task/Helpers/HelperFunctions.dart';
import 'package:task/Network/CallApi.dart';
import 'package:task/Routes/RoutesPath.dart';
import 'package:task/Ui/Task2/MainScreen/Cubit/MainPageCubit.dart';
import 'package:task/Ui/Task2/MainScreen/Models/Data.dart';
import 'package:task/Ui/Task2/ProductCategories/Models/CategoryData.dart';

import '../../../Network/Apis.dart';
import '../OtpVerificationScreen/Models/InfoModel.dart';
import '../ProductCategories/Models/CategoryModel.dart';
import 'Models/BannerModel.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  MyApiCalls bannerCall =MyApiCalls(url: Apis.banners);
  List<InfoModel> infoModel = [];
  late MainPageCubit cubit;
  StreamController<List<Data>> bannerController = StreamController();
  MyApiCalls categoryCall = MyApiCalls(url: Apis.getCategories);
  StreamController<List<CategoryData>> categoryController = StreamController();

  @override
  Widget build(BuildContext context) {
    infoModel.add(InfoModel('CO2 Averted', '4387.84'));
    infoModel.add(InfoModel('Trees Saved', '12'));
    infoModel.add(InfoModel('Available Points(1Point=1Rs)', '1691'));
    infoModel.add(InfoModel('Lifetime Kgs', '828.000'));
    cubit = context.read<MainPageCubit>();
    fetchBanners();
    fetchCategoryList();
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigation(),
      appBar: AppBar(
          scrolledUnderElevation: 0,
          title: InkWell(
        onTap: () {
          cubit.bannerFetch();
        },
        child: const Text(
          'Welcome,Ronil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shadowColor: Colors.grey,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: 'Product Search',
                      hintStyle: TextStyle(
                        // color: Color.fromRGBO(255, 255, 255, 0.48627450980392156),
                        color: Colors.grey,
                      )),
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
            myAddress(
                'Flat No. 201 Guru kripa Apartments Jagatpura near Akshyapatra Temple Behind Gyanvear University'),
            InkWell(
              onTap: () {
                cubit.cartResult();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    'Referal Code :GFDEDF2D'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 119, 151, 1),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 80,
                      crossAxisCount: 2,
                      // maxCrossAxisExtent: 120,
                    ),
                    itemBuilder: (context, index) {
                      return amountLayout(
                          infoModel[index].title, infoModel[index].amount);
                    }),
              ),
            ),
            StreamBuilder<List<Data>>(
                stream: bannerController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return SizedBox(
                      height: 200,
                      child: PageView.builder(
                          reverse: false,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          onPageChanged: (pos) {},
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data![index].bannerImageUrl!),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
            StreamBuilder<List<CategoryData>>(
                stream: categoryController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.symmetric( vertical: 10,horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              InkWell(onTap: (){
                                startNewPage(context, RoutesPath.category,finishCurrent: false);
                              },
                                child: const Text(
                                  'View all',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: (snapshot.data!.length < 4)
                                    ? snapshot.data?.length
                                    : 4,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  mainAxisExtent: 130,
                                  crossAxisCount: 3,
                                  // maxCrossAxisExtent: 120,
                                ),
                                itemBuilder: (context, index) {
                                  var item = snapshot.data![index];
                                  return gridItem(item.productCategoryName!,
                                      item.productCategoryImage!);
                                }))
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
          ],
        ),
      ),
    );
  }

  myAddress(String address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: RichText(
        text: TextSpan(
          children: <InlineSpan>[
            const WidgetSpan(
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.none),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 5),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 14,
                ),
              ),
            ),
            TextSpan(
                style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.none,
                    fontSize: 14),
                text: address),
          ],
        ),
      ),
    );
  }

  Widget amountLayout(String title, String amount) {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(55, 143, 167, 1),
        borderRadius: BorderRadius.all(
            Radius.circular(20)), /*  shape: BoxShape.rectangle*/
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 20)),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    amount,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void fetchBanners() {
    bannerCall.getRequest(HashMap(), (response) {
      var jsonData = json.decode(response);
      var model = BannerModel.fromJson(jsonData);
      if (model.status == ResponseTypes.valid) {
        bannerController.add(model.data ?? []);
      }
    }, (error) {});
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

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      // selectedItemColor: Colors.orange,
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 6) {
          showLogoutDialogue(context);
        }
        if(index==5){
          startNewPage(context, RoutesPath.category,finishCurrent: false);
        }
      },
      items: [
        buildBottomNavigationBarItem(Icons.home, 0),
        buildBottomNavigationBarItem(Icons.leave_bags_at_home, 1),
        buildBottomNavigationBarItem(Icons.calendar_month_rounded, 2),
        buildBottomNavigationBarItem(Icons.headset_mic_outlined, 3),
        buildBottomNavigationBarItem(Icons.card_giftcard_outlined, 4),
        buildBottomNavigationBarItem(Icons.shopping_bag_rounded, 5),
        buildBottomNavigationBarItem(Icons.menu, 6),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selectedIndex == index
                  ? const Color.fromRGBO(1, 142, 153, 1)
                  : Colors.transparent,
            ),
          ),
          Icon(icon),
        ],
      ),
      label: '', // Empty label to hide text
    );
  }

  void showLogoutDialogue(BuildContext context) {
    AlertDialog? dialogue = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Button border radius
      ),
      title: const Text(Strings.logout),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(Strings.logoutTxt),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      logoutFromDatabase();
                      startNewPage(context, RoutesPath.login, finishAll: true);
                    },
                    child: const Text(Strings.yes)),
                TextButton(
                    onPressed: () {
                      // dismiss the dialogue
                      Navigator.pop(context);
                    },
                    child: const Text(Strings.cancel)),
              ],
            )
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: dialogue!);
      },
    );
    // startFirstPage(dialogue);
  }

  Future<void> logoutFromDatabase() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool(SavedValues.login, false);
  }
}

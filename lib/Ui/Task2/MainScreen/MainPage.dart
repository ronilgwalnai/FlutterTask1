import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Ui/Task2/MainScreen/Cubit/MainPageCubit.dart';
import 'package:task/Ui/Task2/MainScreen/Cubit/MainPageCubitStates.dart';

class MainPage extends StatelessWidget {
   MainPage({super.key});
  late MainPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.read<MainPageCubit>();


    return Scaffold(
      bottomNavigationBar: const MyBottomNavigation(),
      appBar: AppBar(
          title: InkWell(
        onTap: () {
          cubit.bannerFetch();

        },
        child: const Text(
          'Welcome,Ronil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
      body: Column(
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
          InkWell(onTap: (){
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 80,
                    crossAxisCount: 2,
                    // maxCrossAxisExtent: 120,
                  ),
                  itemBuilder: (index, ddd) {
                    return gridItem("Title", "2000.8");
                  }),
            ),
          ),
          BlocBuilder<MainPageCubit, MainPageCubitStates>(
              builder: (context, state) {
            if (state is BannersState) {
              return SizedBox(
                height: 200,
                child: PageView.builder(
                    reverse: false,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 4,
                    onPageChanged: (pos) {},
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                    }),
              );
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
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

  Widget gridItem(String title, String amount) {
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
}

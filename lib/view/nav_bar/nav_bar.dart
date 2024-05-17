import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/history_screen/history_screen.dart';

import '../../controllers/home_controller.dart';
import '../basket_screen/basket_screen.dart';
import '../home_secreen/home_screen.dart';
import '../profile_screen/profile_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  late StreamSubscription<ConnectivityResult> subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && !isAlertSet) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      },
    );
  }


  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItem = const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: home),
      BottomNavigationBarItem(
          icon: Icon(Icons.access_time_outlined), label: history),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket_outlined), label: "basket"),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined), label: profile),
    ];

    var navBody = [
      const HomeScreen(),
      const HistoryScreen(),
      const BasketScreen(),
      const ProfileScreen(),


    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentNavIndex.value,
            children: navBody,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            backgroundColor: whiteColor,
            selectedItemColor: mainColor,
            selectedLabelStyle: const TextStyle(fontFamily: medium),
            type: BottomNavigationBarType.fixed,
            items: navBarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          )),
    );
  }

  showDialogBox(){
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("No Internet Connection"),
          content: const Text("Please check your internet connection"),
          actions: <Widget>[
            TextButton(
                onPressed: ()async{
                  Navigator.pop(context,"cancel");
                  setState(() {isAlertSet = false;});
                  isDeviceConnected = await InternetConnectionChecker().hasConnection;
                  if(!isDeviceConnected){
                    showDialogBox();
                    setState(() {isAlertSet = true;});
                  }
                },
                child: const Text("OK"))
          ],
        );
      }

    );
  }

}

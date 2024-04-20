import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/history_screen/history_screen.dart';

import '../../controllers/home_controller.dart';
import '../basket_screen/basket_screen.dart';
import '../home_secreen/home_screen.dart';
import '../profile_screen/profile_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

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
}

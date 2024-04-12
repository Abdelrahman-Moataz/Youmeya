import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/home_secreen/home_screen.dart';

class SthWentWrongScreen extends StatelessWidget {
  const SthWentWrongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          
          Image.asset(sthWentWrongImg),
          20.heightBox,
          
          
          const Text(
            "Oops, your connection seems off... \nKeep Calm, light a fire and click the below button",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontGrey,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          ourButton(
                    onPress: () {
                          Get.to(() => const HomeScreen());

                    },
                    color: mainColor,
                    textColor: whiteColor,
                    title: "Drive me home"),
                  
        ],
      ),
    )));
  }
}

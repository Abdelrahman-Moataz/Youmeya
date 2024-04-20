import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/splash_screen/onboarding_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(splashBg),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.2,
                width: w * 0.3,
              ),
              const Image(
                image: AssetImage(logo),
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: h * 0.2,
              ),
              ourButton(
                  onPress: () {
                    Get.to(() => const OnboardingScreen());
                  },
                  color: mainColor,
                  textColor: fontColor,
                  title: getStarted)
            ],
          ),
        ),
      ),
    );
  }
}

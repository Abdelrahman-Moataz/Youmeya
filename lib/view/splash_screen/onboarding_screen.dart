import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/consent/strings.dart';
import 'package:youmeya/view/auth_screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  var isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: h * 0.9,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            isLastPage = index == 2;
                          });
                        },
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(onboarding1),
                                    ),
                                  ),
                                ),
                              ),
                              onboardingText1.text.size(25).bold.color(fontGrey).make(),
                              5.heightBox,
                              onboText1.text.size(19).color(fontGrey).make(),
                              20.heightBox,
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(onboarding2),
                                    ),
                                  ),
                                ),
                              ),
                              onboardingText2.text.size(25).bold.color(fontGrey).make(),
                              5.heightBox,
                              onboText2.text.size(19).color(fontGrey).make(),
                              20.heightBox,
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(onboarding3),
                                    ),
                                  ),
                                ),
                              ),
                              onboardingText3.text.size(25).bold.color(fontGrey).make(),
                              5.heightBox,
                              onboText3.text.size(19).color(fontGrey).make(),
                              20.heightBox,
                            ],
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    isLastPage == true
                        ? ourButton(
                            onPress: () {
                              Get.to(() => const LogInScreen());
                            },
                            color: mainColor,
                            textColor: whiteColor,
                            title: "Finish")
                        : ourButton(
                            onPress: () {
                              controller.nextPage(
                                  duration: const Duration(microseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            color: mainColor,
                            textColor: whiteColor,
                            title: buttonText),
                    70.heightBox,
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const ExpandingDotsEffect(),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

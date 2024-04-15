import 'package:flutter/cupertino.dart';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/auth_screens/sign_up_screen.dart';
import 'package:youmeya/view/nav_bar/nav_bar.dart';
import '../../../controllers/auth_controller.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    Color facebookBtnColor = Colors.white;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Obx(
                () => SizedBox(
                  height: h * 0.89,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      5.heightBox,
                      Image.asset(
                        logo,
                        height: 79,
                        width: 68,
                      ),
                      10.heightBox,
                      login.text
                          .fontFamily(medium)
                          .center
                          .black
                          .size(24)
                          .make(),
                      20.heightBox,
                      customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController,
                      ),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          isPass: false,
                          controller: controller.passwordController),

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child:
                      //         forgetPassword.text.color(fontGrey).size(10.0).make(),
                      //   ),
                      // ),

                      15.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(mainColor),
                            )
                          : ourButton(
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => const NavBar());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                              color: mainColor,
                              textColor: whiteColor,
                              title: login),
                      15.heightBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const SignUpScreen());
                          },
                          child: createNewAccount.text
                              .size(10.0)
                              .color(fontGrey)
                              .make(),
                        ),
                      ),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Divider(
                            thickness: 2,
                            color: Colors.blue,
                          ),
                          orSignInWith.text.size(10.0).color(fontGrey).make(),
                          const Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                      30.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GoogleAuthButton(
                            onPressed: () {
                              Get.to(() => const NavBar());
                            },
                            width: w * 0.4,
                            text: "Google",
                          ),
                          FacebookAuthButton(
                            onPressed: () {},
                            buttonColor: facebookBtnColor,
                            width: w * 0.4,
                            text: "Facebook",
                          ),
                        ],
                      ),
                      // ourButton(
                      //   colour: borderColor,
                      //   onPress: () {
                      //     Get.to(()=>const NavBar());
                      //   },
                      //   color: whiteColor,
                      //   textColor: borderColor,
                      //   title: "Google",
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/auth_screens/complete_login.dart';
import '../../../controllers/auth_controller.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // @override
  // void dispose() {
  //   controller.passwordController.clear();
  //   controller.emailController.clear();
  //   controller.passwordRetypeController.clear();
  //   super.dispose();
  // }
  final _formKey = GlobalKey<FormState>(); // Add GlobalKey<FormState>
  var controller = Get.put(AuthController());

  Color facebookBtnColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.89,
                child: Form(
                  // Wrap your ListView with a Form widget
                  key: _formKey, // Provide the GlobalKey<FormState>
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      20.heightBox,
                      signup.text
                          .fontFamily(medium)
                          .center
                          .black
                          .size(18)
                          .make(),
                      20.heightBox,
                      customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      customTextField(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      customTextField(
                        hint: confirmYourPasswordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordRetypeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != controller.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      15.heightBox,
                      controller.isLoading(false)
                          ? const Padding(
                        padding: EdgeInsets.only(left: 150,right: 150),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(mainColor),
                        ),
                      )
                          :
                      ourButton(
                        title: createAccount,
                        textColor: fontColor,
                        color: mainColor,
                        onPress: () async{
                          controller.isLoading(true);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                             await controller
                                  .signupMethod(
                                context: context,
                                email: controller.emailController.text,
                                password: controller.passwordController.text,
                              )
                                  .then((value) async{
                                return await controller.storeUserData(
                                  email: controller.emailController.text,
                                  password: controller.passwordController.text,
                                );
                              }).then((value) {
                                VxToast.show(context, msg: loggedIn);
                                controller.isLoading(false);
                                controller.passwordController.clear();
                                controller.emailController.clear();
                                controller.passwordRetypeController.clear();
                                Get.offAll(() =>  const CompleteLogin(),transition: Transition.fade);
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        },
                      ),
                      15.heightBox,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const LogInScreen(),transition: Transition.fade);
                          },
                          child: alreadyHaveAnAccount.text
                              .size(14.0)
                              .color(fontGrey)
                              .make(),
                        ),
                      ),
                      20.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Divider(
                      //       thickness: 2,
                      //       color: Colors.blue,
                      //     ),
                      //     orSignInWith.text.size(10.0).color(fontGrey).make(),
                      //     const Divider(
                      //       thickness: 2,
                      //     ),
                      //   ],
                      // ),
                      // 30.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     GoogleAuthButton(
                      //       onPressed: () {},
                      //       width: w * 0.4,
                      //       text: "Google",
                      //     ),
                      //     FacebookAuthButton(
                      //       onPressed: () {},
                      //       buttonColor: facebookBtnColor,
                      //       width: w * 0.4,
                      //       text: "Facebook",
                      //     ),
                      //   ],
                      // ),
                      // ourButton(
                      //   colour: borderColor,
                      //     onPress: () {},
                      //     color: whiteColor,
                      //     textColor: borderColor,
                      //     title: "Google",
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

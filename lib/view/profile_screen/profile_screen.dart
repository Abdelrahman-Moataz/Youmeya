import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/controllers/auth_controller.dart';
import 'package:youmeya/view/auth_screens/login_screen.dart';
import 'package:youmeya/view/profile_screen/view_profile_data.dart';
import 'package:youmeya/view/profile_screen/widgets/profile_btn.dart';
import 'package:youmeya/view/saved_addresses/saved_addresses_screen.dart';

import '../../controllers/profile_controller.dart';
import '../../services/firestore_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFF9F9F9),
        body: StreamBuilder(
            stream: FireStoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(mainColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          const Text(
                            "My Profile",
                            style: TextStyle(
                              color: Color(0xFF181D27),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          5.heightBox,
                          Container(
                            width: double.infinity,
                            height: h * 0.16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Name: ${data['name']}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 19,
                                              fontFamily: medium,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          5.heightBox,
                                          Text(
                                            "Phone Number: +2 ${data['phone_number']}",
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 102, 102, 102),
                                              fontSize: 10,
                                              fontFamily: medium,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     Get.to(() => const EditeProfileScreen());
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.edit,
                                  //     color: whiteColor,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                profileBtn(
                                  onTap: () {
                                    Get.to(() => const ViewProfileInfo());
                                  },
                                  title: "Update Account Information",
                                  icon: Icons.person_2_outlined,
                                ),
                                20.heightBox,
                                profileBtn(
                                    onTap: () {
                                      Get.to(() => const savedAddresses());
                                    },
                                    title: "Saved Addresses",
                                    icon: Icons.location_on),
                                20.heightBox,
                                profileBtn(
                                    onTap: () async {
                                      // await Get.put(AuthController())
                                      //     .signOutMethod(context);
                                      // Get.offAll(() => const LogInScreen());
                                    },
                                    title: "Change Language",
                                    icon: Icons.language),
                                20.heightBox,
                                profileBtn(
                                    onTap: () {
                                      //Get.to(()=>const BookingScreen());
                                      //Get.to(() => const SthWentWrongScreen());
                                    },
                                    title: "FAQ",
                                    icon: Icons.question_mark_sharp),
                                20.heightBox,
                                profileBtn(
                                    onTap: () {
                                      //Get.to(()=>CompleteLogin());
                                    },
                                    title: "About",
                                    icon: Icons.info),
                                20.heightBox,
                                profileBtn(
                                  onTap: () async {
                                    // Signout the user
                                    await Get.put(AuthController()).signOutMethod(context);
                                    // Navigate to the login screen
                                    Get.offAll(() => const LogInScreen());

                                  },
                                  title: "Signout",
                                  icon: Icons.output,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}

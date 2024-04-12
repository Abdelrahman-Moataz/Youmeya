import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/controllers/profile_controller.dart';
import 'package:youmeya/services/firestore_services.dart';
import 'package:youmeya/view/profile_screen/edite/edite_profile_email.dart';
import 'package:youmeya/view/profile_screen/edite/edite_profile_name.dart';
import 'package:youmeya/view/profile_screen/edite/edite_profile_password.dart';
import 'package:youmeya/view/profile_screen/edite/edite_profile_phone.dart';
import 'package:youmeya/view/profile_screen/widgets/edited.dart';

class ViewProfileInfo extends StatelessWidget {
  const ViewProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile Data",
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
        ),
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
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      50.heightBox,
                      profileEdite(
                        name: "Name",
                        onTap: () {
                          Get.to(() => const EditeProfileName());
                        },
                        title:
                            "${data['name'] == '' ? "Not available" : data['name']}",
                      ),
                      10.heightBox,
                      profileEdite(
                        name: "Email",
                        onTap: () {
                          Get.to(() => const EditeProfileEmail());
                        },
                        title:
                            "${data['email'] == '' ? "Not available" : data['email']}",
                      ),
                      10.heightBox,
                      profileEdite(
                        name: "Phone",
                        onTap: () {
                          Get.to(() => const EditeProfilePhone());
                        },
                        title:
                            "${data['phone_number'] == '' ? "Not available" : data['phone_number']}",
                      ),
                      10.heightBox,
                      profileEdite(
                        name: "Password",
                        onTap: () {
                          Get.to(() => const EditeProfilePassword());
                        },
                        title: "**************",
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

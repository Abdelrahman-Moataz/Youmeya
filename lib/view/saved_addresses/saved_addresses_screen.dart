import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/saved_addresses/add_new_address.dart';
import 'package:youmeya/view/saved_addresses/widgets/card_widget.dart';

import '../../services/firestore_services.dart';
import '../history_screen/history_widget/card_wdget.dart';

class savedAddresses extends StatelessWidget {
  const savedAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    //const addresses = {
    //"Home": "Maadi",
    //};
    //var entries = ["1"];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Saved Addresses",
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
              padding: const EdgeInsets.all(30),
              width: w,
              height: h * 0.9,
              color: Colors.white,
              child: Column(children: [
                10.heightBox,
                StreamBuilder(
                    stream: FireStoreServices.getLocation(currentUser!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(mainColor),
                          ),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return ListView(
                          shrinkWrap: true,
                          children: List.generate(
                            data.length,
                            (index) => cardWidget(
                                w: w,
                                h: h * 0.08,
                                body:
                                    "Street ${data[index]["buildingName"]}, ${data[index]["flatNumber"]}, flat ${data[index]["floorNumber"]} ",
                                title: data[index]['address']),
                          ),
                        );
                      }
                    }),
                SizedBox(
                  height: h * 0.4,
                ),
                ourButton(
                    onPress: () {
                      Get.to(() => const AddNewAdress());
                    },
                    color: mainColor,
                    textColor: whiteColor,
                    title: "Add new Address"),
                20.heightBox,
                ourButton(
                    onPress: () {},
                    color: mainColor,
                    textColor: whiteColor,
                    title: "Save"),
              ]))),
    );
  }
}

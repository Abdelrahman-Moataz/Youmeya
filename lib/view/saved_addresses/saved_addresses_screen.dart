import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/saved_addresses/add_new_address.dart';
import 'package:youmeya/view/saved_addresses/widgets/card_widget.dart';

import '../../services/firestore_services.dart';
import '../history_screen/history_widget/card_wdget.dart';

class savedAddresses extends StatefulWidget {
  const savedAddresses({super.key});

  @override
  State<savedAddresses> createState() => _savedAddressesState();
}
bool? valuenum = false;
int? selectedIdx;

class _savedAddressesState extends State<savedAddresses> {
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
        resizeToAvoidBottomInset: false,
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
              height: h * 0.96,
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
                        return SizedBox(
                          height: h * 0.55,
                          child: ListView(
                            shrinkWrap: true,
                            children: List.generate(
                              data.length,
                                  (index) => cardWidget(
                                  value: selectedIdx == index, // Set the checkbox value based on whether the index matches the selected index
                                  onChanged: (value) {
                                    setState(() {
                                      selectedIdx = index; // Update the selected index when the checkbox is changed
                                    });
                                  },
                                  w: w,
                                  h: h * 0.09,
                                  body: "Street ${data[index]["buildingName"]}, "
                                      "${data[index]["flatNumber"]}, "
                                      "flat ${data[index]["floorNumber"]} ",
                                  title: data[index]['address']
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                20.heightBox,
                Column(
                  children: [
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
                  ],
                ),
              ]))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/saved_addresses/add_new_address.dart';
import 'package:youmeya/view/saved_addresses/widgets/card_widget.dart';

class savedAddresses extends StatelessWidget {
  const savedAddresses({Key? key}) : super(key: key);

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
                Card(
                    color: mainColor,
                    elevation: 0.3,
                    child: Container(
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.all(5),
                      width: w,
                      height: h * 0.08,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.white),
                              15.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Home",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                  Text(
                                    "Street 15 b16 Flat 40  qertyuiopppp",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                cardWidget(
                    w: w,
                    h: h * 0.08,
                    title: "Work",
                    body: "Street 15 b16 Flat 40 "),
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

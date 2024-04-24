import 'package:youmeya/consent/consent.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const Text(
                  //widget.title,
                  "Order Details",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                const Text("        "),
                //notificationWidget(h: h * 0.05),
              ],
            ),
            20.heightBox,
            SizedBox(
              height: h * 0.82,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      const Text("Mon, 8 April 2024"),
                      10.heightBox,
                      const Text("#12345"),
                      10.heightBox,
                      const Text("Completed"),
                      10.heightBox,
                      Container(
                        decoration: BoxDecoration(
                          color: bottom,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                          child: Text("Dry clean & iron"),
                        ),
                      ),
                      20.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star_border,
                                size: 40,
                                color: bottom,
                              ),
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Order Items"),
                                10.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star_border,
                                      size: 40,
                                      color: bottom,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Delivery Address"),
                                10.heightBox,
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: cBG,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 4.0,
                                              bottom: 4.0),
                                          child: Text(
                                            "Home",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.heightBox,
                                const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sub Total"),
                                      Text("280 EGP"),
                                    ]),
                                10.heightBox,
                                const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sub Total"),
                                      Text("280 EGP"),
                                    ]),
                                5.heightBox,
                                const Divider(),
                                5.heightBox,
                                const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sub Total"),
                                      Text("280 EGP"),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.heightBox,
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 30.0,
                          left: 30.0,
                        ),
                        child: ourButton(
                            onPress: () {},
                            color: mainColor,
                            textColor: whiteColor,
                            title: "Track Your Order"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

import 'package:youmeya/consent/consent.dart';

import '../../controllers/card_controller.dart';
import '../../services/firestore_services.dart';
import '../checkout_screen/widget/list_of_items.dart';
import '../order_status_screen/order_status_screen.dart';

double rating = 5.0;

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    var controller = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                  child: StreamBuilder(
                      stream: FireStoreServices.getOrderCollectionId(title),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(mainColor),
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "No order yet".text.color(bottom).make(),
                          );
                        } else {
                          var data = snapshot.data!.docs;
                          controller.productSnapshot = data;
                          return ListView(
                            shrinkWrap: true,
                            children: List.generate(data.length,
                                    (index) => Column(
                                      children: [
                                         Text(
                                             data[index]['pickUp_date']
                                         ),
                                        10.heightBox,
                                         Text("#${data[index]['order_code']}"),
                                        10.heightBox,
                                         Text(data[index]['order_placed']==true &&
                                             data[index]['order_confirmed']==false &&
                                             data[index]['order_on_delivery']==false &&
                                             data[index]['order_delivered']==false

                                             ? "order Placed":
                                         data[index]['order_placed']==true &&
                                             data[index]['order_confirmed']==true &&
                                             data[index]['order_on_delivery']==false &&
                                             data[index]['order_delivered']==false  ?
                                         "Confirmed" :
                                         data[index]['order_placed']==true &&
                                             data[index]['order_confirmed']==true &&
                                             data[index]['order_on_delivery']==true &&
                                             data[index]['order_delivered']==false  ?
                                         "order on delivery" :
                                         data[index]['order_placed']==true &&
                                             data[index]['order_confirmed']==true &&
                                             data[index]['order_on_delivery']==true &&
                                             data[index]['order_delivered']==true ?
                                         "Order delivered" : "Done"),
                                        10.heightBox,
                                        Container(
                                          decoration: BoxDecoration(
                                            color: bottom,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 2.0,
                                                bottom: 2.0),
                                            child: Text("Dry clean & iron"),
                                          ),
                                        ),
                                        20.heightBox,
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: borderColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: List.generate(
                                                5,
                                                    (index) {

                                                  if (index < data.length && data[index]['oder_rating'] != null) {
                                                    var ratingString = data[index]['oder_rating'];
                                                    rating = double.tryParse(ratingString.toString()) ?? 5.0;
                                                  }
                                                  int numberOfStars = rating.round(); // Round the rating to the nearest integer
                                                  Color starColor = index < numberOfStars ? bottom : Colors.grey;
                                                  return Icon(
                                                    Icons.star,
                                                    size: 40,
                                                    color: starColor,
                                                  );
                                                },
                                              ),
                                            ),







                                          ),
                                        ),
                                        20.heightBox,
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: borderColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Order Items"),
                                                  10.heightBox,
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: List.generate(
                                                      data.length,
                                                          (index) => SizedBox(
                                                            height: h * 0.05,
                                                            child: ListView(
                                                              scrollDirection: Axis.horizontal,
                                                              shrinkWrap: true,
                                                              children: List.generate(
                                                                data.length,
                                                                    (index) => listOfItems(
                                                                  qnt: data[index]['orders'][index]['qty'],
                                                                  img: data[index]['orders'][index]['img'],
                                                                ),
                                                              ),
                                                            ),
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
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: borderColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Delivery Address"),
                                                  10.heightBox,
                                                  Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: cBG,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                          ),
                                                          child:  Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 8.0,
                                                                right: 8.0,
                                                                top: 4.0,
                                                                bottom: 4.0),
                                                            child: Text(
                                                              "${data[index]['order_by_address']}",
                                                              style: const TextStyle(
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
                                          padding: const EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: borderColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  10.heightBox,
                                                   Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("Subtotal"),
                                                        Text("${data[index]['total_amount']-deliveryFees}  EGP"),
                                                      ]),
                                                  10.heightBox,
                                                  const Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("Delivery"),
                                                        Text("$deliveryFees EGP"),
                                                      ]),
                                                  5.heightBox,
                                                  const Divider(
                                                    color: bottom,
                                                    thickness: 1.5,
                                                  ),
                                                  5.heightBox,
                                                   Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text("Total"),
                                                        Text("${data[index]['total_amount']} EGP"),
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
                                            onPress: () {
                                              Get.to(() =>  OrderStatus(
                                                id: data[index]['collection_id']
                                              ));
                                            },
                                            color: mainColor,
                                            textColor: whiteColor,
                                            title: "Track Your Order",
                                          ),
                                        )
                                      ],
                                    ),
                            )


                          );
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }
}

import 'package:youmeya/consent/consent.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:youmeya/view/checkout_screen/widget/cashorvisa.dart';
import 'package:youmeya/view/checkout_screen/widget/day-container.dart';
import 'package:youmeya/view/checkout_screen/widget/list_of_items.dart';
import '../../controllers/card_controller.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import '../old_order_confirmation_screen/old_order_confirmation_screen.dart';
import '../order_confirmation/order_confirmation.dart';


class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  DateTime? _selectedTime;

  void _showTimePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          height: 150,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                _selectedTime = newDateTime;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    String getTodayDate() {
      final now = DateTime.now();
      final formatter = DateFormat("d MMM"); // EEEE for full weekday name
      final todayDate = formatter.format(now);
      return todayDate;
    }

    String getTodayDayName() {
      final now = DateTime.now();
      final formatter = DateFormat("EEE"); // EEEE for full weekday name
      final todayDate = formatter.format(now);
      return todayDate;
    }

    String getTomorrowsDate(int daysToAdd) {
      final now = DateTime.now();
      final tomorrow = now.add(Duration(days: daysToAdd)); // Add 1 day
      final formatter = DateFormat("d MMM"); // Or any desired format
      final tomorrowDate = formatter.format(tomorrow);
      return tomorrowDate;
    }

    String getTomorrowsDayName(int daysToAdd) {
      final now = DateTime.now();
      final tomorrow = now.add(Duration(days: daysToAdd)); // Add 1 day
      final formatter = DateFormat("EEE"); // Or any desired format
      final tomorrowDate = formatter.format(tomorrow);
      return tomorrowDate;
    }

    var controller = Get.put(CartController());
    var controllerQ = Get.put(ProductController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
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
                  const Text("Checkout"),
                  const Text("        "),
                ],
              ),
              10.heightBox,
              SingleChildScrollView(
                reverse: true,
                child: SizedBox(
                  height: h * 0.84,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text("Your Basket"),
                      10.heightBox,
                      SizedBox(
                        height: h * 0.05,
                        width:  w,
                        child: StreamBuilder(
                            stream: FireStoreServices.getCart(currentUser!.uid),
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
                                  child:
                                      "Cart is Empty".text.color(bottom).make(),
                                );
                              } else {
                                var data = snapshot.data!.docs;
                                controller.calculate(data);
                                controller.productSnapshot = data;
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  //shrinkWrap: true,
                                  children: List.generate(
                                    data.length,
                                    (index) => listOfItems(
                                      qnt: data[index]['quantity'],
                                      img: data[index]['img'],
                                    ),
                                  ),
                                );
                              }
                            }),
                      ),
                      10.heightBox,
                      const Text("Select Pickup Date"),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) => dayContainer(
                            context1: context,
                            context2: context
                            ,onTap: () {

                        },
                            day: getTomorrowsDayName(index),
                            date: getTomorrowsDate(index),
                            colorr: index== 0 ? mainColor : bottom,),
                          )



                        ,
                      ),
                      10.heightBox,
                      const Text("Select Pickup Time"),
                      10.heightBox,
                      InkWell(
                        onTap: () {
                          _showTimePicker(context);
                        },
                        child: Container(
                          height: h * 0.06,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  _selectedTime != null
                                      ? DateFormat.jm().format(_selectedTime!)
                                      : 'Select Time',
                                  style: const TextStyle(color: whiteColor),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down,
                                  color: whiteColor),
                            ],
                          ),
                        ),
                      ),
                      10.heightBox,
                      const Text("Select Address"),
                      10.heightBox,
                      const Text("Payment Method"),
                      10.heightBox,
                      cashOrVisa(
                          context1: context,
                          context2: context,
                          title: "Cash",
                          colur: mainColor,
                          img: cash),
                      5.heightBox,
                      cashOrVisa(
                        context1: context,
                        img: visa,
                        context2: context,
                        title: "Visa",
                        colur: whiteColor,
                      ),
                      10.heightBox,
                      const Text("Special Request"),
                      10.heightBox,
                      customTextField(
                        mLine: 5,
                        title: "",
                        hint: "Enter your special request",
                        controller: null,
                        isPass: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your special request";
                          }
                          return null;
                        },
                      ),
                      15.heightBox,
                      Column(children: [
                        const Row(
                          children: [
                            Text("Subtotal"),
                            Spacer(),
                            Text("100 EGP"),
                          ],
                        ),
                        const Row(
                          children: [
                            Text("Delivery"),
                            Spacer(),
                            Text("100 EGP"),
                          ],
                        ),
                        const Divider(
                          color: bottom,
                        ),
                        const Row(
                          children: [
                            Text("Total"),
                            Spacer(),
                            Text("200 EGP"),
                          ],
                        ),
                        15.heightBox,
                        ourButton(
                          onPress: () {
                            Get.to(()=>const OrderConfirmation());
                          },
                          color: mainColor,
                          textColor: whiteColor,
                          title: 'PLACE ORDER',
                        ),
                      ]),
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

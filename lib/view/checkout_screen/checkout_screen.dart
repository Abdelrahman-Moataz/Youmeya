import 'package:youmeya/consent/consent.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:youmeya/view/checkout_screen/widget/cashorvisa.dart';
import 'package:youmeya/view/checkout_screen/widget/day-container.dart';
import 'package:youmeya/view/checkout_screen/widget/list_of_items.dart';
import '../../controllers/card_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import '../old_order_confirmation_screen/old_order_confirmation_screen.dart';
import '../order_confirmation/order_confirmation.dart';

class CheckOut extends StatefulWidget {
  CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {


  Future<int> getMaxOrderNum() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('orders').get();
    List<int> orderNumbers = snapshot.docs
        .map((doc) => doc.data() ?? ['orderNumber'])
        .cast<int>()
        .toList();
    int maxOrderNum = orderNumbers.isNotEmpty
        ? orderNumbers.reduce((a, b) => a > b ? a : b)
        : 0;
    return maxOrderNum;
  }

  DateTime? _selectedTime;

  int selectedIndex = 0;
  var controller = Get.put(CartController());
  var controllerQ = Get.put(ProductController());

  List<String> pay = ["Cash", "Visa"];
  List<String> payImg = [cash, visa];
  int selectedValue = 0;

  String? _selectedLocation;

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
                print(_selectedTime);
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

    String? TomorrowsDate;
    String? TomorrowsDayName;

    String getTomorrowsDate(int daysToAdd) {
      final now = DateTime.now();
      final tomorrow = now.add(Duration(days: daysToAdd)); // Add selected day
      final formatter = DateFormat("d MMM"); // Or any desired format
      final tomorrowDate = formatter.format(tomorrow);
      return tomorrowDate;
    }

    String getTomorrowsDayName(int daysToAdd) {
      final now = DateTime.now();
      final tomorrow = now.add(Duration(days: daysToAdd)); // Add selected day
      final formatter = DateFormat("EEE"); // Or any desired format
      final tomorrowDate = formatter.format(tomorrow);
      return tomorrowDate;
    }

    String getTomorrowInfo(int daysToAdd, String format) {
      final now = DateTime.now();
      final tomorrow =
          now.add(Duration(days: daysToAdd)); // Add specified number of days
      final formatter = DateFormat(format); // Use specified format
      final tomorrowInfo = formatter.format(tomorrow);
      return tomorrowInfo;
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              SizedBox(
                height: h * 0.84,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text("Your Basket"),
                    10.heightBox,
                    SizedBox(
                      height: h * 0.05,
                      width: w,
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
                      children: List.generate(
                        4,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex =
                                  index; // Update selectedIndex when item is pressed
                              print(getTomorrowsDate(index));
                              print(getTomorrowsDayName(index));

                            });
                          },
                          child: dayContainer(
                            color: index == selectedIndex ? bottom : mainColor,
                            width: w * 0.2,
                            height: h * 0.07,
                            day: TomorrowsDayName = getTomorrowsDayName(index),
                            date: TomorrowsDate = getTomorrowsDate(index),
                          ),
                        ),
                      ),
                    ),
                    10.heightBox,
                    const Text("Select Pickup Time"),
                    10.heightBox,
                    InkWell(
                      onTap: () {
                        setState(() {

                          _showTimePicker(context);
                        });

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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                    InkWell(
                      onTap: () {
                        // Display dropdown menu
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Select Location',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: interThin,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  StreamBuilder(
                                      stream: FireStoreServices.getLocation(
                                          currentUser!.uid),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      mainColor),
                                            ),
                                          );
                                        } else {
                                          var data = snapshot.data!.docs;

                                          return Expanded(
                                            child: ListView.builder(
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                final location =
                                                    data[index]['address'];
                                                return ListTile(
                                                  title: Text(location),
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedLocation =
                                                          location;

                                                    });

                                                    Navigator.pop(context);

                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: h * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: mainColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Delivering to",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: medium,
                                  color: whiteColor,
                                ),
                              ),
                              Text(
                                _selectedLocation ?? 'Select Location',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: medium,
                                  color: whiteColor,
                                ),
                              ),
                              const Icon(Icons.location_pin,
                                  color: whiteColor, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.heightBox,
                    const Text("Payment Method"),
                    10.heightBox,
                    Column(
                      children: List.generate(
                          2,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedValue =
                                        index; // Update selectedIndex to the tapped index
                                    print(index);
                                    print(pay[index]);
                                    controller.orderPaymentMethodController
                                        .text = pay[index];
                                  });
                                },
                                child: cashOrVisa(
                                  context1: context,
                                  context2: context,
                                  title: pay[index],
                                  colur: index == selectedValue
                                      ? mainColor
                                      : Colors
                                          .grey, // Change color based on the selected index
                                  img: payImg[index],
                                ),
                              )),
                    ),
                    10.heightBox,
                    const Text("Special Request"),
                    10.heightBox,
                    customTextField(
                      mLine: 5,
                      title: "",
                      hint: "Enter your special request",
                      controller: controller.moreDetailsController,
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
                      Row(
                        children: [
                          const Text("Subtotal"),
                          const Spacer(),
                          Text("${controller.totalP} EGP"),
                        ],
                      ),
                      const Row(
                        children: [
                          Text("Delivery"),
                          Spacer(),
                          Text("25 EGP"),
                        ],
                      ),
                      const Divider(
                        color: bottom,
                      ),
                      Row(
                        children: [
                          const Text("Total"),
                          const Spacer(),
                          Text("${controller.totalP + 25} EGP"),
                        ],
                      ),
                      15.heightBox,
                      ourButton(
                        onPress: () async {
                          await controller.placeMyOrder(
                            time: _selectedTime,
                            date: "$TomorrowsDayName , $TomorrowsDate",
                            address: _selectedLocation.toString(),
                            orderPaymentMethod:
                                controller.orderPaymentMethodController.text,
                            totalAmount: controller.totalP.value + 25,
                            more: controller.moreDetailsController.text,
                          );
                          await controller.clearCart();
                          Get.to(() => const OrderConfirmation());
                        },
                        color: mainColor,
                        textColor: whiteColor,
                        title: 'PLACE ORDER',
                      ),
                      30.heightBox,
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

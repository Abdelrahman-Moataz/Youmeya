import 'package:youmeya/consent/consent.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:youmeya/view/checkout_screen/widget/cashorvisa.dart';
import 'package:youmeya/view/checkout_screen/widget/day-container.dart';


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

    return SafeArea(
      child: Scaffold(
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
                    Text("Your Basket"),
                    10.heightBox,
                    Row(
                      children: [
                        Text("3X"),
                        5.widthBox,
                        Image.asset(shirt),
                        15.widthBox,
                        Text("3X"),
                        5.widthBox,
                        Image.asset(shirt),
                        15.widthBox,
                        Text("3X"),
                        5.widthBox,
                        Image.asset(shirt),
                        15.widthBox,
                        Text("3X"),
                        5.widthBox,
                        Image.asset(shirt),
                        15.widthBox,
                      ],
                    ),
                    10.heightBox,
                    const Text("Select Pickup Date"),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dayContainer(
                            context1: context,
                            context2: context,
                            day: getTodayDayName(),
                            date: getTodayDate(),
                            colorr: bottom),
                        5.widthBox,
                        dayContainer(
                            context1: context,
                            context2: context,
                            day: getTomorrowsDayName(1),
                            date: getTomorrowsDate(1),
                            colorr: mainColor),
                        5.widthBox,
                        dayContainer(
                            context1: context,
                            context2: context,
                            day: getTomorrowsDayName(2),
                            date: getTomorrowsDate(2),
                            colorr: mainColor),
                        5.widthBox,
                        dayContainer(
                            context1: context,
                            context2: context,
                            day: getTomorrowsDayName(3),
                            date: getTomorrowsDate(3),
                            colorr: mainColor),
                      ],
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
                    const Text("Payment Method"),
                    10.heightBox,


                    cashOrVisa(
                      context1: context,
                      context2: context,
                      title: "Cash",
                      colur: mainColor,
                      img: cash
                    ),
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

                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {

                          },
                          child: const Text("Order Place"),
                        ),
                      ],
                    ),

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

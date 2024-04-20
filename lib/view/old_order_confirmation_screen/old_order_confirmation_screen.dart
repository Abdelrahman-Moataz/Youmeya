import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/controllers/profile_controller.dart';
import '../checkout_screen/checkout_screen.dart';



class OldOrderConfirmation extends StatefulWidget {
  const OldOrderConfirmation({super.key});

  @override
  State<OldOrderConfirmation> createState() => _OldOrderConfirmationState();
}

class _OldOrderConfirmationState extends State<OldOrderConfirmation> {
  String? _selectedLocation; // Option 2

  @override
  void initState() {
    super.initState();
    _selectedLocation = _locations[0]; // Choose the first item as default
  }

  var controller = Get.put(ProfileController());

  final List<String> _locations = ['1 Item', '2 Item', '3 Item'];

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

  DateTime? _selectedDate;

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          height: 150,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            minimumDate: DateTime.now(),
            maximumDate: DateTime.now().add(const Duration(days: 365)),
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                _selectedDate = newDateTime;
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
    // Option 2

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: h * 0.9, // Make the entire body full width
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
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
                        const Text("Order confirmation"),
                        const Text("             "),
                      ],
                    ),
                    (h * 0.05).heightBox,
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Number of Items")),
                    5.heightBox,
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: h * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor,
                            border: Border.all(color: Colors.black)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedLocation,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLocation = newValue;
                              });
                            },
                            items: _locations.map((String location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(location,
                                      style:
                                          const TextStyle(color: borderColor)),
                                ),
                              );
                            }).toList(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: medium,
                              color: whiteColor,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: whiteColor),
                            dropdownColor: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    (h * 0.05).heightBox,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Time",
                      ),
                    ),
                    5.heightBox,
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
                    (h * 0.05).heightBox,
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Select Date")),
                    5.heightBox,
                    InkWell(
                      onTap: () {
                        _showDatePicker(context);
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
                                _selectedDate != null
                                    ? DateFormat.yMMMd().format(_selectedDate!)
                                    : 'Select Date',
                                style: const TextStyle(color: whiteColor),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down,
                                color: whiteColor),
                          ],
                        ),
                      ),
                    ),
                    (h * 0.05).heightBox,
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Payment method")),
                    (10).heightBox,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(153, 236, 236, 236)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.asset(cash),
                            20.widthBox,
                            const Text("Cash On Delivery"),
                            5.widthBox,
                          ],
                        ),
                      ),
                    ),
                    (h * 0.05).heightBox,
                    customTextField(
                      controller: controller.nameController,
                      title: "Special Requests",
                      hint:
                          "Type Your Special Request Here If The Items Are (Suit,Dress,etc...)",
                      validator: (title) {
                        return null;
                      },
                      isPass: false,
                      mLine: 3,
                    ),
                    15.heightBox,
                    ourButton(
                        onPress: () {
                          Get.to(() => const CheckOut());
                        },
                        color: mainColor,
                        textColor: whiteColor,
                        title: "Next")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

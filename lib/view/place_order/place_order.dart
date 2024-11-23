import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:youmeya/consent/colors.dart';
import 'package:youmeya/controllers/home_controller.dart';

import '../bite_screen/bite_screen.dart';
import '../bite_screen/system_bit/system-bit.dart';



class PlacingOrder extends StatefulWidget {
  const PlacingOrder({super.key, this.title});

  final String? title;

  @override
  _PlacingOrderState createState() => _PlacingOrderState();
}

class _PlacingOrderState extends State<PlacingOrder> {
  int selectedHours = 2; // Default selected hours
  TextEditingController serviceDetailsController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "How many hours do you need your helpers to stay?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              final hour = index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedHours = hour;
                  });
                },
                child: CircleAvatar(
                  backgroundColor:
                      selectedHours == hour ? Colors.blue : Colors.grey[300],
                  child: Text(
                    hour.toString(),
                    style: TextStyle(
                      color:
                          selectedHours == hour ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          const Text(
            "Service Details",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: serviceDetailsController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter details about the service",
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "When would you like your service?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedDate != null
                    ? "${selectedDate!.toLocal()}".split(' ')[0]
                    : "Select Date",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "What time would you like your service?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => _selectTime(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedTime != null
                    ? selectedTime!.format(context)
                    : "Select Time",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Add this for date and time formatting

          ElevatedButton(
            onPressed: () async {
              final serviceName = widget.title;
              final serviceDetails = serviceDetailsController.text;
              final date = selectedDate;
              final time = selectedTime;

              if (serviceDetails.isNotEmpty && date != null && time != null) {
                try {
                  // Fetch the user's location
                  await controller.getUserLocation(); // Fetches and populates `controller.location`

                  // Fetch the latest order number from Firestore
                  final latestOrderDoc = await FirebaseFirestore.instance
                      .collection('systemConfig')
                      .doc('latestOrder')
                      .get();

                  int latestOrder = 0;
                  if (latestOrderDoc.exists) {
                    latestOrder = latestOrderDoc.data()?['orderNumber'] ?? 0;
                  }

                  // Increment the order number and format it to 7 characters
                  final newOrderNumber = latestOrder + 1;
                  final formattedOrderNumber = newOrderNumber.toString().padLeft(7, '0');

                  // Save the incremented order number back to Firestore
                  await FirebaseFirestore.instance
                      .collection('systemConfig')
                      .doc('latestOrder')
                      .set({'orderNumber': newOrderNumber});

                  // Format the date and time into "2024-11-10 10:30 AM"
                  final formattedDateTime =
                      "${DateFormat('yyyy-MM-dd').format(date)} ${time.format(context)}";

                  // Convert location map into a readable string
                  final locationString = controller.location.isNotEmpty
                     ?'${controller.location},'
                      : 'No location data found';

                  // Save the order to Firestore
                  await FirebaseFirestore.instance.collection('orders').add({
                    'orderNumber': "ORD-$formattedOrderNumber",
                    'userName': controller.userName,
                    'phoneNumber': controller.phoneNumber,
                    'address': locationString,
                    'serviceName': serviceName,
                    'hours': selectedHours,
                    'serviceDetails': serviceDetails,
                    'dateTime': formattedDateTime, // Save combined date and time
                    'createdAt': FieldValue.serverTimestamp(), // Save timestamp
                  });

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order placed successfully!")),
                  );
                  Get.to(BidsPage(
                    orderNumber: formattedOrderNumber,
                  ));

                  // Clear the form after saving
                  setState(() {
                    controller.location.clear();
                    serviceDetailsController.clear();
                    selectedHours = 2; // Reset to default
                    selectedDate = null;
                    selectedTime = null;
                  });
                } catch (e) {
                  // Handle Firestore error
                  print("Error adding document: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to place order. Try again.")),
                  );
                }
              } else {
                // Show error if fields are empty
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill in all fields")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Replace with your main color
              minimumSize: const Size(double.infinity, 50), // Full-width button
            ),
            child: const Text(
              "Place Order",
              style: TextStyle(color: Colors.white),
            ),
          ),


        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/checkout_screen/checkout_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    const status = "Delivered";

    // Map to store widgets for each state
    final Map<String, Widget> steps = {
      "Received": const Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Color.fromARGB(255, 34, 174, 255),
                size: 20,
              ),
              title: Text(
                "Received",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text("15/5/2025 10:33 PM"),
            ),
          ],
        ),
      ),
      "Magic Happening": const Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Colors.blueAccent,
                size: 20,
              ),
              title: Text(
                "Magic Happening",
                style: TextStyle(fontSize: 15),
              ),
              trailing: Text("15/5/2025 10:33 PM"),
            ),
          ],
        ),
      ),
      "Done": const Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Colors.deepOrange,
                size: 20,
              ),
              title: Text(
                "Done",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text("15/5/2025 10:33 PM"),
            ),
          ],
        ),
      ),
      "Delivered": const Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Colors.green,
                size: 20,
              ),
              title: Text(
                "Delivered",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              trailing: Text("15/5/2025 10:33 PM"),
            ),
          ],
        ),
      ),
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Order Details",
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: w,
            height: h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "#1234567",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "medium",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Completed"),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      final stepKey = steps.keys.toList()[index];
                      return Visibility(
                        visible: steps.keys.toList().indexOf(status) >= index,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: steps[stepKey],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Get.to(() => const CheckOut());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(w * 0.3, 40),
                  ),
                  child: const Text("Support"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

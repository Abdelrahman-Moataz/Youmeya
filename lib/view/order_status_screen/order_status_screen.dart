import 'package:youmeya/consent/consent.dart';

import '../../services/firestore_services.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Order Status",
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
              width: w,
              height: h * 0.99,
              child: StreamBuilder(
                  stream: FireStoreServices.getOrderCollectionId(id),
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
                      const status = "Delivered";

                      // Map to store widgets for each state
                      final Map<String, Widget> steps = {
                        "Order Placed": const Card(
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
                                //trailing: Text("15/5/2025 10:33 PM"),
                              ),
                            ],
                          ),
                        ),
                        "order_confirmed": const Card(
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
                                //trailing: Text("15/5/2025 10:33 PM"),
                              ),
                            ],
                          ),
                        ),
                        "order_on_delivery": const Card(
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
                                //trailing: Text("15/5/2025 10:33 PM"),
                              ),
                            ],
                          ),
                        ),
                        "order_delivered": const Card(
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
                                //trailing: Text("15/5/2025 10:33 PM"),
                              ),
                            ],
                          ),
                        ),
                      };

                      return ListView(
                        shrinkWrap: true,
                        children: List.generate(
                          data.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${data[index]['order_code']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "medium",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              SizedBox(
                                height: h * 0.6,
                                child: Column(
                                  children: data.asMap().entries.map((entry) {
                                    final index = entry.key;


                                    // Define the status based on your conditions
                                    String status = "Done";
                                    if (data[index]['order_placed'] == true &&
                                        data[index]['order_confirmed'] == false &&
                                        data[index]['order_on_delivery'] == false &&
                                        data[index]['order_delivered'] == false) {
                                      status = "Order Placed";
                                    } else if (data[index]['order_placed'] == true &&
                                        data[index]['order_confirmed'] == true &&
                                        data[index]['order_on_delivery'] == false &&
                                        data[index]['order_delivered'] == false) {
                                      status = "Confirmed";
                                    } else if (data[index]['order_placed'] == true &&
                                        data[index]['order_confirmed'] == true &&
                                        data[index]['order_on_delivery'] == true &&
                                        data[index]['order_delivered'] == false) {
                                      status = "Order on Delivery";
                                    } else if (data[index]['order_placed'] == true &&
                                        data[index]['order_confirmed'] == true &&
                                        data[index]['order_on_delivery'] == true &&
                                        data[index]['order_delivered'] == true) {
                                      status = "Order Delivered";
                                    }

                                    // Build the list of widgets based on the status
                                    return Column(
                                      children: steps.keys.map((stepKey) {
                                        return Visibility(
                                          visible: stepKey == status, // Show only the step that matches the status
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: steps[stepKey],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }).toList(),
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
                      );
                    }
                  })),
        ),
      ),
    );
  }
}

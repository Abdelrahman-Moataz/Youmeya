import 'package:flutter/material.dart';

class BidsPage extends StatelessWidget {
  final List<Map<String, String>> bids = [
    {"name": "Mohamed", "location": "Maadi", "price": "500EGP"},
    {"name": "Mohamed", "location": "Maadi", "price": "500EGP"},
    {"name": "Mohamed", "location": "Maadi", "price": "500EGP"},
    {"name": "Mohamed", "location": "Maadi", "price": "500EGP"},
    {"name": "Mohamed", "location": "Maadi", "price": "500EGP"},
  ];

  var orderNumber;

   BidsPage({super.key,this.orderNumber});
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$orderNumber"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bids.length,
          itemBuilder: (context, index) {
            final bid = bids[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    bid["name"]!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "Location: ${bid["location"]}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bid["price"]!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Handle accept action
                          print("Accepted bid by ${bid["name"]}");
                        },
                        child: Text("Accept"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BidsPage(),
    debugShowCheckedModeBanner: false,
  ));
}

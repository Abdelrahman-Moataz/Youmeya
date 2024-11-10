import 'package:flutter/material.dart';

import 'confirm-order.dart';

class SystmeBit extends StatefulWidget {
  @override
  _SystmeBitState createState() => _SystmeBitState();
}

class _SystmeBitState extends State<SystmeBit> {
  List<Map<String, dynamic>> bids = [
    {"provider": "Provider 1", "price": 100, "details": "Basic cleaning service"},
    {"provider": "Provider 2", "price": 150, "details": "Deep cleaning service"},
    {"provider": "Provider 3", "price": 120, "details": "Standard cleaning"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Service Bids")),
      body: ListView.builder(
        itemCount: bids.length,
        itemBuilder: (context, index) {
          final bid = bids[index];
          return ListTile(
            title: Text(bid["provider"]),
            subtitle: Text(bid["details"]),
            trailing: Text("Price: ${bid["price"].toString()} LE"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmationPage(
                    bid: bid,
                    serviceName: bid["provider"],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


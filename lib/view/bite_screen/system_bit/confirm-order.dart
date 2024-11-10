import 'package:youmeya/consent/consent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmeya/view/home_secreen/home_screen.dart';
import 'package:youmeya/view/nav_bar/nav_bar.dart';

import '../../../consent/strings.dart';

class ConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> bid;
  final String serviceName;

  ConfirmationPage({required this.bid, required this.serviceName});

  Future<void> confirmAndSubmitBid(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final String? userUID = user?.uid;

    final orderData = {
      "service": serviceName,
      "provider_name": bid["provider"],
      "price": bid["price"],
      "time": DateTime.now().toIso8601String(),
      "user_uid": userUID,
    };

    try {
      // Save to Firebase
      await FirebaseFirestore.instance.collection('bidding').add(orderData);
      print("Bid successfully added to Firebase");

      // Send to WooCommerce API
      final wooCommerceUrl = Uri.parse('https://youmeya.online/wp-json/wc/v3/bidding');
      final wooCommerceResponse = await http.post(
        wooCommerceUrl,
        headers: {
          'Authorization': 'Basic ' + base64Encode(utf8.encode(keySecret)),
          'Content-Type': 'application/json',
        },
        body: json.encode(orderData),
      );

      if (wooCommerceResponse.statusCode == 201) {
        print("Bid successfully added to WooCommerce");
      } else {
        print("Failed to add bid to WooCommerce: ${wooCommerceResponse.statusCode}");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bid confirmed and saved successfully!")),
      );
    } catch (error) {
      print("Error submitting bid: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit bid")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Bid"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service: $serviceName", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Provider: ${bid["provider"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Price: ${bid["price"]} LE", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Time: ${DateTime.now().toLocal().toString()}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () { confirmAndSubmitBid(context);
                Get.to( NavBar(currentIndex: 0.obs));
                },
              child: Text("Confirm and Submit"),
            ),
          ],
        ),
      ),
    );
  }
}


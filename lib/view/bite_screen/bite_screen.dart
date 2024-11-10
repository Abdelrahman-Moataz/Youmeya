import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BiteScreen extends StatefulWidget {
  @override
  _BiteScreenState createState() => _BiteScreenState();
}

class _BiteScreenState extends State<BiteScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderData();
  }

  Future<void> fetchOrderData() async {
    final url = Uri.parse('https://youmeya.online/wp-json/wc/v3/orders');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode(
                'ck_151d324e1d67bb8edb282464dcac44d64159bc96:cs_353042a0647cc89360319b332fab2a0d07930daa')),
      },
    );

    //   your_consumer_key:   ck_151d324e1d67bb8edb282464dcac44d64159bc96
    //    Consumer secret	   cs_353042a0647cc89360319b332fab2a0d07930daa

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Sort orders by ID in descending order
      orders = List<Map<String, dynamic>>.from(data);
      orders.sort((a, b) => b['id'].compareTo(a['id']));

      setState(() {
        orders = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } else {
      print("Failed to fetch orders: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: fetchOrderData, // Triggers data refresh on pull-down
                child: orders.isEmpty
                    ? Center(child: Text('No orders found'))
                    : ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text('Order ID: ${order['id']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Status: ${order['status']}'),
                                  Text('Currency: ${order['currency']}'),
                                  Text('Total: ${order['total']}'),
                                  Text(
                                      'Date Created: ${order['date_created']}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ));
  }
}

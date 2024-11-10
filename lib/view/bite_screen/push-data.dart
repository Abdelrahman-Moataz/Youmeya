import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youmeya/consent/consent.dart';

class SubmitDataPage extends StatefulWidget {
  @override
  _SubmitDataPageState createState() => _SubmitDataPageState();
}

class _SubmitDataPageState extends State<SubmitDataPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String service = '';
  int people = 1;
  double fees = 0.0;
  String phone = '';
  String flatNumber = '';
  bool isLoading = false;

  Future<void> submitData() async {
    setState(() {
      isLoading = true;
    });

    final data = {
      "name": name,
      "service": service,
      "people": people,
      "fees": fees,
      "phone": phone,
      "flat_number": flatNumber,
    };

    try {
      final wooCommerceUrl = Uri.parse('https://youmeya.online/wp-json/wc/v3/orders');
      final wooCommerceResponse = await http.post(
        wooCommerceUrl,
        headers: {
          'Authorization': 'Basic ' + base64Encode(utf8.encode(keySecret)),
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (wooCommerceResponse.statusCode == 201) {
        print("Data successfully sent to WooCommerce");
      } else {
        print("Failed to send data to WooCommerce: ${wooCommerceResponse.statusCode}");
      }

      await FirebaseFirestore.instance.collection('requests').add(data);
      print("Data successfully added to Firebase");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data submitted successfully!")),
      );
    } catch (error) {
      print("Error submitting data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit data")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submit Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView( // Wrap everything in a ListView for scrollability
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value ?? '',
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Service'),
                onSaved: (value) => service = value ?? '',
                validator: (value) => value!.isEmpty ? 'Enter a service' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'How many people'),
                keyboardType: TextInputType.number,
                onSaved: (value) => people = int.tryParse(value!) ?? 1,
                validator: (value) => value!.isEmpty ? 'Enter number of people' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fees in LE'),
                keyboardType: TextInputType.number,
                onSaved: (value) => fees = double.tryParse(value!) ?? 0.0,
                validator: (value) => value!.isEmpty ? 'Enter fees' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => phone = value ?? '',
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Flat Number'),
                onSaved: (value) => flatNumber = value ?? '',
                validator: (value) => value!.isEmpty ? 'Enter flat number' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    submitData();
                    Get.back();
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

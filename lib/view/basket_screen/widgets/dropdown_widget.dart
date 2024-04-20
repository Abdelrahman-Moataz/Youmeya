import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final String selectedValue; // Initial selected value
  final Function(String) onSelected; // Callback for handling selection

  const MyDropdown({super.key, required this.selectedValue, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.arrow_drop_down), // Down arrow icon
      iconSize: 24,
      elevation: 16, // Elevation for a subtle shadow
      style: const TextStyle(color: Colors.black), // Text color
      underline: Container(
        height: 2,
        color: Colors.black, // Black border
      ),
      onChanged: (String? newValue) {
        onSelected(newValue!); // Call callback with selected value
      },
      items: <String>['Home', 'Work']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      dropdownColor: Colors.white, // White background for the list
      isExpanded: true, // Occupy full width
    );
  }
}

import 'package:flutter/material.dart';

class TextFieldDesign extends StatelessWidget {
  const TextFieldDesign({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(10), // Set the border radius
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Set the border radius
          ),
          hintText: label,
          fillColor: Colors.white,
          filled:
              true, // Add this line to fill the TextField with the fillColor
        ),
      ),
    );
  }
}

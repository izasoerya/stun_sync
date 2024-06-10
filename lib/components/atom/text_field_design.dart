import 'package:flutter/material.dart';

class TextFieldDesign extends StatefulWidget {
  const TextFieldDesign(
      {super.key,
      required this.label,
      required this.visible,
      required this.controller});
  final String label;
  final bool visible;
  final TextEditingController controller;

  @override
  State<TextFieldDesign> createState() => _TextFieldDesignState();
}

class _TextFieldDesignState extends State<TextFieldDesign> {
  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.visible; // Add this line
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color to white
        borderRadius: BorderRadius.circular(15), // Set the border radius
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Set the border radius
          ),
          hintText: widget.label,
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}

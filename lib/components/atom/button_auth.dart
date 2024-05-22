import 'package:flutter/material.dart';

class ButtonAuth extends StatelessWidget {
  final int width;
  final String label;
  final void Function() onPressed;

  const ButtonAuth(
      {super.key,
      this.width = 300,
      required this.onPressed,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(34, 87, 122, 1)),
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(128, 237, 153, 1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

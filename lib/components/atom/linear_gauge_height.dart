import 'package:flutter/material.dart';

class LinearGaugeHeight extends StatelessWidget {
  final double height; // Define height as an instance field

  const LinearGaugeHeight({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Stack(
        children: [
          LinearProgressIndicator(
            value: height / 200,
            minHeight: 10,
            color: Color.fromRGBO(123, 168, 198, 0.7),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.grey[300],
          ),
          Positioned(
            top: 0,
            left: height / 200 * 200 - 5,
            child: CustomPaint(
              size: Size(10, 20),
              painter: PointerPainter(),
            ),
          ),
          LinearProgressIndicator(
            value: (height / 200) * 0.8,
            minHeight: 10,
            color: Color.fromRGBO(34, 87, 122, 1),
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class PointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Color.fromRGBO(34, 87, 122, 1);

    final path = Path()
      ..moveTo(size.width / 2, 5)
      ..lineTo(size.width / 2 - 5, 0)
      ..lineTo(size.width / 2 + 5, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

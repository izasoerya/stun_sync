import 'package:flutter/material.dart';
import 'package:stun_sync/database/models/logo_list.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key, required this.text, required this.logo});
  final String text;
  final LogoList logo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: const Border.symmetric(
          vertical: BorderSide(
            color: Color.fromRGBO(34, 87, 122, 0.2),
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            logoList[logo]!,
            width: 100,
            height: 100,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Color.fromRGBO(34, 87, 122, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

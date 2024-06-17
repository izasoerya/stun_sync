import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class HeadingStatistic extends ConsumerWidget {
  const HeadingStatistic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: [
          Text(
            ref.read(userProfileProvider).name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(34, 87, 152, 1),
            ),
          ),
          Text(
            '${ref.read(userProfileProvider).age.toString()} bulan',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(34, 87, 152, 1),
            ),
          ),
        ],
      ),
    );
  }
}

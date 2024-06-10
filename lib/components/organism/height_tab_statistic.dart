import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/content_container.dart';
import 'package:stun_sync/components/atom/linear_gauge.dart';
import 'package:stun_sync/components/atom/property_slider.dart';
import 'package:stun_sync/components/atom/title_container.dart';
import 'package:stun_sync/components/atom/unit_container.dart';
import 'package:stun_sync/components/atom/value_container.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class HeightTab extends ConsumerWidget {
  const HeightTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContentContainer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: TitleContainer(
              title: ref.watch(selectedRole.notifier).state == Property.height
                  ? 'Tinggi Badan'
                  : ref.watch(selectedRole.notifier).state == Property.weight
                      ? 'Berat Badan'
                      : 'BMI',
            ),
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              ValueContainer(
                value: ref.watch(selectedRole.notifier).state == Property.height
                    ? ref.watch(userProfileProvider).height.toString()
                    : ref.watch(selectedRole.notifier).state == Property.weight
                        ? ref.watch(userProfileProvider).weight.toString()
                        : ref.watch(userProfileProvider).bmi.toStringAsFixed(2),
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Column(
                children: [
                  const SizedBox(height: 18),
                  UnitContainer(
                    unit: ref.watch(selectedRole.notifier).state ==
                            Property.height
                        ? 'cm'
                        : ref.watch(selectedRole.notifier).state ==
                                Property.weight
                            ? 'kg'
                            : '', // BMI does not have a unit
                  ),
                ],
              ),
              const Spacer(),
              const LinearGauge(gauge: 1),
              const Padding(padding: EdgeInsets.only(right: 20)),
            ],
          )
        ],
      ),
    );
  }
}

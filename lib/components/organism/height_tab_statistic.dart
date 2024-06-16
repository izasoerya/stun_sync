import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/components/atom/content_container.dart';
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
              title: () {
                switch (ref.watch(selectedRole.notifier).state) {
                  case Property.height:
                    return 'Tinggi Badan';
                  case Property.weight:
                    return 'Berat Badan';
                  default:
                    return 'BMI';
                }
              }(),
            ),
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              ValueContainer(
                value: () {
                  switch (ref.watch(selectedRole.notifier).state) {
                    case Property.height:
                      return ref.watch(userProfileProvider).height.toString();
                    case Property.weight:
                      return ref.watch(userProfileProvider).weight.toString();
                    default:
                      return ref
                          .watch(userProfileProvider)
                          .bmi
                          .toStringAsFixed(2);
                  }
                }(),
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Column(
                children: [
                  const SizedBox(height: 18),
                  UnitContainer(
                    unit: () {
                      switch (ref.watch(selectedRole.notifier).state) {
                        case Property.height:
                          return 'cm';
                        case Property.weight:
                          return 'kg';
                        default:
                          return '';
                      }
                    }(),
                  ),
                ],
              ),
              const Spacer(),
              const Padding(padding: EdgeInsets.only(right: 20)),
            ],
          )
        ],
      ),
    );
  }
}

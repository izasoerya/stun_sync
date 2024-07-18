import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stun_sync/models/user_profile.dart';

final selectedRole = StateProvider<Property>((ref) => Property.height);

class PropertySlider extends ConsumerWidget {
  // final void Function() refresh;
  const PropertySlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRoled = ref.watch(selectedRole);

    return Container(
      width: 300,
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: SegmentedButton<Property>(
        selectedIcon: const Text(''),
        style: SegmentedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
          selectedBackgroundColor: const Color.fromRGBO(34, 87, 152, 1),
          selectedForegroundColor: Colors.white,
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        segments: const <ButtonSegment<Property>>[
          ButtonSegment(
            value: Property.height,
            label: Text('Tinggi'),
          ),
          ButtonSegment(
            value: Property.weight,
            label: Text('Berat'),
          ),
          ButtonSegment(
            value: Property.bmi,
            label: Text('BMI'),
          ),
        ],
        selected: <Property>{selectedRoled},
        onSelectionChanged: (Set<Property> newRole) {
          // refresh();
          ref.watch(selectedRole.notifier).state = newRole.first;
        },
      ),
    );
  }
}

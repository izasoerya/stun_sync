import 'package:flutter/material.dart';
import 'package:stun_sync/models/user_profile.dart';

class PropertySlider extends StatefulWidget {
  const PropertySlider({super.key});

  @override
  State<PropertySlider> createState() => _PropertySliderState();
}

class _PropertySliderState extends State<PropertySlider> {
  Property selectedRole = Property.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
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
            label: Text('Student'),
          ),
          ButtonSegment(
            value: Property.weight,
            label: Text('Teacher'),
          ),
          ButtonSegment(
            value: Property.bmi,
            label: Text('Parent'),
          ),
        ],
        selected: <Property>{selectedRole},
        onSelectionChanged: (Set<Property> newRole) {
          setState(() {
            selectedRole = newRole.first;
          });
        },
      ),
    );
  }
}

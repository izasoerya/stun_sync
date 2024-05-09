import 'package:flutter/material.dart';

enum Role { student, teacher, parent }

class RoleSlider extends StatefulWidget {
  const RoleSlider({super.key});

  @override
  State<RoleSlider> createState() => _RoleSliderState();
}

class _RoleSliderState extends State<RoleSlider> {
  Role selectedRole = Role.student;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: SegmentedButton<Role>(
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
        segments: const <ButtonSegment<Role>>[
          ButtonSegment(
            value: Role.student,
            label: Text('Student'),
          ),
          ButtonSegment(
            value: Role.teacher,
            label: Text('Teacher'),
          ),
          ButtonSegment(
            value: Role.parent,
            label: Text('Parent'),
          ),
        ],
        selected: <Role>{selectedRole},
        onSelectionChanged: (Set<Role> newRole) {
          setState(() {
            selectedRole = newRole.first;
          });
        },
      ),
    );
  }
}

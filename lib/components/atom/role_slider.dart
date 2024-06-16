import 'package:flutter/material.dart';
import 'package:stun_sync/models/user_profile.dart';

class RoleSlider extends StatefulWidget {
  const RoleSlider({super.key, required this.callBackRole});
  final void Function(Role) callBackRole;

  @override
  State<RoleSlider> createState() => _RoleSliderState();
}

class _RoleSliderState extends State<RoleSlider> {
  Role selectedRole = Role.parent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 10),
      child: SegmentedButton<Role>(
        selectedIcon: const Text(''),
        style: SegmentedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
          selectedBackgroundColor: const Color.fromRGBO(128, 237, 153, 1),
          selectedForegroundColor: Color.fromRGBO(34, 87, 122, 1),
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        segments: const <ButtonSegment<Role>>[
          ButtonSegment(
            value: Role.parent,
            label: Text('Orang Tua'),
          ),
          ButtonSegment(
            value: Role.posyandu,
            label: Text('Posyandu'),
          ),
        ],
        selected: <Role>{selectedRole},
        onSelectionChanged: (Set<Role> newRole) {
          setState(() {
            widget.callBackRole(newRole.first);
            selectedRole = newRole.first;
          });
        },
      ),
    );
  }
}

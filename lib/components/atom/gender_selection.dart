import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key, required this.isMale});
  final void Function(bool gender) isMale;

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  String selectedGender = 'Laki-laki';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        value: selectedGender,
        hint: const Text('Select Gender'),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue ?? selectedGender;
            bool genderIsMale = newValue == 'Laki-laki';
            widget.isMale(genderIsMale);
          });
        },
        items: <String>['Laki-laki', 'Perempuan']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text('   $value'),
          );
        }).toList(),
        underline: Container(), // Hide the underline
      ),
    );
  }
}

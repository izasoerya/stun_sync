import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.callBackDate});
  final void Function(DateTime date) callBackDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000), // Adjust based on your requirement
      lastDate: DateTime(2025), // Adjust based on your requirement
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        widget.callBackDate(picked);
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.3,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "${_selectedDate.toLocal()}".split(' ')[0],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

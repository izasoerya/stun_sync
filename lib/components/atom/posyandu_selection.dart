import 'package:flutter/material.dart';
import 'package:stun_sync/service/database_controller.dart';

class PosyanduSelection extends StatefulWidget {
  const PosyanduSelection({super.key, required this.callback});
  final SQLiteDB db = const SQLiteDB();
  final void Function(String posyandu) callback;

  @override
  _PosyanduSelectionState createState() => _PosyanduSelectionState();
}

class _PosyanduSelectionState extends State<PosyanduSelection> {
  String _selectedPosyandu = '';
  late Future<List<String>> _listPosyandu;

  @override
  void initState() {
    super.initState();
    _listPosyandu = widget.db.getPosyanduNames();
    _listPosyandu.then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listPosyandu,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        var items = snapshot.data
                ?.toSet()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList() ??
            [];

        if (_selectedPosyandu.isEmpty && items.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _selectedPosyandu = items.first.value!;
              widget.callback(_selectedPosyandu);
            });
          });
        }

        return Container(
            height: 50,
            width: 310,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: items.any((item) => item.value == _selectedPosyandu)
                    ? _selectedPosyandu
                    : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPosyandu = newValue ?? _selectedPosyandu;
                  });
                },
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.value,
                    child: Row(
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(item.value!),
                        const Spacer(), // This will push the icon to the end
                      ],
                    ),
                  );
                }).toList(),
                isExpanded:
                    true, // Allow the dropdown to expand to accommodate the Row
                elevation: 2,
              ),
            ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stun_sync/service/database_controller.dart'; // Import the sqflite package

class ShowAllUsers extends StatefulWidget {
  final SQLiteDB database;

  const ShowAllUsers({super.key, required this.database});

  @override
  _ShowAllUsersState createState() => _ShowAllUsersState();
}

class _ShowAllUsersState extends State<ShowAllUsers> {
  late Future<List<Map<String, dynamic>>> _fetchUsersFuture;

  @override
  void initState() {
    super.initState();
    _fetchUsersFuture = _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _fetchUsersFuture = _fetchUsers();
            });
          },
          child: const Text('Show Users'),
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchUsersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user['name']),
                      subtitle: Text('Age: ${user['age']}'),
                    );
                  },
                ),
              );
            } else {
              return Container(); // Placeholder for no data
            }
          },
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    final db = await widget.database.openDB();
    final users = await widget.database.showAllUsers(db);
    await widget.database.closeDB(db);
    return users;
  }
}

import 'package:flutter/material.dart';
import 'package:stun_sync/components/atom/download_user.dart';
import 'package:stun_sync/router/page_router.dart';
import 'package:stun_sync/service/database_controller.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  final SQLiteDB sqLiteDB = const SQLiteDB();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 87, 122, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Downloaduser(database: sqLiteDB),
          ),
        ],
      ),
    );
  }
}

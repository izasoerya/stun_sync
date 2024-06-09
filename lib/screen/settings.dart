import 'package:flutter/material.dart';
import 'package:stun_sync/components/organism/log_out.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        color: const Color.fromRGBO(238, 238, 238, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const LogOut(),
            ],
          ),
        ),
      ),
    );
  }
}

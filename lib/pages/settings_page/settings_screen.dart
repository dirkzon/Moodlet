import 'package:bletest/pages/settings_page/design_settings_screen.dart';
import 'package:bletest/pages/settings_page/notification_settings_screen.dart';
import 'package:bletest/pages/settings_page/profile_settings_screen.dart';
import 'package:flutter/material.dart';

import 'bluetooth_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Settings'),
            ),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            const BleutoothSettingsScreen()))),
                child: Row(
                  children: const [Text('Bluetooth'), Spacer(), Text('>')],
                )),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            const NotificationSettingsScreen()))),
                child: Row(
                  children: const [Text('Notifications'), Spacer(), Text('>')],
                )),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ProfileSettingsScreen()))),
                child: Row(
                  children: const [Text('Profile'), Spacer(), Text('>')],
                )),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const DesignSettingsScreen()))),
                child: Row(
                  children: const [Text('Design'), Spacer(), Text('>')],
                )),
            TextButton(
                onPressed: () {},
                child: Row(
                  children: const [Text('Privacy & Data'), Spacer(), Text('>')],
                )),
            TextButton(
                onPressed: () {},
                child: Row(
                  children: const [Text('Terms of use'), Spacer(), Text('>')],
                )),
          ],
        ),
      )
    ]));
  }
}

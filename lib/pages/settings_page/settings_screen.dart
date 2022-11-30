import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text('Settings'),
          ),
          TextButton(
              onPressed: () {},
              child: Row(
                children: const [Text('Notifications'), Spacer(), Text('>')],
              )),
          TextButton(
              onPressed: () {},
              child: Row(
                children: const [Text('Journal'), Spacer(), Text('>')],
              )),
          TextButton(
              onPressed: () {},
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
    );
  }
}

import 'package:flutter/material.dart';

import '../common_components/chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _switchValue = false;

  void _updateSwitch(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppBar(
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
              Text(
                'Hello, Vine',
              ),
              Text(
                'Nice to see you again!',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ])),
        const Spacer(),
        const MoodChart(),
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 24, left: 24),
            child: const Text(
              'Capture your moment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )),
        Container(
          margin: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Capture Moment'),
          ),
        ),
        const Spacer(),
        // Chip(
        //   label: const Text('test'),
        //   deleteIcon: const Icon(Icons.close),
        //   onDeleted: () => print('deleted'),
        // ),
        // SizedBox(width: 340, child: TextFormField()),
        // SizedBox(
        //     width: 340,
        //     child: DropdownButtonFormField(items: [], onChanged: (obj) {})),
        // CupertinoSwitch(value: _switchValue, onChanged: _updateSwitch),
        // const DateTimeSelector(),
      ],
    ));
  }
}

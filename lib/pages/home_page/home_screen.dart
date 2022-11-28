import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Capture Moment'),
          ),
          Chip(
            label: Text('test'),
            deleteIcon: Icon(Icons.close),
            onDeleted: () => print('deleted'),
          ),
          SizedBox(width: 340, child: TextFormField()),
          SizedBox(
              width: 340,
              child: DropdownButtonFormField(items: [], onChanged: (obj) {}))
        ],
      )),
    );
  }
}

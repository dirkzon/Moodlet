import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
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
    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(const Duration(days: 1));

    HiveEntryRepository entry = Provider.of<HiveEntryRepository>(context);

    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              AppBar(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                    Text(
                      'Hello, Stan',
                    ),
                    Text(
                      'Nice to see you again!',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ])),
              const Spacer(),
              Container(
                color: const Color.fromARGB(25, 244, 119, 24),
                child: MoodChart(entry.getEntries(start, end), start, end,
                    Colors.transparent),
              ),
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
              Chip(
                label: const Text('work'),
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => print('deleted'),
              ),
              // SizedBox(width: 340, child: TextFormField()),
              // SizedBox(
              //     width: 340,
              //     child: DropdownButtonFormField(items: [], onChanged: (obj) {})),
              // CupertinoSwitch(value: _switchValue, onChanged: _updateSwitch),
              // const DateTimeSelector(),
            ],
          ))
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../common_components/chart.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(const Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    HiveEntryRepository entry = Provider.of<HiveEntryRepository>(context);

    return Scaffold(
        body: Column(
      children: [
        AppBar(
          title: const Text('Moodl Journal'),
          backgroundColor: Colors.transparent,
        ),
        const Spacer(),
        Container(
          color: const Color.fromARGB(25, 244, 119, 24),
          child: Column(
            children: [
              MoodChart(entry.getEntries(start, end), start, end, Colors.white)
            ],
          ),
        ),
        const Spacer(),
      ],
    ));
  }
}

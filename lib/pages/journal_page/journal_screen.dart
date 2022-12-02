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
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
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
                    MoodChart(
                        entry.getEntries(DateTime.parse("2022-10-13"),
                            DateTime.parse("2022-10-14")),
                        DateTime.parse("2022-10-13"),
                        (DateTime.parse("2022-10-14")),
                        Colors.white),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.all(24),
                child: const Text(
                  'Todays moments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Text('Capture a new moment',
                            style: TextStyle(fontSize: 16)),
                        Spacer(),
                        Icon(Icons.arrow_forward),
                      ],
                    )),
              ),
              const Spacer(),
            ],
          ))
    ]));
  }
}

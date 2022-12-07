import 'package:bletest/pages/common_components/horizontal_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../common_components/chart.dart';
import '../common_components/month_selector.dart';
import '../common_components/timeframe_slector.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(const Duration(days: 1));

  late int daysInMonth;
  Duration timeFrame = const Duration(days: 1);

  @override
  void initState() {
    super.initState();
    daysInMonth = DateUtils.getDaysInMonth(start.year, start.month);
  }

  _setMonth(int m) {
    setState(() {
      start = DateTime(start.year, m, start.day);
      daysInMonth = DateUtils.getDaysInMonth(start.year, start.month);
      _addTimeFrameToEnd();
    });
  }

  _setDay(int d) {
    setState(() {
      start = DateTime(start.year, start.month, d);
      _addTimeFrameToEnd();
    });
  }

  _setTimeFrame(String t) {
    setState(() {
      switch (t) {
        case "Day":
          timeFrame = const Duration(days: 1);
          _addTimeFrameToEnd();

          break;
        case "Week":
          timeFrame = const Duration(days: 7);
          _addTimeFrameToEnd();
          break;
        case "Month":
          timeFrame = Duration(days: daysInMonth);
          _addTimeFrameToEnd();
          break;
      }
    });
  }

  _addTimeFrameToEnd() {
    end = start.add(timeFrame);
  }

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
              TimeFrameSelector(((value) => _setTimeFrame(value!))),
              const Spacer(),
              Container(
                color: const Color.fromARGB(25, 244, 119, 24),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 21, top: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MonthSelector(
                                start.month, (value) => _setMonth(value!)),
                          ],
                        )),
                    HorizontalNumberPicker(
                      selected: start.day - 1,
                      count: daysInMonth,
                      onChanged: (value) => _setDay(value!),
                    ),
                    MoodChart(
                        entry.getEntries(start, end), start, end, Colors.white),
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

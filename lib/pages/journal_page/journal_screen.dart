import 'package:bletest/pages/common_components/horizontal_number_picker.dart';
import 'dart:ffi';

import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../moment/moment_manager.dart';
import '../common_components/month_selector.dart';
import '../common_components/timeframe_slector.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../../comms/hive/adaptors/hiveMomentRepository.dart';
import '../common_components/chart.dart';
import '../common_components/year_selector.dart';
import '../moment/add_moment_screen.dart';
import '../moment/moment_details_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late DateTime start;
  late DateTime end;

  late int daysInMonth;
  Duration timeFrame = const Duration(days: 1);

  String momentText = 'Todays moments';

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    start = DateTime(now.year, now.month, now.day);
    end = start.add(const Duration(days: 1));

    daysInMonth = DateUtils.getDaysInMonth(start.year, start.month);
  }

  _setYear(int y) {
    setState(() {
      start = DateTime(y, start.month, start.day);
      daysInMonth = DateUtils.getDaysInMonth(start.year, start.month);
      _addTimeFrameToEnd();
    });
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
          momentText = 'Todays moments';
          break;
        case "Week":
          timeFrame = const Duration(days: 7);
          _addTimeFrameToEnd();
          momentText = 'This weeks moments';
          break;
        case "Month":
          timeFrame = Duration(days: daysInMonth);
          _addTimeFrameToEnd();
          momentText = 'This months moments';
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
    HiveMomentRepository repository =
        Provider.of<HiveMomentRepository>(context);

    MomentManager manager = Provider.of<MomentManager>(context);

    List<HiveMoment> moments = repository.getMoments(start, end);

    updateMoments() {
      // By calling this function, the state is manipulated into thinking a variable has been changed, and will then proceed to
      // reload the UI, also reloading the list of moments.
      _setDay(start.day);
    }

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
                            YearSelector(
                                start.year, (value) => _setYear(value!)),
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
                child: Text(
                  momentText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: moments
                    .map((e) => Container(
                        height: 85,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24.0),
                        child: Card(
                            child: Row(children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12, left: 12),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              //Time element
                              SizedBox(
                                width: 40,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          DateFormat('HH:mm')
                                              .format(e.startDate),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text("-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text(
                                          DateFormat('HH:mm').format(e.endDate),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ]),
                              ),

                              // Moodle
                              Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 3,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                child: Icon(Icons.close),
                              ),
                            ]),
                          ),

                          // Title and location
                          Expanded(
                            child: Container(
                              // width: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                  ),
                                  Text(
                                    e.location,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Spacer(),

                          //Details button
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_right_outlined),
                              iconSize: 35,
                              color: Colors.grey,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            MomentDetailsScreen(
                                              momentId: e.key,
                                            )))).then((_) {
                                  updateMoments();
                                });
                              }),
                        ]))))
                    .toList(),
              ),
              Container(
                margin: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    onPressed: () {
                      manager.setStartDate(start);
                      manager.setEndDate(start);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const AddMomentScreen()))).then((_) {
                        updateMoments();
                      });
                    },
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

import 'dart:ffi';

import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:bletest/moment/momentEnums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../common_components/chart.dart';

HiveMoment moment1 = new HiveMoment(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 2)),
    name: "Browsing model trains",
    location: "Home",
    pleasure: Pleasure.pleased,
    arousal: Arousal.calm,
    dominance: Dominance.neutral,
    additionalNotes:
        "this afternoon i browsed the internet for model trains from the year 1988, some of which i want to purchase to add to my collection.");
HiveMoment moment2 = new HiveMoment(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 2)),
    name: "Sports",
    location: "Track field",
    pleasure: Pleasure.neutral,
    arousal: Arousal.wideAwake,
    dominance: Dominance.independent,
    additionalNotes:
        "after dinner i decided to go for a run on the track field, there were some others running as well.");
List<HiveMoment> dummyMoments = [moment1, moment2];

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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: dummyMoments
                    .map((e) => Container(
                        height: 85,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24.0),
                        child: Card(
                            child: Row(children: [
                          //Time element
                          Spacer(),
                          Column(children: [
                            Spacer(),
                            Text(DateFormat('HH:mm').format(e.startDate),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey)),
                            Text("-",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey)),
                            Text(DateFormat('HH:mm').format(e.endDate),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.grey)),
                            Spacer()
                          ]),

                          Spacer(),

                          // Moodle
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 3,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            child: Icon(Icons.close),
                          ),

                          Spacer(),

                          // Title and location
                          Container(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text(
                                  e.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(
                                  e.location,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.grey),
                                ),
                                Spacer()
                              ],
                            ),
                          ),

                          Spacer(),

                          //Details button
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_right_outlined),
                            iconSize: 35,
                            color: Colors.grey,
                            onPressed: () {},
                          ),
                        ]))))
                    .toList(),
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

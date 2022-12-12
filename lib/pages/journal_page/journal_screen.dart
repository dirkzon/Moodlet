import 'dart:ffi';

import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:bletest/moment/momentEnums.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../../comms/hive/adaptors/hiveMomentRepository.dart';
import '../common_components/chart.dart';
import '../moment/add_moment_screen.dart';
import '../moment/moment_details_screen.dart';

HiveMoment moment = new HiveMoment(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 2)),
    name: "After Gym",
    location: "Basic Fit",
    pleasure: Pleasure.pleased.index,
    arousal: Arousal.calm.index,
    dominance: Dominance.neutral.index,
    additionalNotes:
        "Had a super exhausting gym session today, but I can feel myself getting more and more pumped as I finished cardio. I have to sustain myself from getting ice cream or any other sweets.");
HiveMoment moment2 = new HiveMoment(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 2)),
    name: "Browsing model trains",
    location: "Home",
    pleasure: Pleasure.pleased.index,
    arousal: Arousal.calm.index,
    dominance: Dominance.neutral.index,
    additionalNotes:
        "this afternoon i browsed the internet for model trains from the year 1988, some of which i want to purchase to add to my collection.");
HiveMoment moment3 = new HiveMoment(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 2)),
    name: "Sports",
    location: "Track field",
    pleasure: Pleasure.neutral.index,
    arousal: Arousal.wideAwake.index,
    dominance: Dominance.independent.index,
    additionalNotes:
        "after dinner i decided to go for a run on the track field, there were some others running as well.");
List<HiveMoment> dummyMoments = [moment, moment2, moment3];

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    HiveEntryRepository entry = Provider.of<HiveEntryRepository>(context);
    HiveMomentRepository repository =
        Provider.of<HiveMomentRepository>(context);

    DateTime now = DateTime.now();
    DateTime start = new DateTime(now.year, now.month, now.day);
    DateTime end = start.add(const Duration(days: 1));

    List<HiveMoment> moments = repository.getMoments(start, end);

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
                children: moments
                    .map((e) => Container(
                        height: 85,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24.0),
                        child: Card(
                            child: Row(children: [
                          Container(
                            margin: EdgeInsets.only(right: 12, left: 12),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              //Time element
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        DateFormat('HH:mm').format(e.startDate),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.grey)),
                                    Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.grey)),
                                    Text(DateFormat('HH:mm').format(e.endDate),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Colors.grey)),
                                  ]),

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
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => MomentDetailsScreen(
                                          momentId: e.key,
                                        )))),
                          ),
                        ]))))
                    .toList(),
              ),
              Container(
                margin: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AddMomentScreen()))),
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

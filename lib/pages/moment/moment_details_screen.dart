import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:bletest/moment/momentEnums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../../comms/hive/adaptors/hiveMomentRepository.dart';

class MomentDetailsScreen extends StatefulWidget {
  var momentId;
  MomentDetailsScreen({this.momentId});

  @override
  _MomentDetailsScreenState createState() => _MomentDetailsScreenState();
}

class _MomentDetailsScreenState extends State<MomentDetailsScreen> {
  var momentId;
  // var moment = new HiveMoment(
  //     startDate: DateTime.now(),
  //     endDate: DateTime.now().add(const Duration(hours: 2)),
  //     name: "After Gym",
  //     location: "Basic Fit",
  //     pleasure: Pleasure.pleased.index,
  //     arousal: Arousal.calm.index,
  //     dominance: Dominance.neutral.index,
  //     additionalNotes:
  //         "Had a super exhausting gym session today, but I can feel myself getting more and more pumped as I finished cardio. I have to sustain myself from getting ice cream or any other sweets.");

  @override
  Widget build(BuildContext context) {
    HiveEntryRepository entry = Provider.of<HiveEntryRepository>(context);
    HiveMomentRepository momentRepo =
        Provider.of<HiveMomentRepository>(context);

    var moment = momentRepo.getMoment(momentId);

    @override
    void initState() {
      super.initState();
      momentId = widget.momentId;
    }

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(moment.name),
              Text(
                moment.location,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ))
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  // Date
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMEEEEd().format(moment.startDate),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        Row(
                          children: [
                            Text(
                                DateFormat('HH:mm').format(moment.startDate) +
                                    " - " +
                                    DateFormat('HH:mm').format(moment.endDate),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Visual boxes
                  Container(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 48.0),
                    child: Row(
                      children: [
                        Spacer(),

                        // Mood level
                        Container(
                          height: 160,
                          width: 140,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 3,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          child: Column(
                            children: [
                              Text(
                                "Moodl Level",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16),
                              ),
                              Spacer(),
                              Text(
                                "67",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 72),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),

                        // Moodl
                        Container(
                          height: 160,
                          width: 140,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 3,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          child: Icon(
                            Icons.close,
                            size: 55,
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Spacer(),
                  // Notes
                  Expanded(
                    flex: 40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 24.0),
                      color: const Color.fromARGB(25, 244, 119, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notes",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Feeling exausted but motivated!",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            moment.additionalNotes,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Feeling exausted but motivated!",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            moment.additionalNotes,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ]));
  }
}

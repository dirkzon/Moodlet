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
import '../../moment/moment_categories.dart';

class MomentDetailsScreen extends StatefulWidget {
  var momentId;
  MomentDetailsScreen({this.momentId});

  @override
  _MomentDetailsScreenState createState() => _MomentDetailsScreenState();
}

class _MomentDetailsScreenState extends State<MomentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    HiveMomentRepository momentRepo =
        Provider.of<HiveMomentRepository>(context);

    var moment = momentRepo.getMoment(widget.momentId);

    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(moment.name),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 6),
                    child: Row(
                        children: moment.categories
                            .map<Widget>((e) => Icon(
                                  momentCategories
                                      .firstWhere((cat) => cat.name == e)
                                      .icon,
                                  size: 20,
                                  color: Colors.lightGreen,
                                ))
                            .toList()),
                  ),
                  Text(
                    moment.location,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.grey),
                  ),
                ],
              )
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
                          height: 180,
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
                              moment.averageMM == 0
                                  ? Icon(
                                      Icons.remove,
                                      size: 55,
                                    )
                                  : Text(
                                      "${moment.averageMM}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 72),
                                    ),
                              Spacer(),
                              if (moment.averageMM != 0)
                                Row(
                                  children: [
                                    Icon(Icons.arrow_downward),
                                    Text("${moment.groundMM}"),
                                    Spacer(),
                                    Icon(Icons.arrow_upward),
                                    Text("${moment.peakMM}"),
                                  ],
                                )
                            ],
                          ),
                        ),
                        Spacer(),

                        // Moodl
                        Container(
                          height: 180,
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
                      width: double.infinity,
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
                            moment.additionalNotes,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ]));
  }
}

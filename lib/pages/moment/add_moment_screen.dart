import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_components/date_time_selector.dart';

class AddMomentScreen extends StatelessWidget {
  const AddMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
              Text(
                'Capture moment',
              ),
              Text(
                'Tell me what happened.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ])),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Give your moment a name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                          SizedBox(
                              width: 340,
                              child: TextField(
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    hintText: 'F.e. meeting at work'),
                              )),
                          SizedBox(height: 10),
                          Text('Where did it happen?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12)),
                          SizedBox(
                              width: 340,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'F.e. Eindhoven',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                ),
                              )),
                          SizedBox(height: 10),
                          Text('Add an icon to your moment',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12)),
                          SizedBox(
                              width: 340,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                ),
                              )),
                          SizedBox(height: 10),
                          Text('When did this happen?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12)),
                          SizedBox(
                              width: 340,
                              child: Row(children: [
                                Text('Start'),
                                Spacer(),
                                DateTimeSelector(
                                  useTime: true,
                                  onChanged: (value) => print(value),
                                )
                              ])),
                          SizedBox(height: 10),
                          SizedBox(
                              width: 340,
                              child: Row(children: [
                                Text('End'),
                                Spacer(),
                                DateTimeSelector(
                                  useTime: true,
                                  onChanged: (value) => print(value),
                                )
                              ])),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.all(24.0),
                            child: ElevatedButton(
                              onPressed: () => {},
                              child: const Text('Next'),
                            ),
                          ),
                        ],
                      )),
                ],
              ))
        ]));
  }
}

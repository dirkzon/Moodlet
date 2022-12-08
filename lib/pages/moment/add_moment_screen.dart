import 'package:bletest/moment/moment_manager.dart';
import 'package:bletest/pages/moment/add_feeling_to_moment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_components/date_time_selector.dart';

class AddMomentScreen extends StatelessWidget {
  const AddMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MomentManager manager = Provider.of<MomentManager>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              ]),
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                manager.clearMoment();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
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
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            onChanged: (value) => manager.setName(value),
                            initialValue: manager.name,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintText: 'F.e. meeting at work'),
                          ),
                          SizedBox(height: 12),
                          Text('Where did it happen?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey)),
                          SizedBox(height: 6),
                          TextFormField(
                            onChanged: (value) => manager.setLocation(value),
                            initialValue: manager.location,
                            decoration: InputDecoration(
                              hintText: 'F.e. Eindhoven',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text('Add an icon to your moment',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey)),
                          SizedBox(height: 6),
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text('When did this happen?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey)),
                          SizedBox(height: 6),
                          Row(children: [
                            Text('Start',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey)),
                            Spacer(),
                            DateTimeSelector(
                              initialValue: manager.startDate,
                              useTime: true,
                              onChanged: (value) =>
                                  manager.setStartDate(value!),
                            )
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            Text(
                              'End',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            Spacer(),
                            DateTimeSelector(
                              initialValue: manager.endDate,
                              useTime: true,
                              onChanged: (value) => manager.setEndDate(value!),
                            )
                          ]),
                        ],
                      )),
                ],
              ))
        ]),
        bottomSheet: Container(
          margin: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          const AddFeelingToMomentScreen()))),
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('Next')]),
          ),
        ));
  }
}

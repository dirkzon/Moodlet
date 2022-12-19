import 'package:bletest/profile/profile_manager.dart';
import 'package:bletest/pages/moment/add_moment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../comms/hive/adaptors/hiveEntryRepository.dart';
import '../common_components/chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails('id', 'name',
          priority: Priority.low, importance: Importance.low));

  @override
  Widget build(BuildContext context) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(const Duration(days: 1));

    HiveEntryRepository entry = Provider.of<HiveEntryRepository>(context);
    ProfileManager profileManager = Provider.of<ProfileManager>(context);

    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              AppBar(
                flexibleSpace: SizedBox(
                  height: 0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: const [
                      Positioned(
                        top: 60,
                        right: 10,
                        child: Image(
                          image: AssetImage('assets/hello.png'),
                          height: 215,
                        ),
                      ),
                    ],
                  ),
                ),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      'Hello, ${profileManager.name}',
                    ),
                    Text(
                      profileManager.isBirthDay
                          ? 'Happy birhtday from moodl!'
                          : 'Nice to see you again!',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ])),
              const Spacer(),
              Container(
                color: const Color.fromARGB(25, 244, 119, 24),
                child: MoodChart(entry.getEntries(start, end), start, end,
                    Colors.transparent),
              ),

              Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 24, left: 24),
                  child: const Text(
                    'Capture your moment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AddMomentScreen()))),
                  child: const Text('Capture Moment'),
                ),
              ),
              const Spacer(),

              // Chip(
              //   label: const Text('work'),
              //   deleteIcon: const Icon(Icons.close),
              //   onDeleted: () => print('deleted'),
              // ),
              // SizedBox(width: 340, child: TextFormField()),
              // DateTimeSelector(
              //   useTime: true,
              //   onChanged: (value) => print(value),
              // ),
            ],
          ))
    ]));
  }
}

import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsManager manager =
        Provider.of<SettingsManager>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Notifications',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          const Text(
                            "All",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffF47918)),
                          ),
                          const Spacer(),
                          CupertinoSwitch(
                            value: manager.allNotifications,
                            onChanged: (value) =>
                                manager.setAllNotifications(value),
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(24),
                          child: const Text(
                            'Specific',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          const Text(
                            "Journal",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffF47918)),
                          ),
                          const Spacer(),
                          CupertinoSwitch(
                            value: manager.journalNotifications,
                            onChanged: (value) =>
                                manager.setJournalNotifications(value),
                          ),
                        ],
                      )),
                  if (manager.journalNotifications)
                    Container(
                        margin: const EdgeInsets.only(left: 24, right: 24),
                        child: Row(children: [
                          const Spacer(),
                          InkWell(
                              onTap: () async {
                                TimeOfDay? time = await showTimePicker(
                                    context: context,
                                    initialTime: manager.reflectionTime,
                                    initialEntryMode:
                                        TimePickerEntryMode.input);
                                if (time == null) return;
                                manager.setReflectionTime(time);
                              },
                              child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          31, 118, 118, 128),
                                      borderRadius: BorderRadius.circular(6.0)),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                        "${manager.reflectionTime.hour} : ${manager.reflectionTime.minute.toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400)),
                                  )))
                        ])),
                ],
              ))
        ]));
  }
}

import 'package:bletest/profile/profile_manager.dart';
import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_components/date_time_selector.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileManager manager = Provider.of<ProfileManager>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 24, bottom: 24),
                              child: const Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 36,
                            width: 343,
                            child: TextFormField(
                              onChanged: (value) => manager.setName(value),
                              initialValue: manager.name,
                              decoration: const InputDecoration(
                                hintText: 'your name',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 24, bottom: 24),
                              child: const Text(
                                'Birth day',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                        ],
                      ),
                      DateTimeSelector(
                          initialValue: manager.birthDay,
                          useTime: false,
                          onChanged: ((value) => manager.setBirthDay(value!))),
                    ],
                  )))
        ]));
  }
}

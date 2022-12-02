import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignSettingsScreen extends StatelessWidget {
  const DesignSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsManager manager = Provider.of<SettingsManager>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Design',
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
                            "Dark mode",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffF47918)),
                          ),
                          const Spacer(),
                          CupertinoSwitch(
                            value: manager.darkMode,
                            onChanged: (value) => manager.setDarkMode(value),
                          ),
                        ],
                      )),
                ],
              ))
        ]));
  }
}

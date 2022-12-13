import 'package:bletest/comms/hive/adaptors/hiveEntryRepository.dart';
import 'package:bletest/comms/hive/adaptors/settingsRepository.dart';
import 'package:bletest/comms/hive/hiveConfig.dart';
import 'package:bletest/notifications/notification_manager.dart';
import 'package:bletest/pages/navigation_page.dart';
import 'package:bletest/pages/theme_config.dart';
import 'package:bletest/sensor/moodmetric_sensor_manager.dart';
import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cron/cron.dart';

import 'ble/bluetooth_manager.dart';

void main() async {
  await HiveConfig.setUp();
  runApp(MoodlApp());
}

class MoodlApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildcontext) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsManager>(
            create: (_) => SettingsManager(HiveSettingsRepository()),
          ),
          ChangeNotifierProvider<BluetoothManager>(
            create: (context) => BluetoothManager(),
          ),
          ChangeNotifierProvider<HiveEntryRepository>(
              create: (_) => HiveEntryRepository()),
          ChangeNotifierProxyProvider<BluetoothManager, SensorManager>(
            create: (BuildContext context) => SensorManager(
                Provider.of<BluetoothManager>(context, listen: false)),
            update: (_, ble, sensor) => sensor!.update(ble),
          ),
          ChangeNotifierProxyProvider<SensorManager, HiveEntryRepository>(
            create: (_) => HiveEntryRepository(),
            update: ((_, sensor, port) {
              port!.update(sensor);
              return port;
            }),
          ),
          ChangeNotifierProxyProvider<SettingsManager, NotificationManager>(
              create: (context) => NotificationManager(
                  Provider.of<SettingsManager>(context, listen: false)),
              update: (_, settings, notifications) {
                notifications!.update(settings);
                return notifications;
              }),
          ChangeNotifierProxyProvider<SettingsManager, HiveSettingsRepository>(
            create: (_) => HiveSettingsRepository(),
            update: (context, settings, repo) {
              repo!.updateSettings(settings);
              return repo;
            },
          ),
        ],
        builder: ((context, child) =>
            Consumer<SettingsManager>(builder: (context, settings, child) {
              SensorManager manager = Provider.of(context);
              final cron = Cron();
              //every 30 minutes
              cron.schedule(Schedule.parse('*/30 * * * *'), () async {
                await manager.downloadData();
              });
              // must initialize notifications
              NotificationManager notifs =
                  Provider.of<NotificationManager>(context);
              HiveSettingsRepository test =
                  Provider.of<HiveSettingsRepository>(context);

              return MaterialApp(
                  title: 'Moodl',
                  theme: ThemeConfig.config(settings),
                  home: const NavigationPage());
            })));
  }
}

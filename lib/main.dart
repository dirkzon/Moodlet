import 'package:bletest/comms/hive/adaptors/hiveEntryRepository.dart';
import 'package:bletest/comms/hive/hiveConfig.dart';
import 'package:bletest/notifications/notification_service.dart';
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
  await NotificationService().init();
  runApp(MoodlApp());
}

class MoodlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsManager>(
            create: (context) => SettingsManager(),
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
        ],
        child: Consumer<SettingsManager>(builder: (_, settings, child) {
          SensorManager manager = Provider.of(_);
          final cron = Cron();
          //every 30 minutes
          cron.schedule(Schedule.parse('*/30 * * * *'), () async {
            manager.downloadData();
          });

          return MaterialApp(
              title: 'Moodl',
              theme: ThemeConfig.config(settings),
              home: const NavigationPage());
        }));
  }
}

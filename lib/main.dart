import 'package:bletest/comms/hive/adaptors/HiveBleDeviceRepository.dart';
import 'package:bletest/comms/hive/adaptors/hiveEntryRepository.dart';
import 'package:bletest/comms/hive/adaptors/hiveProfileRepository.dart';
import 'package:bletest/comms/hive/adaptors/settingsRepository.dart';
import 'package:bletest/comms/hive/hiveConfig.dart';
import 'package:bletest/notifications/notification_manager.dart';
import 'package:bletest/comms/hive/adaptors/hiveMomentRepository.dart';
import 'package:bletest/moment/moment_manager.dart';
import 'package:bletest/pages/navigation_page.dart';
import 'package:bletest/pages/theme_config.dart';
import 'package:bletest/profile/profile_manager.dart';
import 'package:bletest/sensor/moodmetric_sensor_manager.dart';
import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cron/cron.dart';

import 'ble/bluetooth_manager.dart';

void main() async {
  await HiveConfig.setUp();
  runApp(App());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext buildcontext) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsManager>(
            create: (_) => SettingsManager(HiveSettingsRepository()),
          ),
          ChangeNotifierProvider<MomentManager>(
            create: (context) => MomentManager(),
          ),
          ChangeNotifierProvider<BluetoothManager>(
            create: (context) => BluetoothManager(HiveBleDeviceRepository()),
          ),
          ChangeNotifierProvider<HiveEntryRepository>(
              create: (_) => HiveEntryRepository()),
          ChangeNotifierProvider<ProfileManager>(
            create: (_) => ProfileManager(HiveProfileRepository()),
          ),
          ChangeNotifierProvider<HiveMomentRepository>(
              create: (_) => HiveMomentRepository()),
          ChangeNotifierProxyProvider<BluetoothManager, SensorManager>(
            create: (BuildContext context) => SensorManager(
                Provider.of<BluetoothManager>(context, listen: false)),
            update: (_, ble, sensor) => sensor!.update(ble),
          ),
          ChangeNotifierProxyProvider<SensorManager, HiveEntryRepository>(
            create: (_) => HiveEntryRepository(),
            update: ((_, sensor, repo) {
              repo!.update(sensor);
              sensor.clearRecording();
              return repo;
            }),
          ),
          ChangeNotifierProxyProvider<BluetoothManager,
              HiveBleDeviceRepository>(
            create: (_) => HiveBleDeviceRepository(),
            update: ((_, manager, repo) {
              repo!.update(manager);
              return repo;
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
          ChangeNotifierProxyProvider<ProfileManager, HiveProfileRepository>(
            create: (_) => HiveProfileRepository(),
            update: ((_, sensor, repo) {
              repo!.update(sensor);
              return repo;
            }),
          ),
        ],
        builder: ((context, child) =>
            Consumer<SettingsManager>(builder: (context, settings, child) {
              SensorManager manager = Provider.of(context);
              final cron = Cron();
              //every 30 minutes
              cron.schedule(Schedule.parse('*/15 * * * *'), () async {
                await manager.downloadData();
              });
              // must initialize notifications
              NotificationManager notifs =
                  Provider.of<NotificationManager>(context);
              HiveSettingsRepository s =
                  Provider.of<HiveSettingsRepository>(context);
              HiveProfileRepository profile =
                  Provider.of<HiveProfileRepository>(context);

              return MaterialApp(
                  title: 'Moodlet',
                  navigatorKey: navigatorKey,
                  theme: ThemeConfig.config(settings),
                  home: const NavigationPage(
                    initPage: 1,
                  ));
            })));
  }
}

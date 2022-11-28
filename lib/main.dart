import 'package:bletest/comms/hive/adaptors/hiveEntryRepository.dart';
import 'package:bletest/comms/hive/hiveConfig.dart';
import 'package:bletest/pages/ble_page/bluetooth_off_screen.dart';
import 'package:bletest/sensor/moodmetric_sensor_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import 'ble/bluetooth_manager.dart';
import 'pages/ble_page/find_devices_screen.dart';

void main() async {
  await HiveConfig.setUp();
  runApp(MoodlApp());
}

class MoodlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      child: MaterialApp(
        title: 'Moodl',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: StreamBuilder<BluetoothState>(
            stream: FlutterBlue.instance.state,
            initialData: BluetoothState.unknown,
            builder: (c, snapshot) {
              final state = snapshot.data;
              if (state == BluetoothState.on) {
                return const FindDevicesScreen();
              }
              return BluetoothOffScreen(state: state);
            }),
      ),
    );
  }
}

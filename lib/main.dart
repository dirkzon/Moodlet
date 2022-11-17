import 'package:bletest/pages/ble_page/bluetooth_off_screen.dart';
import 'package:bletest/sensor/moodmetric_sensor_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import 'ble/bluetooth_manager.dart';
import 'pages/ble_page/find_devices_screen.dart';

void main() {
  runApp(FlutterApp());
}

// the actuall constructor for the app
class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BluetoothManager>(
          create: (context) => BluetoothManager(),
        ),
      ],
      child: Consumer<BluetoothManager>(
        builder: (context, bleManager, child) {
          return ChangeNotifierProvider<SensorManager>(
            create: (context) => SensorManager(bleManager),
            child: MaterialApp(
              title: 'prototype',
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
        },
      ),
    );
  }
}

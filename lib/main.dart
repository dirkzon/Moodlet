import 'package:flutter/material.dart';
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
      child: MaterialApp(
        title: 'test',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: FindDevicesScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ble/bluetooth_manager.dart';
import '../../sensor/moodmetric_sensor_manager.dart';

class BleutoothSettingsScreen extends StatelessWidget {
  const BleutoothSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BluetoothManager bluetoothProvider = Provider.of<BluetoothManager>(context);
    SensorManager sensorProvidor = Provider.of<SensorManager>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Bluetooth',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(24),
                child: Row(
                  children: const [
                    Text(
                      'Connected device',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
            if (sensorProvidor.connected)
              Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Text(
                        "${sensorProvidor.sensor.baterryLevel} % ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(sensorProvidor.sensor.name),
                      const Spacer(),
                      IconButton(
                          onPressed: () => bluetoothProvider.disconnect(),
                          icon: const Icon(Icons.close))
                    ],
                  )),
            Container(
                margin: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    const Text(
                      'Find Devices',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.black,
                      onPressed: () => bluetoothProvider.scan(),
                      icon: bluetoothProvider.isScanning
                          ? const Icon(Icons.bluetooth_searching)
                          : const Icon(Icons.bluetooth),
                    ),
                  ],
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: bluetoothProvider.availableDevices
                        .where((d) => !d.connected)
                        .length,
                    itemBuilder: ((context, index) {
                      var devices = bluetoothProvider.availableDevices
                          .where((d) => !d.connected);
                      if (devices.isEmpty) {
                        return const Text('no devices found');
                      }
                      var device = devices.toList()[index];
                      return ListTile(
                        title: Text(device.device.name),
                        trailing: TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0.0))),
                          onPressed: () =>
                              bluetoothProvider.connect(device.device.id),
                          child: const Text('connect'),
                        ),
                      );
                    })))
          ],
        ));
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import '../../ble/bluetooth_manager.dart';
import '../../comms/hive/adaptors/HiveBleDeviceRepository.dart';
import '../../sensor/moodmetric_sensor_manager.dart';

class BluetoothSettingsScreen extends StatefulWidget {
  const BluetoothSettingsScreen({super.key});

  @override
  _BluetoothSettingsState createState() => _BluetoothSettingsState();
}

class _BluetoothSettingsState extends State<BluetoothSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    BluetoothManager bluetoothProvider = Provider.of<BluetoothManager>(context);
    SensorManager sensorProvidor = Provider.of<SensorManager>(context);
    HiveBleDeviceRepository devices =
        Provider.of<HiveBleDeviceRepository>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Bluetooth',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: StreamBuilder(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (_, snapshot) {
            BluetoothState bleEnabled = snapshot.data!;
            return Column(
              children: [
                if (bleEnabled != BluetoothState.on)
                  const Text(
                    'Bluetooth is not enabled',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
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
                          disabledColor: Colors.grey,
                          color: Colors.black,
                          onPressed: bleEnabled == BluetoothState.on
                              ? (() => bluetoothProvider.scan())
                              : null,
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
                              onPressed: () async {
                                await bluetoothProvider
                                    .connect(device.device.id);
                                await sensorProvidor.downloadData();
                              },
                              child: const Text('connect'),
                            ),
                          );
                        }))),
                Container(
                    margin: const EdgeInsets.all(24),
                    child: Row(
                      children: const [
                        Text(
                          'Linked device',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: ListView.builder(
                        itemCount: bluetoothProvider.linkedDevices.length,
                        itemBuilder: ((context, index) {
                          var linked = bluetoothProvider.linkedDevices;
                          if (linked.isEmpty) {
                            return const Text('no linked devices found');
                          }
                          var device = linked[index];
                          return ListTile(
                            title: Text(device.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CupertinoSwitch(
                                  value: device.autoConnect,
                                  onChanged: (value) => bluetoothProvider
                                      .setAutoConnect(device.id, value),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(0.0))),
                                  onPressed: () async {
                                    bluetoothProvider.removeLinked(device.id);
                                  },
                                  child: const Text('forget'),
                                ),
                              ],
                            ),
                          );
                        }))),
              ],
            );
          },
        ));
  }
}

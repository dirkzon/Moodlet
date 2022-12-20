import 'package:bletest/ble/bluetooth_manager.dart';
import 'package:bletest/comms/hive/adaptors/hiveEntryRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../sensor/moodmetric_sensor_manager.dart';

class FindDevicesScreen extends StatefulWidget {
  const FindDevicesScreen({super.key});

  @override
  _FindDevicesPageState createState() => _FindDevicesPageState();
}

class _FindDevicesPageState extends State<FindDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    BluetoothManager bluetoothProvider = Provider.of<BluetoothManager>(context);
    SensorManager sensorProvidor = Provider.of<SensorManager>(context);
    HiveEntryRepository entry = Provider.of<HiveEntryRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find devices'),
      ),
      body: Center(
        child: Column(children: [
          const Expanded(
              flex: 0,
              child: ListTile(
                title: Text(
                  'connected ring',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )),
          if (sensorProvidor.connected)
            ListTile(
                trailing: SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Text("${sensorProvidor.sensor.baterryLevel} %"),
                      IconButton(
                          onPressed: () => bluetoothProvider.disconnect(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                title: Text(sensorProvidor.sensor.name)),
          const Divider(thickness: 2, indent: 10, endIndent: 10),
          Expanded(
              flex: 0,
              child: ListTile(
                trailing: IconButton(
                  color: Colors.black,
                  onPressed: () => bluetoothProvider.scan(),
                  icon: bluetoothProvider.isScanning
                      ? const Icon(Icons.bluetooth_searching)
                      : const Icon(Icons.bluetooth),
                ),
                title: const Text('discover rings',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              )),
          Expanded(
              child: ListView.builder(
                  itemCount: bluetoothProvider.availableDevices
                      .where((d) => !d.connected)
                      .length,
                  itemBuilder: ((context, index) {
                    var devices = bluetoothProvider.availableDevices
                        .where((d) => !d.connected);
                    var device = devices.toList()[index];
                    return ListTile(
                      title: Text(device.device.name),
                      trailing: TextButton(
                        onPressed: () =>
                            bluetoothProvider.connect(device.device.id),
                        child: const Text('connect'),
                      ),
                    );
                  }))),
          const Divider(thickness: 2, indent: 10, endIndent: 10),
          if (sensorProvidor.connected)
            Expanded(
                child: IconButton(
                    onPressed: () async => await sensorProvidor.downloadData(),
                    icon: const Icon(Icons.download))),
          LinearProgressIndicator(
            value: sensorProvidor.progress,
          ),
        ]),
      ),
    );
  }
}

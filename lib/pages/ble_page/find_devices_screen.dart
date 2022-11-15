import 'package:bletest/ble/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindDevicesScreen extends StatefulWidget {
  @override
  _FindDevicesPageState createState() => _FindDevicesPageState();
}

class _FindDevicesPageState extends State<FindDevicesScreen> {
  @override
  Widget build(BuildContext context) {
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
          if (context.watch<BluetoothManager>().connected)
            ListTile(
                trailing: SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Text(
                          "${context.watch<BluetoothManager>().connecedSensor.baterryLevel} %"),
                      IconButton(
                          onPressed: () =>
                              context.read<BluetoothManager>().disconnect(),
                          icon: Icon(Icons.close))
                    ],
                  ),
                ),
                title: Text(
                    context.watch<BluetoothManager>().connecedSensor.name)),
          const Divider(thickness: 2, indent: 10, endIndent: 10),
          Expanded(
              flex: 0,
              child: ListTile(
                trailing: IconButton(
                  color: Colors.black,
                  onPressed: () => context.read<BluetoothManager>().scan(),
                  icon: context.watch<BluetoothManager>().isScanning
                      ? const Icon(Icons.bluetooth_searching)
                      : const Icon(Icons.bluetooth),
                ),
                title: const Text('discover rings',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              )),
          Expanded(
              child: ListView.builder(
                  itemCount:
                      context.watch<BluetoothManager>().availableDevices.length,
                  itemBuilder: ((context, index) {
                    var device = context
                        .watch<BluetoothManager>()
                        .availableDevices[index];
                    return ListTile(
                      title: Text(device.name),
                      trailing: TextButton(
                        onPressed: () =>
                            context.read<BluetoothManager>().connect(device.id),
                        child: const Text('connect'),
                      ),
                    );
                  }))),
          const Divider(thickness: 2, indent: 10, endIndent: 10),
        ]),
      ),
    );
  }
}

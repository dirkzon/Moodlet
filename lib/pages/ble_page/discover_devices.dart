import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ble/bluetooth_manager.dart';

class DiscoveredDevices extends StatefulWidget {
  @override
  State<DiscoveredDevices> createState() => _DeiscoveredDevicesState();
}

class _DeiscoveredDevicesState extends State<DiscoveredDevices> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                var device =
                    context.watch<BluetoothManager>().availableDevices[index];
                return ListTile(
                  title: Text(device.device.name),
                  trailing: TextButton(
                    onPressed: () => context
                        .read<BluetoothManager>()
                        .connect(device.device.id),
                    child: const Text('connect'),
                  ),
                );
              })))
    ]);
  }
}

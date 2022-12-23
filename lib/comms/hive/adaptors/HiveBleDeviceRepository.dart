import 'package:bletest/ble/bluetooth_manager.dart';
import 'package:bletest/comms/hive/models/hiveBleDevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class HiveBleDeviceRepository with ChangeNotifier {
  Box<HiveBleDevice> box = Hive.box<HiveBleDevice>("bleDevices");

  List<HiveBleDevice> getLinkedDevices() {
    return box.values.toList();
  }

  _isSaved(String id) {
    var devices = box.values.where((d) => d.id == id);
    return devices.isNotEmpty;
  }

  bool _ifAutoConnectIsChanged(String id, bool value) {
    var device = box.values.firstWhere((d) => d.id == id);
    return device.autoConnect != value;
  }

  update(BluetoothManager manager) {
    for (var device in manager.linkedDevices) {
      if (!_isSaved(device.id)) {
        saveDevice(HiveBleDevice(
            id: device.id.toString(),
            name: device.name,
            autoConnect: device.autoConnect));
      } else if (_ifAutoConnectIsChanged(device.id, device.autoConnect)) {
        updateDevice(HiveBleDevice(
            id: device.id.toString(),
            name: device.name,
            autoConnect: device.autoConnect));
      }
    }
    for (var linkedDevice in box.values) {
      if (!manager.linkedDevices.map((d) => d.id).contains(linkedDevice.id)) {
        removeDevice(linkedDevice.id);
      }
    }
  }

  updateDevice(HiveBleDevice device) {
    debugPrint('updating device with id: "${device.id}"');
    box.put(device.id, device);
  }

  saveDevice(HiveBleDevice device) {
    debugPrint('saving device with id: "${device.id}"');
    box.put(device.id, device);
  }

  removeDevice(String id) {
    debugPrint('removing device with id: "$id"');
    box.delete(id);
  }
}

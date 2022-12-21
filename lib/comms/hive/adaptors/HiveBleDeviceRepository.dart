import 'dart:math';

import 'package:bletest/comms/hive/models/hiveBleDevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../../sensor/moodmetric_sensor_manager.dart';

class HiveBleDeviceRepository with ChangeNotifier {
  Box<HiveBleDevice> box = Hive.box<HiveBleDevice>("bleDevices");

  List<HiveBleDevice> getLinkedDevices() {
    return box.values.toList();
  }

  _isSaved(String id) {
    var devices = box.values.where((d) => d.id == id);
    return devices.isNotEmpty;
  }

  update(SensorManager manager) {
    if (!_isSaved(manager.sensor.id.toString())) {
      debugPrint('saving device with id: "${manager.sensor.id}"');
      saveDevice(HiveBleDevice(id: manager.sensor.id.toString()));
    } else {
      debugPrint('device with id: "${manager.sensor.id}" already saved');
    }
  }

  saveDevice(HiveBleDevice device) {
    box.add(device);
  }
}

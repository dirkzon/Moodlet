import 'package:bletest/recording/combodata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../ble/bluetooth_manager.dart';
import '../recording/recording.dart';
import 'moodmetric.dart';

class SensorManager with ChangeNotifier {
  bool connected = false;
  late Moodmetric sensor;
  late Recording recording;
  double progress = 0;

  SensorManager(BluetoothManager bleManager) {
    bleManager.addListener(() async {
      await _updateSensor(bleManager);
    });
  }

  _updateSensor(BluetoothManager manager) async {
    var connectedDevice =
        manager.availableDevices.where((device) => device.connected);
    if (connectedDevice.isEmpty) {
      connected = false;
      return;
    }

    var device = connectedDevice.first;
    List<BluetoothService> services = await device.device.discoverServices();
    List<BluetoothCharacteristic> chars = [];
    for (var service in services) {
      chars.addAll(service.characteristics);
    }

    sensor =
        Moodmetric(chars, device.device.id, device.device.name, device.device);
    await sensor.setBatteryLevel();
    connected = true;
    notifyListeners();
  }

  downloadData() async {
    int startAddress = 0;

    progress = 0;
    int endAddress = await sensor.getFlashState();
    await sensor.setCommandModeReading(startAddress);
    while (startAddress < endAddress) {
      startAddress = await sensor.readMmData(startAddress);
      _setProgress(startAddress, endAddress);
      notifyListeners();
    }
    ComboData combo = await sensor.getComboData();
    await sensor.resetCommandMode();
    recording = await sensor.decodeBuffer();
    recording.aA = combo.aA;
    await sensor.setReferenceTime();
    await sensor.removeFlash();
  }

  _setProgress(int start, int end) {
    progress = (start / end);
  }
}

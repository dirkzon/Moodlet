import 'package:bletest/recording/combodata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../ble/bluetooth_manager.dart';
import '../recording/recording.dart';
import 'moodmetric.dart';

class SensorManager with ChangeNotifier {
  bool downloading = false;
  bool connected = false;
  late Moodmetric sensor;
  Recording recording = Recording([]);
  double progress = 0;

  SensorManager(BluetoothManager bleManager) {
    _updateSensor(bleManager);
  }

  SensorManager update(BluetoothManager manager) {
    _updateSensor(manager);
    return this;
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

  clearRecording() {
    recording.sessions = [];
  }

  downloadData() async {
    if (connected) {
      if (!downloading) {
        debugPrint('downloading data from ring');
        downloading = false;
        int startAddress = 0;

        progress = 0;
        int endAddress = await sensor.getFlashState();
        await sensor.setCommandModeReading(startAddress);
        print(endAddress);
        print('before');
        if (endAddress > 0) {
          while (startAddress < endAddress) {
            startAddress = await sensor.readMmData(startAddress);
            _setProgress(startAddress, endAddress);
          }
          ComboData combo = await sensor.getComboData();
          await sensor.resetCommandMode();
          recording = await sensor.decodeBuffer();
          recording.aA = combo.aA;
          await sensor.setReferenceTime();
          if (recording.sessions.isNotEmpty) {
            await sensor.removeFlash();
          }
          downloading = false;
          notifyListeners();
          debugPrint('finished downloading');
        }
      } else {
        debugPrint('already downloading');
      }
    } else {
      debugPrint('tried downloading but ring not connected');
    }
  }

  _setProgress(int start, int end) {
    progress = (start / end);
  }
}

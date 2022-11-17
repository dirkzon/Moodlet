import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'moodmetricDevice.dart';

const uuidMoodmetricService = "dd499b70-e4cd-4988-a923-a7aab7283f8e";

class BluetoothManager with ChangeNotifier {
  bool isScanning = false;

  List<MoodmetricDevice> availableDevices = [];

  FlutterBlue flutterBlue = FlutterBlue.instance;

  scan() async {
    if (isScanning) {
      await flutterBlue.stopScan();
      _setScanning(false);
    }

    _setScanning(true);
    availableDevices = [];

    List<ScanResult> results =
        await flutterBlue.startScan(timeout: const Duration(seconds: 4));
    for (ScanResult r in results) {
      if (r.advertisementData.serviceUuids.contains(uuidMoodmetricService)) {
        availableDevices.add(MoodmetricDevice(r.device));
      }
    }
    notifyListeners();

    await flutterBlue.stopScan();
    _setScanning(false);
  }

  _setScanning(bool value) {
    isScanning = value;
    notifyListeners();
  }

  connect(id) async {
    var device =
        availableDevices.where(((device) => device.device.id == id)).first;
    await device.device.connect();
    device.connected = true;
    notifyListeners();
  }

  disconnect() async {
    var device = availableDevices.where(((device) => device.connected)).first;
    await device.device.disconnect();
    device.connected = false;
    notifyListeners();
  }
}

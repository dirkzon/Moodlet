import 'package:bletest/sensor/moodmetric.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

const uuidMoodmetricService = "dd499b70-e4cd-4988-a923-a7aab7283f8e";

class BluetoothManager with ChangeNotifier {
  bool isScanning = false;
  bool connected = false;

  List<BluetoothDevice> availableDevices = [];
  late Moodmetric connecedSensor;

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
        availableDevices.add(r.device);
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

  BluetoothDevice? _getDevice(id) {
    for (BluetoothDevice d in availableDevices) {
      if (d.id == id) {
        return d;
      }
    }
    return null;
  }

  connect(id) async {
    BluetoothDevice? device = _getDevice(id);
    await device!.connect();

    List<BluetoothService> services = await device.discoverServices();
    List<BluetoothCharacteristic> chars = [];
    for (var service in services) {
      chars.addAll(service.characteristics);
    }

    connecedSensor = Moodmetric(chars, id, device.name, device);
    await connecedSensor.setBatteryLevel();
    availableDevices = [];
    connected = true;
    notifyListeners();
  }

  disconnect() async {
    connecedSensor.peripheral.disconnect();
    connected = false;
    notifyListeners();
  }
}

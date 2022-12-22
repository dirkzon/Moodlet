import 'package:bletest/ble/linkedDevice.dart';
import 'package:bletest/comms/hive/adaptors/HiveBleDeviceRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'moodmetricDevice.dart';

const uuidMoodmetricService = "dd499b70-e4cd-4988-a923-a7aab7283f8e";

class BluetoothManager with ChangeNotifier {
  bool isScanning = false;

  List<MoodmetricDevice> availableDevices = [];
  List<LinkedDevice> linkedDevices = [];

  FlutterBlue flutterBlue = FlutterBlue.instance;

  BluetoothManager(HiveBleDeviceRepository repo) {
    _setLinked(repo);

    _isBluetoothOn().then((connected) {
      if (connected == true) {
        _connectLinkedDevices();
      }
    });
  }

  update(HiveBleDeviceRepository repo) {
    _setLinked(repo);
  }

  _setLinked(HiveBleDeviceRepository repo) {
    linkedDevices = repo
        .getLinkedDevices()
        .map((d) => LinkedDevice(d.id, d.name, d.autoConnect))
        .toList();
  }

  removeLinked(String id) {
    int index =
        linkedDevices.indexOf(linkedDevices.firstWhere((d) => d.id == id));
    if (index != -1) {
      linkedDevices.removeAt(index);
    }
    notifyListeners();
  }

  Future<bool> _isBluetoothOn() async {
    return await flutterBlue.isOn;
  }

  _connectLinkedDevices() async {
    debugPrint('trying to connect to linked device');
    if (linkedDevices.isNotEmpty) {
      if (linkedDevices.map((d) => d.autoConnect).contains(true)) {
        isScanning = true;
        List<ScanResult> results =
            await flutterBlue.startScan(timeout: const Duration(seconds: 4));
        for (ScanResult r in results) {
          if (r.advertisementData.serviceUuids
              .contains(uuidMoodmetricService)) {
            var deviceToConnect =
                linkedDevices.firstWhere((device) => device.autoConnect);
            if (r.device.id.toString() == deviceToConnect.id) {
              availableDevices.add(MoodmetricDevice(r.device));
              connect(r.device.id);
              isScanning = false;
              break;
            }
          }
        }
        isScanning = false;
      } else {
        debugPrint('no linked devices have autoconnect enabled');
      }
    } else {
      debugPrint('no linked devices');
    }
  }

  scan() async {
    if (isScanning) {
      await flutterBlue.stopScan();
      _setScanning(false);
    }

    _setScanning(true);
    debugPrint('scanning for devices');
    disconnect();
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
    debugPrint('connecting to device with id:"$id"');
    var device =
        availableDevices.where(((device) => device.device.id == id)).first;
    await device.device.connect();
    device.connected = true;
    if (!linkedDevices.map((e) => e.id).contains(id.toString())) {
      bool hasAutoConnect =
          linkedDevices.map((e) => e.autoConnect).contains(true);
      linkedDevices.add(
          LinkedDevice(id.toString(), device.device.name, !hasAutoConnect));
    }
    notifyListeners();
  }

  disconnect() async {
    var connectedDevices =
        availableDevices.where(((device) => device.connected));
    if (connectedDevices.isNotEmpty) {
      debugPrint('disconnecting from device');
      var sensor = connectedDevices.first;
      await sensor.device.disconnect();
      sensor.connected = false;
      notifyListeners();
    }
  }

  setAutoConnect(String id, bool value) {
    if (value) {
      for (var d in linkedDevices) {
        d.autoConnect = false;
      }
    }
    linkedDevices.where((d) => d.id == id).first.autoConnect = value;
    notifyListeners();
  }
}

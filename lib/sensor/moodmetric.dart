import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../recording/combodata.dart';
import '../recording/recording.dart';

class Moodmetric {
  late DeviceIdentifier id;
  late int baterryLevel = 0;
  late String name;
  late BluetoothDevice peripheral;

  static const uuidCharacteristicCommandMode =
      "db321950-97c1-4767-b255-982fe3030b2b";
  static const uuidCharacteristicFlashState =
      "96e964d0-c86f-11e3-9c1a-0800200c9a66";
  static const uuidCharacteristicData = "72741c00-a685-11e3-a5e2-0800200c9a66";
  static const uuidCharacteristicDateTime =
      "941f5032-9c7a-11e3-8d05-425861b86ab6";
  static const uuidCharacteristicCombo = "90bd4fd0-4309-11e4-916c-0800200c9a66";
  static const uuidCaharacteristicBatteryLevel =
      "00002a19-0000-1000-8000-00805f9b34fb";

  late BluetoothCharacteristic flashStateCharacteristic;
  late BluetoothCharacteristic commandModeCharacteristic;
  late BluetoothCharacteristic dataCharacterisitc;
  late BluetoothCharacteristic comboCharacteristic;
  late BluetoothCharacteristic dateTimeCharacteristic;
  late BluetoothCharacteristic batteryLevelCharacteristic;
  static const debug = true;

  Moodmetric(List<BluetoothCharacteristic> chars, this.id, this.name,
      this.peripheral) {
    flashStateCharacteristic =
        _getCharacteristic(chars, uuidCharacteristicFlashState);
    commandModeCharacteristic =
        _getCharacteristic(chars, uuidCharacteristicCommandMode);
    dataCharacterisitc = _getCharacteristic(chars, uuidCharacteristicData);
    comboCharacteristic = _getCharacteristic(chars, uuidCharacteristicCombo);
    dateTimeCharacteristic =
        _getCharacteristic(chars, uuidCharacteristicDateTime);
    batteryLevelCharacteristic =
        _getCharacteristic(chars, uuidCaharacteristicBatteryLevel);
  }

  BluetoothCharacteristic _getCharacteristic(
      List<BluetoothCharacteristic> chars, String id) {
    return chars.where((c) => Guid(id) == c.uuid).first;
  }

  Future<void> setBatteryLevel() async {
    var level = await batteryLevelCharacteristic.read();
    baterryLevel = level.first;
  }

  Future<List<int>> _getFlashState() async {
    return await flashStateCharacteristic.read();
  }

  Future<void> _setReferenceTime() async {
    int timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var timeArr = [
      (((timeInMillis >> 24).toInt() & 255)),
      (((timeInMillis >> 16).toInt() & 255)),
      (((timeInMillis >> 8).toInt() & 255)),
      ((timeInMillis & 255).toInt())
    ];
    await dateTimeCharacteristic.write(timeArr);
  }

  Future<Recording> downloadMmData() async {
    var buffer = <int>[];

    //get flashstate for used memory
    var flashState = await _getFlashState();
    int startAddress = 0;
    int endAddress =
        (((flashState[0]) & 255).toInt() << 8) | (flashState[1] & 255).toInt();

    // set command mode for reading
    await commandModeCharacteristic
        .write([startAddress, ((0 >> 8) & 255), (0 & 255)]);

    // read MM data and add to buffer
    while (startAddress < endAddress) {
      var bArr = await dataCharacterisitc.read();
      debugPrint("current address: $startAddress");
      buffer.addAll(bArr.getRange(2, 18));
      startAddress += 16;
    }

    //read combo data
    ComboData comboData = ComboData(await comboCharacteristic.read());

    // reset reading index to 0
    await commandModeCharacteristic.write([1, ((0 >> 8) & 255), (0 & 255)]);

    // decode data buffer
    Recording recording = Recording.decode(buffer);
    recording.aA = comboData.aA;

    // set reference time
    await _setReferenceTime();

    // remove flash from ring
    if (!debug) {
      await commandModeCharacteristic.write([2, ((0 >> 8) & 255), (0 & 255)]);
    }
    return recording;
  }
}

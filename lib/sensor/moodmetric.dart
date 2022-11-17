import 'package:flutter_blue/flutter_blue.dart';

import '../recording/combodata.dart';
import '../recording/recording.dart';

class Moodmetric {
  late DeviceIdentifier id;
  late int baterryLevel = 0;
  late String name;
  late BluetoothDevice peripheral;

  var buffer = <int>[];
  late ComboData comboData;

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
  static const uuidMoodmetricService = "dd499b70-e4cd-4988-a923-a7aab7283f8e";

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
    baterryLevel = (level.first.toInt() & 255);
  }

  setReferenceTime() async {
    int timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var timeArr = [
      (((timeInMillis >> 24).toInt() & 255)),
      (((timeInMillis >> 16).toInt() & 255)),
      (((timeInMillis >> 8).toInt() & 255)),
      ((timeInMillis & 255).toInt())
    ];
    await dateTimeCharacteristic.write(timeArr);
  }

  removeFlash() async {
    if (!debug) {
      await commandModeCharacteristic.write([2, ((0 >> 8) & 255), (0 & 255)]);
    }
  }

  decodeBuffer() async {
    return Recording.decode(buffer);
  }

  resetCommandMode() async {
    await commandModeCharacteristic.write([1, ((0 >> 8) & 255), (0 & 255)]);
  }

  getComboData() async {
    return ComboData(await comboCharacteristic.read());
  }

  setCommandModeReading(int startAddress) async {
    await commandModeCharacteristic
        .write([startAddress, ((0 >> 8) & 255), (0 & 255)]);
  }

  Future<int> getFlashState() async {
    var flashState = await flashStateCharacteristic.read();
    return (((flashState[0]) & 255).toInt() << 8) |
        (flashState[1] & 255).toInt();
  }

  Future<int> readMmData(int startAddress) async {
    var bArr = await dataCharacterisitc.read();
    //debugPrint("current address: $startAddress");
    buffer.addAll(bArr.getRange(2, 18));
    return startAddress + 16;
  }
}

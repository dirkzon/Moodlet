import 'package:flutter_blue/flutter_blue.dart';

class MoodmetricDevice {
  late BluetoothDevice device;
  bool connected = false;

  MoodmetricDevice(this.device);
}

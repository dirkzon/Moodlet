import 'package:flutter/cupertino.dart';

import '../ble/bluetooth_manager.dart';
import '../recording/recording.dart';
import 'moodmetric.dart';

class SensorManager with ChangeNotifier {
  late Moodmetric sensor;
  late Recording recording;
}

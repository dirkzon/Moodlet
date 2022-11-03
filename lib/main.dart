import 'dart:async';
import 'dart:math';

import 'package:bletest/recording/recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bletest/widgets.dart';

import 'recording/combodata.dart';

const UUID_MOODMETRIC_SERVICE = "dd499b70-e4cd-4988-a923-a7aab7283f8e";
const UUID_CHARACTERISTIC_COMMAND_MODE = "db321950-97c1-4767-b255-982fe3030b2b";
const UUID_CHARACTERISTIC_FLASH_STATE = "96e964d0-c86f-11e3-9c1a-0800200c9a66";
const UUID_CHARACTERISTIC_DATA = "72741c00-a685-11e3-a5e2-0800200c9a66";
const UUID_CHARACTERISTIC_DATETIME = "941f5032-9c7a-11e3-8d05-425861b86ab6";
const UUID_CHARACTERISTIC_COMBO = "90bd4fd0-4309-11e4-916c-0800200c9a66";
late BluetoothCharacteristic flashStateCharacteristic;
late BluetoothCharacteristic commandModeCharacteristic;
late BluetoothCharacteristic dataCharacterisitc;
late BluetoothCharacteristic comboCharacteristic;
late BluetoothCharacteristic dateTimeCharacteristic;
const debug = true;

void main() {
  runApp(FlutterBlueApp());
}

// the actuall constructor for the app
class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

// bluetooth off screen
class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// finding devices
class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .where((d) => d.id.id == UUID_MOODMETRIC_SERVICE)
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return TextButton(
                                    child: Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 30)));
          }
        },
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  void _pupulateCharacteristics(List<BluetoothService> services) {
    flashStateCharacteristic =
        _getCharacteristic(UUID_CHARACTERISTIC_FLASH_STATE, services)!;
    commandModeCharacteristic =
        _getCharacteristic(UUID_CHARACTERISTIC_COMMAND_MODE, services)!;
    dataCharacterisitc =
        _getCharacteristic(UUID_CHARACTERISTIC_DATA, services)!;
    comboCharacteristic =
        _getCharacteristic(UUID_CHARACTERISTIC_COMBO, services)!;
    dateTimeCharacteristic =
        _getCharacteristic(UUID_CHARACTERISTIC_DATETIME, services)!;
  }

  BluetoothCharacteristic? _getCharacteristic(
      String id, List<BluetoothService> services) {
    for (var s in services) {
      for (var c in s.characteristics) {
        if (Guid(id) == c.uuid) {
          return c;
        }
      }
    }
    return null;
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

  Future<void> _removeRingFlash() async {
    await commandModeCharacteristic.write([2, ((0 >> 8) & 255), (0 & 255)]);
  }

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  Future<void> _downloadData(List<BluetoothService> services) async {
    _pupulateCharacteristics(services);

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
      print("current address: $startAddress");
      buffer.addAll(bArr.getRange(2, 18));
      startAddress += 16;
    }

    //read combo data
    ComboData comboData = ComboData(await comboCharacteristic.read());

    // reset reading index to 0
    await commandModeCharacteristic.write([1, ((0 >> 8) & 255), (0 & 255)]);

    // decode data buffer
    Recording recording = Recording().decode(buffer);
    recording.aA = comboData.aA;

    // set reference time
    await _setReferenceTime();

    // remove flash from ring
    if (!debug) {
      await _removeRingFlash();
    }
    print(recording);
  }

  // services list
  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write([0], withoutResponse: false);
                      await c.write([1, ((0 >> 8) & 255), (0 & 255)],
                          withoutResponse: false);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bar
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      // contection bar
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),

            // MTU size thing
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),

            // list of services
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () => _downloadData(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

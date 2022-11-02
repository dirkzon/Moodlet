import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bletest/widgets.dart';

const UUID_MOODMETRIC_SERVICE = "dd499b70-e4cd-4988-a923-a7aab7283f8e";
const UUID_CHARACTERISTIC_COMMAND_MODE = "db321950-97c1-4767-b255-982fe3030b2b";
const UUID_CHARACTERISTIC_FLASH_STATE = "96e964d0-c86f-11e3-9c1a-0800200c9a66";
const UUID_CHARACTERISTIC_DATA = "72741c00-a685-11e3-a5e2-0800200c9a66";
const UUID_CHARACTERISTIC_DATETIME = "941f5032-9c7a-11e3-8d05-425861b86ab6";
const UUID_CHARACTERISTIC_COMBO = "90bd4fd0-4309-11e4-916c-0800200c9a66";
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

class Entry {
  late int scrn;
  late int mm;
  late int scl;
  late int steps;

  Entry(this.scrn, this.mm, this.scl, this.steps);
}

class Session {
  late DateTime date;
  late bool valid;
  List<Entry> entries = [];

  Session(this.date, this.valid, this.entries);
}

class ComboData {
  double aA = 0.0;
  double gG = 0.0;
  double mM = 0.0;
  double xX = 0.0;
  double yY = 0.0;
  double zZ = 0.0;

  ComboData(bArr) {
    aA = (((bArr[4] & 255)) * 256) + ((bArr[5] & 255)).toDouble();
    gG = (((bArr[0] & 255)) * 256) + ((bArr[1] & 255)).toDouble();
    mM = (((bArr[2] & 255)) * 256) + ((bArr[3] & 255)).toDouble();
    xX = (((((bArr[6] & 255)) * 256) + ((bArr[7] & 255)) - 32768) / 16384)
        .toDouble();
    yY = (((((bArr[8] & 255)) * 256) + ((bArr[9] & 255)) - 32768) / 16384)
        .toDouble();
    zZ = (((((bArr[10] & 255)) * 256) + ((bArr[11] & 255)) - 32768) / 16384)
        .toDouble();
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  Session? _createSession(List<int> bArr) {
    if (bArr.length < 8) {
      return null;
    }
    bool z = false;
    if ((bArr[0] & 255) == 252) {
      z = true;
    }
    int epoch = (((((bArr[5] & 255) << 0x10) |
                    ((bArr[6] & 255) << 8) |
                    (bArr[7] & 255)) *
                60) +
            (((bArr[1] & 255) << 0x18) |
                ((bArr[2] & 255) << 0x10) |
                ((bArr[3] & 255) << 8) |
                (bArr[4] & 255))) *
        1000;

    List<Entry> entries = [];
    for (int i = 8; i <= bArr.length - 4; i += 4) {
      entries.add(Entry((bArr[i] & 255), (bArr[i + 1] & 255),
          (bArr[i + 2] & 255), (bArr[i + 3] & 255)));
    }
    return Session(
        DateTime.fromMicrosecondsSinceEpoch(epoch * 1000), z, entries);
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
  }

  Future<void> _downloadData(List<BluetoothService> services) async {
    var buffer = <int>[];
    List<Session> sessions = [];

    //1 get flashstate
    var flashState =
        await _getCharacteristic(UUID_CHARACTERISTIC_FLASH_STATE, services)
            ?.read();
    int startAddress = 0;
    int endAddress = (((flashState?[0])! & 255).toInt() << 8) |
        (flashState![1] & 255).toInt();

    //2
    var commandMode =
        _getCharacteristic(UUID_CHARACTERISTIC_COMMAND_MODE, services);

    //3
    await commandMode!.write([startAddress, ((0 >> 8) & 255), (0 & 255)]);
    var dataCharacterisitc =
        _getCharacteristic(UUID_CHARACTERISTIC_DATA, services);

    // read MM data and add to buffer
    while (startAddress < endAddress) {
      var bArr = await dataCharacterisitc!.read();
      print("current address: $startAddress");
      buffer.addAll(bArr.getRange(2, 18));
      startAddress += 16;
    }

    //read combo data
    ComboData comboData = ComboData(
        await _getCharacteristic(UUID_CHARACTERISTIC_COMBO, services)!.read());
    print(comboData.aA);

    // reset reading index to 0
    await commandMode.write([1, ((0 >> 8) & 255), (0 & 255)]);

    // data decoden en sessies aanmaken
    int i = -1;
    for (int i2 = 0; i2 <= buffer.length; i2++) {
      if (i2 == buffer.length ||
          (buffer[i2]).toInt() == 252 ||
          (buffer[i2]).toInt() == 253) {
        if (i != -1) {
          if (i2 - i > 8) {
            var session = _createSession(buffer.getRange(i, i2).toList());
            if (session != null) {
              sessions.add(session);
            }
          }
        }
        i = i2;
      }
    }

    // reference time zetten
    int timeInMillis = DateTime.now().millisecondsSinceEpoch;
    var timeArr = [
      (((timeInMillis >> 24).toInt() & 255)),
      (((timeInMillis >> 16).toInt() & 255)),
      (((timeInMillis >> 8).toInt() & 255)),
      ((timeInMillis & 255).toInt())
    ];
    await _getCharacteristic(UUID_CHARACTERISTIC_DATETIME, services)!
        .write(timeArr);

    //flash van ring verwijderen
    if (!debug) {
      await commandMode.write([2, ((0 >> 8) & 255), (0 & 255)]);
    }
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

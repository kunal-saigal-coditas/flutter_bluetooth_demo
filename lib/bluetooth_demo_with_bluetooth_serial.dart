import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDevicesWithBluetoothSerialScreen extends StatefulWidget {
  const BluetoothDevicesWithBluetoothSerialScreen({super.key});

  @override
  State<BluetoothDevicesWithBluetoothSerialScreen> createState() =>
      _BluetoothDevicesWithBluetoothSerialScreenState();
}

class _BluetoothDevicesWithBluetoothSerialScreenState
    extends State<BluetoothDevicesWithBluetoothSerialScreen> {
  List<BluetoothDevice> _connectedDevices = [];

  @override
  void initState() {
    super.initState();
    _getConnectedDevices();
  }

  Future<void> _getConnectedDevices() async {
    final List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();

    setState(() {
      _connectedDevices = devices;
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    BluetoothConnection connection =
        await BluetoothConnection.toAddress(device.address);
    print("Connected to ${device.name}");
    connection.input!.listen((data) {
      print("Data Received: ${String.fromCharCodes(data)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: _connectedDevices.length,
        itemBuilder: (context, index) {
          final device = _connectedDevices[index];
          return ListTile(
            title: Text(device.name != null ? device.name! : 'Unknown Device'),
            trailing: IconButton(
              icon: const Icon(Icons.link_off),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}

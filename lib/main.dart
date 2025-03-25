import 'package:bluetooth_demo/bluetooth_demo_with_blue_plus_screen.dart';
import 'package:bluetooth_demo/bluetooth_demo_with_bluetooth_serial.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bluetooth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BluetoothDevicesWithBluetoothSerialScreen(),
    );
  }
}

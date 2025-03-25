// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// // class BluetoothDevicesScreenWithBluePlus extends StatefulWidget {
// //   const BluetoothDevicesScreenWithBluePlus({super.key});

// //   @override
// //   State<BluetoothDevicesScreenWithBluePlus> createState() =>
// //       _BluetoothDevicesScreenWithBluePlusState();
// // }

// // class _BluetoothDevicesScreenWithBluePlusState
// //     extends State<BluetoothDevicesScreenWithBluePlus> {
// //   List<BluetoothDevice> _connectedDevices = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     FlutterBluePlus.startScan();

// //     FlutterBluePlus.scanResults.listen((results) {
// //       for (ScanResult r in results) {
// //         print('-- ${r.device.name} found! RSSI: ${r.rssi}');
// //       }
// //     });
// //     _getConnectedDevices();
// //   }

// //   Future<void> _getConnectedDevices() async {
// //     final devices = FlutterBluePlus.connectedDevices;

// //     setState(() {
// //       _connectedDevices = devices;
// //     });
// //   }

// //   Future<void> _disconnectDevice(BluetoothDevice device) async {
// //     await device.disconnect();
// //     _getConnectedDevices();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Connected Bluetooth Devices'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: _connectedDevices.length,
// //         itemBuilder: (context, index) {
// //           final device = _connectedDevices[index];
// //           return ListTile(
// //             title: Text(device.platformName.isNotEmpty
// //                 ? device.platformName
// //                 : 'Unknown Device'),
// //             trailing: IconButton(
// //               icon: const Icon(Icons.link_off),
// //               onPressed: () => _disconnectDevice(device),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// class BluetoothDevicesScreenWithBluePlus extends StatefulWidget {
//   const BluetoothDevicesScreenWithBluePlus({super.key});

//   @override
//   _BluetoothDevicesScreenWithBluePlusState createState() =>
//       _BluetoothDevicesScreenWithBluePlusState();
// }

// class _BluetoothDevicesScreenWithBluePlusState
//     extends State<BluetoothDevicesScreenWithBluePlus> {
//   List<ScanResult> scanResults = [];
//   bool isScanning = false;
//   BluetoothDevice? connectedDevice;
//   List<BluetoothService> services = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _startScan() async {
//     setState(() {
//       scanResults = [];
//       isScanning = true;
//     });

//     FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

//     FlutterBluePlus.scanResults.listen((results) {
//       setState(() {
//         scanResults = results;
//       });
//     });

//     await Future.delayed(Duration(seconds: 5));
//     FlutterBluePlus.stopScan();
//     setState(() => isScanning = false);
//   }

//   Future<void> _connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect();
//       setState(() {
//         connectedDevice = device;
//       });

//       _discoverServices(device);
//     } catch (e) {
//       print("Error connecting: $e");
//     }
//   }

//   Future<void> _discoverServices(BluetoothDevice device) async {
//     List<BluetoothService> discoveredServices = await device.discoverServices();
//     setState(() {
//       services = discoveredServices;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Flutter Blue Plus Example")),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: isScanning ? null : _startScan,
//             child: Text(isScanning ? "Scanning..." : "Scan for Devices"),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: scanResults.length,
//               itemBuilder: (context, index) {
//                 final device = scanResults[index].device;
//                 return ListTile(
//                   title: Text(device.platformName.isNotEmpty
//                       ? device.platformName
//                       : "Unknown"),
//                   subtitle: Text(device.remoteId.toString()),
//                   trailing: ElevatedButton(
//                     onPressed: () => _connectToDevice(device),
//                     child: Text("Connect"),
//                   ),
//                 );
//               },
//             ),
//           ),
//           if (connectedDevice != null) ...[
//             Divider(),
//             Text("Connected to: ${connectedDevice!.platformName}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: services.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text("Service: ${services[index].uuid}"),
//                   );
//                 },
//               ),
//             ),
//           ]
//         ],
//       ),
//     );
//   }
// }

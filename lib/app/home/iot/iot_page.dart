import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common_widgets/list_widget.dart';
import 'index.dart';

class IoTPage extends StatelessWidget {
  final titles = [
    'PhoneInfo',
    'Sensors',
    'Battery',

    /*   'Bluetooth',
    'Video player/bandwidth, images',
    'Camera',
    'MQTT & WebSocket & HTTP, connectivity, networking, offline',
    'google map, other services',
    'ATT cloud APIs/FirstNet APIs',
    'Samsung devices APIs', */
  ];
  final icons = [
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.directions_bus,
    Icons.directions_car,
    Icons.directions_railway,
    Icons.directions_run,
    Icons.directions_subway,
    Icons.directions_transit,
    Icons.directions_walk,
    Icons.directions_transit,
    Icons.directions_walk
  ];

  final pages = [
    PhoneInfo(),
    SensorPage(),
    BatteryPage(),

    /*  FlutterBlueApp(),
    VideoApp(),
    CameraExampleHome(),
    NetworkingPage(),
    NetworkingPage(),
    NetworkingPage(),
    NetworkingPage(), */
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing APIs'),
      ),
      body: StaticListTemplate(
        titles: titles,
        icons: icons,
        pages: pages,
      ),
    );
  }
}

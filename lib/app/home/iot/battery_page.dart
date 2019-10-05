import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'dart:async';

class BatteryPage extends StatefulWidget {
  BatteryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  Battery _battery = Battery();

  BatteryState _batteryState;
  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Status'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text('$_batteryState'),
          SizedBox(
            width: 100,
            height: 200,
            child: Container(),
          ),
          RaisedButton(
            child: const Icon(Icons.battery_unknown),
            onPressed: () async {
              final int batteryLevel = await _battery.batteryLevel;
              showDialog<void>(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Battery: $batteryLevel%'),
                  actions: <Widget>[
                    FlatButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();
    }
  }
}

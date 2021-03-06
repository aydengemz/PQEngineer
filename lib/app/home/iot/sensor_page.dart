import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'snake.dart';

class SensorPage extends StatefulWidget {
  final String ip;

  SensorPage({Key key, @required this.ip}) : super(key: key);
  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {

String _serverAddress = '';
  SharedPreferences prefs;

bool _hasMessage = false;
  bool _hasTopic = false;
  bool _retainValue = false;
  bool _saveNeeded = false;
  int _qosValue = 0;
  String _messageContent;
  String _topicContent = 'hacksensor';

  //String broker = '10.64.6.31';
  mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;
  Set<String> topics = Set<String>();

  List<Message> messages = <Message>[];
ScrollController messageController = ScrollController();


  StreamSubscription subscription;

  static const int _snakeRows = 20;
  static const int _snakeColumns = 20;
  static const double _snakeCellSize = 10.0;
  bool _streaming = false;

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Sensor Example'),
      ), */
      body: 
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
                     begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0, 0.4, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0xff83c1ff),
              //Colors.white,
              Color(0xff6dcff6),
              Color(0xff608fff),
             
            ],
                  ),
        ),
              child: Stack(children: <Widget>[
  Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 30, right: 30, left: 30),
    child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.white),
                  ),
                  child: SizedBox(
                    height: _snakeRows * _snakeCellSize,
                    width: _snakeColumns * _snakeCellSize,
                    child: Snake(
                      rows: _snakeRows,
                      columns: _snakeColumns,
                      cellSize: _snakeCellSize,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20,  bottom: 20),
                child: Center(child: Container(
                  decoration: BoxDecoration(
                     borderRadius:
                                    BorderRadius.all(const Radius.circular(16)),
                                color: Colors.white,
                                 boxShadow: [
                                BoxShadow(
                                  
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius:
                                      10.0, // has the effect of softening the shadow
                                  spreadRadius:
                                      1.0, // has the effect of extending the shadow
                                  offset: Offset(
                                    5.0, // horizontal, move right 10
                                    5.0, // vertical, move down 10
                                  ),
                                )
                              ],
                  ),
                                child: Column(children: <Widget>[
  Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Accelerometer: \n\n $accelerometer'),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                  ),
                  Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('UserAccelerometer: \n\n $userAccelerometer'),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                  ),
                  Padding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Gyroscope: \n\n $gyroscope'),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                  ),
                  ],),
                )),
              ),
            
            ],
          ),
  ),
        Positioned(
                    //Place it at the top, and not use the entire screen
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: AppBar(
                    /*   actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.account_circle),
                          tooltip: 'Show Snackbar',
                          onPressed: () {},
                        ),
                      ], */
                      centerTitle: true,
                      title: Text(
                   'Sensors', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
                    
                      backgroundColor: Colors.transparent,
                      elevation: 0.0, //Shadow gone
                    ),
                ),
        ],),
      ),
    
      //floatingActionButton: FloatingActionButton(onPressed: _toggleStreaming(), child: Text("Toggle Streaming")),);
    ); 
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
_initData() async {
    prefs = await SharedPreferences.getInstance();
    _serverAddress = prefs.getString('server') ?? 'demo.cloudwebrtc.com';
  print(_serverAddress);
  }
  @override
  void initState() {
    super.initState();
    _initData();
    _connect();
    //_subscribeToTopic('hackcmd');

    if (mounted) {
      _streamSubscriptions
          .add(accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          _accelerometerValues = <double>[event.x, event.y, event.z];
          /* String x = event.x.toString();
          _sendMessagex(x);
       
          String z = event.z.toString();
          _sendMessagez(z); */
         // print("message sengt");
        // _messageContent = _accelerometerValues.toString();  
        // _sendMessage();
           String y = event.y.toString();
          _sendMessagey(y);
          });
      }));
      _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          _gyroscopeValues = <double>[event.x, event.y, event.z];
        });
      }));
      _streamSubscriptions
          .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
        setState(() {
          _userAccelerometerValues = <double>[event.x, event.y, event.z];
        });
      }));
    }
  }

  _toggleStreaming() {
    print("toggled");
    _streaming = _streaming ? false: true;
    print(_streaming);
  }
  void _connect() async {
    /// First create a client, the client is constructed with a broker name, client identifier
    /// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
    /// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
    /// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
    /// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
    /// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
    /// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
    /// of 1883 is used.
    /// If you want to use websockets rather than TCP see below.
    print(widget.ip);
    client = mqtt.MqttClient(widget.ip, '');

    /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
    /// for details.
    /// To use websockets add the following lines -:
    // client.useWebSocket = true;

    /// This flag causes the mqtt client to use an alternate method to perform the WebSocket handshake. This is needed for certain
    /// matt clients (Particularly Amazon Web Services IOT) that will not tolerate additional message headers in their get request
    // client.useAlternateWebSocketImplementation = true;
    // client.port = 443; // ( or whatever your WS port is)
    /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.

    /// Set logging on if needed, defaults to off
    client.logging(on: true);

    /// If you intend to use a keep alive value in your connect message that is not the default(60s)
    /// you must set it here
    client.keepAlivePeriod = 30;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = _onDisconnected;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier('Mqtt_atthackathon1005b')
        // Must agree with the keep alive set above or not set
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        // If you set this you must set a will message
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .withWillQos(mqtt.MqttQos.atLeastOnce);
    print('MQTT client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      await client.connect();
    } catch (e) {
      print(e);
      _disconnect();
    }

    /// Check if we are connected
    if (client.connectionState == mqtt.MqttConnectionState.connected) {
      print('MQTT client connected');
      
      setState(() {
        connectionState = client.connectionState;
        _subscribeToTopic('hackcmd');
      });
    } else {
      print('ERROR: MQTT client connection failed - '
          'disconnecting, state is ${client.connectionState}');
      _disconnect();
    }

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.
    subscription = client.updates.listen(_onMessage);
    
  }
  void _disconnect() {
    client.disconnect();
    _onDisconnected();
  }
 void _onDisconnected() {
    setState(() {
      topics.clear();
      connectionState = client.connectionState;
      client = null;
      subscription.cancel();
      subscription = null;
    });
    print('MQTT client disconnected');
  }
  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    print(event.length);
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// The above may seem a little convoluted for users only interested in the
    /// payload, some users however may be interested in the received publish message,
    /// lets not constrain ourselves yet until the package has been in the wild
    /// for a while.
    /// The payload is a byte buffer, this will be specific to the topic
    print('MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- ${message} -->');
    print(client.connectionState);
  showSimpleNotification(Text(message),
                      background: Colors.green);
    

    setState(() {
      messages.add(Message(
        topic: event[0].topic,
        message: message,
        qos: recMess.payload.header.qos,
      ));
      try {
        messageController.animateTo(
          0.0,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      } catch (_) {
        // ScrollController not attached to any scroll views.
      }
    });
  }
   void _subscribeToTopic(String topic) {
     print("In Subscribe");
    if (connectionState == mqtt.MqttConnectionState.connected) {
    
      setState(() {
        //if (topics.add(topic.trim())) {
          print('Subscribing to ${topic.trim()}');
          client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
        }
     // }
      );
    }
  }
   void _unsubscribeFromTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      setState(() {
        if (topics.remove(topic.trim())) {
          print('Unsubscribing from ${topic.trim()}');
          client.unsubscribe(topic);
        }
      });
    }
  }
  void _sendMessage() {
    final mqtt.MqttClientPayloadBuilder builder =
        mqtt.MqttClientPayloadBuilder();

    builder.addString(_messageContent);
    client.publishMessage(
      _topicContent,
      mqtt.MqttQos.values[_qosValue],
      builder.payload,
      retain: _retainValue,
    );
   // Navigator.pop(context);
  }

  void _sendMessagex(String x) {
    final mqtt.MqttClientPayloadBuilder builder =
        mqtt.MqttClientPayloadBuilder();

    builder.addString(x);
    client.publishMessage(
      'hacksensorx',
      mqtt.MqttQos.values[_qosValue],
      builder.payload,
      retain: _retainValue,
    );
   // Navigator.pop(context);
  }

  void _sendMessagey(String y) {
    final mqtt.MqttClientPayloadBuilder builder =
        mqtt.MqttClientPayloadBuilder();

    builder.addString(y);
    client.publishMessage(
     'hacksensory',
      mqtt.MqttQos.values[_qosValue],
      builder.payload,
      retain: _retainValue,
    );
   // Navigator.pop(context);
  }

  void _sendMessagez(String z) {
    final mqtt.MqttClientPayloadBuilder builder =
        mqtt.MqttClientPayloadBuilder();

    builder.addString(z);
    client.publishMessage(
      'hacksensorz',
      mqtt.MqttQos.values[_qosValue],
      builder.payload,
      retain: _retainValue,
    );
   // Navigator.pop(context);
  }
}
class Message {
  final String topic;
  final String message;
  final mqtt.MqttQos qos;

  Message({this.topic, this.message, this.qos});
}

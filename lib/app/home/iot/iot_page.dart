import 'package:fiveg/app/home/ai/ai_page.dart';
import 'package:fiveg/app/home/home_page.dart';
import 'package:fiveg/app/home/iot/battery_page.dart';
import 'package:fiveg/app/home/iot/phoneinfo_page.dart';
import 'package:fiveg/app/home/iot/sensor_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/utils.dart';
import '../../../common_widgets/list_widget.dart';
import 'index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimationsPlayground extends StatelessWidget {
  String _serverAddress = '';
  SharedPreferences prefs;

  _initData() async {
    prefs = await SharedPreferences.getInstance();
    _serverAddress = prefs.getString('server') ?? 'demo.cloudwebrtc.com';
  }

  static Route<dynamic> route() {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 3),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AnimationsPlayground();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return Scaffold(
      body: IoTPage(
        ip: _serverAddress,
      ),
    );
  }
}

class IoTPage extends StatefulWidget {
  final String ip;

  IoTPage({Key key, @required this.ip}) : super(key: key);

  @override
  _IoTPageState createState() => _IoTPageState();
}

class _IoTPageState extends State<IoTPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //double height = (MediaQuery.of(context).size.height / 3) -
    //16 -
    // kBottomNavigationBarHeight

    final images = [
      'images/s10.jpeg',
      'images/Sensors.jpg',
      'images/BatteryInfo.jpg'
    ];
    final pages = [PhoneInfo(), SensorPage(ip: widget.ip), BatteryPage()];

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Center(
              child: UserAccountsDrawerHeader(
                accountName: Text("Ayden Xu"),
                accountEmail: Text("Ayden@5g.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Color(0xff70a0ff)
                          : Colors.white,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
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
              borderRadius: BorderRadius.all(const Radius.circular(16.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 140.0, bottom: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
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
                        child: /* Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, bottom: 10, left: 30),
                              child: Text(
                                "Production Quality Inspection",
                                style: TextStyle(
                                    color: Color(0xff3a6aac),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Center(
                                child: Text(
                              "Production quality inspection is",
                              style: TextStyle(
                                  color: Color(0xff3a6aac),
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w300),
                            )),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                         */
                       ClipRRect(
                          borderRadius: new BorderRadius.circular(16.0),
                         child: Image.asset('images/card.jpg', fit: BoxFit.cover)),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.875,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                const Radius.circular(16)),
                                            color: Colors.transparent,
                                          ),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 15,
                                                  bottom: 15,
                                                  right: 20),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      pages[
                                                                          index],
                                                            ));
                                                      },
                                                      child: Container(
                                                        //alignment: Alignment.bottomLeft,
                                                        //padding: EdgeInsets.all(16),

                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  const Radius
                                                                          .circular(
                                                                      16)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.black.withOpacity(0.4),
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
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                images[index]),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: <Widget>[
                                                            /*   Icon(Icons.phone_android),
                                        Center(child: Text("Phone Info"))*/
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                        ));
                                  }),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
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
              title: Image.asset('images/header.png', fit: BoxFit.cover),

              backgroundColor: Colors.transparent,
              elevation: 0.0, //Shadow gone
            ),
          ),
        ],
      ),
    );
  }
}

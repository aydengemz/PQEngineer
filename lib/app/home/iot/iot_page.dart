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
    return Scaffold(
      body: IoTPage(),
    );
  }
}

class IoTPage extends StatefulWidget {
  @override
  _IoTPageState createState() => _IoTPageState();
}

class _IoTPageState extends State<IoTPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //double height = (MediaQuery.of(context).size.height / 3) -
    //16 -
    // kBottomNavigationBarHeight

    final images = ['images/s10.jpeg', 'images/Sensors.jpg', 'images/s10.jpeg'];
    final pages = [PhoneInfo(), SensorPage(), BatteryPage()];

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
            decoration: BoxDecoration(color: Color(0xff70a0ff)),
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                const Radius.circular(16)),
                                            color: Colors.white,
                                            
                                          ),
                       
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, bottom: 10),
                              child: Center(
                                  child: Text(
                                "Production Quality Engineer",
                                style: TextStyle(
                                    color: Color(0xff70a0ff),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w400),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 40, left: 30),
                              child: Center(
                                  child: Text(
                                "Utilize 5G, Faster production quality inspections",
                                style: TextStyle(
                                    color: Color(0xff70a0ff),
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w300),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                const Radius.circular(16)),
                                            color: Colors.transparent,
                                          ),
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 20),
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
                                                            SizedBox(
                                                              height: 10,
                                                            )
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
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add_alert),
                  tooltip: 'Show Snackbar',
                  onPressed: () {},
                ),
              ],
              centerTitle: true,
              title: Center(
                child: Center(
                    child: Text(
                  'PQEngineer',
                  style: TextStyle(fontSize: 25),
                )),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0, //Shadow gone
            ),
          ),
        ],
      ),
    );
  }
}

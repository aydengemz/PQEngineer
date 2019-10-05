import 'package:fiveg/app/home/iot/battery_page.dart';
import 'package:fiveg/app/home/iot/phoneinfo_page.dart';
import 'package:fiveg/app/home/iot/sensor_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common_widgets/list_widget.dart';
import 'index.dart';



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

class _IoTPageState extends State<IoTPage> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height - kBottomNavigationBarHeight)/3- 16 ;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('PQEngineer')),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
           
          ),
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /*StaticListTemplate(
            titles: titles,
            icons: icons,
            pages: pages,
          ), */

              
                 GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneInfo()),
                    );
                  },
                
                    
                                    child: AnimatedContainer(
                                      duration: Duration(seconds: 3),
                                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(const Radius.circular(16)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.phone_android),
                          Center(child: Text("Phone Info"))
                        ],
                      ),
                    ),
                  ),
                
              
              SizedBox(
                height: 8,
              ),
              
                 GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SensorPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(16)),
                    ),
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.track_changes),
                        Center(child: Text("Sensors"))
                      ],
                    ),
                  ),
                ),
              
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BatteryPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.battery_alert,
                          size: 30,
                        ),
                        Center(child: Text("Battery"))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

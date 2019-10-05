import 'package:fiveg/app/home/iot/iot_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fiveg/app/landing_page.dart';
import 'package:fiveg/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      builder: (context) => Auth(),
      child: MaterialApp(
         onGenerateRoute: (RouteSettings settings) {
        if (settings.isInitialRoute) {
          return AnimationsPlayground.route();
        }
        return null;
      },
        title: 'PQ Engineer',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
         
           textTheme: TextTheme(
            body1: TextStyle(fontSize: 20, color: Colors.blue),
    ),
            iconTheme: IconThemeData(color: Colors.blue),
        ),
        home: LandingPage(),
      ),
    );
  }
}

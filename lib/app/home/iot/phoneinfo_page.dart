// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

/* void main() {
  runZoned(() {
    runApp(PhoneInfo());
  }, onError: (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
} */

class PhoneInfo extends StatefulWidget {
  @override
  _PhoneInfoState createState() => _PhoneInfoState();
}

class _PhoneInfoState extends State<PhoneInfo> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    return Scaffold(
      /* appBar: AppBar(
        title: Text(
            Platform.isAndroid ? 'Android Device Info' : 'iOS Device Info'),
      ), */
      body: 
      
               SafeArea(
                                child: Container(
          height: MediaQuery.of(context).size.height,
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
   padding: const EdgeInsets.only(top: 80.0, left: 30, right: 30, bottom: 30),
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
          child: ListView(
                  shrinkWrap: true,
                  children: _deviceData.keys.map((String property) {
                    return Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            property,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Text(
                            '${_deviceData[property]}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                      ],
                    );
                  }).toList(),
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
                    title: Text(
                  Platform.isAndroid ? 'Android Device Info' : 'iOS Device Info', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
                  
                    backgroundColor: Colors.transparent,
                    elevation: 0.0, //Shadow gone
                  ),
              ),
          ],),
        ),
               ),
      
     
    );
  }
}

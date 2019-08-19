import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/nano_healthkit_plugin.dart';
import 'package:nano_healthkit_plugin/HealthKitData.pb.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthorized = false;
  String _basicHealthString = "";
  String _activityData;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
//    String platformVersion;
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await FlutterHealthFit.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
  }

  /* @override
  Widget build(BuildContext context) {
    final plat = _platformVersion as HealthKitData;
    var title = plat == null ? "Waiting" : plat.title;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: ' + title),
        ),
      ),
    );
  }*/

  _authorizeHealthOrFit() async {
    bool isAuthorized = await NanoHealthkitPlugin.authorize;
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  _getUserBasicHealthData() async {
    var basicHealth = await NanoHealthkitPlugin.getBasicHealthData;
    setState(() {
      _basicHealthString = basicHealth.toString();
    });
  }

  _getActivityHealthData() async {
    var steps = await NanoHealthkitPlugin.getSteps;
    var running = await NanoHealthkitPlugin.getWalkingAndRunningDistance;
    var cycle = await NanoHealthkitPlugin.geCyclingDistance;
    var flights = await NanoHealthkitPlugin.getFlights;
    setState(() {
      _activityData =
          "steps: $steps\nwalking running: $running\ncycle: $cycle flights: $flights";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Authorized: $_isAuthorized\n'),
              RaisedButton(
                  child: Text("Authorize Health"),
                  onPressed: () {
                    _authorizeHealthOrFit();
                  }),
              RaisedButton(
                  child: Text("Get basic data"),
                  onPressed: _getUserBasicHealthData),
              Text('Basic health: $_basicHealthString\n'),
              RaisedButton(
                  child: Text("Get Activity Data"),
                  onPressed: _getActivityHealthData),
              Text('\n$_activityData\n'),
            ],
          ),
        ),
      ),
    );
  }
}

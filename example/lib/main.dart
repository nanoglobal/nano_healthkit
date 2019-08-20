import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fixnum/fixnum.dart';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/nano_healthkit_plugin.dart';
import 'package:nano_healthkit_plugin/healthkitdata.pb.dart';
import 'package:nano_healthkit_plugin/healthkitdata.pbenum.dart';

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
    var request = HealthKitDataBatchRequest();
    request.type = HealthKitFetchTypes.QUANTITIES;
    request.index = Int64(2);
    request.startDate = "2019-08-19T14:58:00.000Z";
    request.endDate = "2019-08-19T17:58:00.000Z";
    var basicHealth = await NanoHealthkitPlugin.getDataBatch(request);
    setState(() {
      _basicHealthString = basicHealth.toString();
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
                  onPressed: _getUserBasicHealthData),
              Text('\n$_activityData\n'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:nano_healthkit_plugin/nano_healthkit_plugin.dart';
import 'package:nano_healthkit_plugin/healthdata.pb.dart';
import 'package:nano_healthkit_plugin/healthdata.pbenum.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthorized = false;
  String _basicHealthString = "";
  String _activityData;
  String _exisitngTypesString = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {}

  _authorize() async {
    var request = HealthTypeList();
    request.types.addAll(HealthTypes.values); // Permissions to read everything
    bool isAuthorized = await NanoHealthkitPlugin.authorize(request);
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  _getUserBasicHealthData() async {
    var request = HealthDataRequest();
    request.type = HealthTypes.CHARACTERISTIC_DATE_OF_BIRTH;
    request.startDate = "2019-08-19T18:58:00.000Z";
    request.endDate = "2019-08-19T20:58:00.000Z";
    var basicHealth = await NanoHealthkitPlugin.fetchData(request);
    setState(() {
      _basicHealthString = basicHealth.toString();
    });
  }

  _filterExistingTypes() async {
    var request = HealthTypeList();
    request.types.addAll(HealthTypes.values); // Permissions to read everything
    var filtered = await NanoHealthkitPlugin.filterExistingTypes(request);
    setState(() {
      _exisitngTypesString = filtered.toString();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                  child: Text("Authorize"),
                  onPressed: () {
                    _authorize();
                  }),
              Text('Authorized: $_isAuthorized\n'),
              RaisedButton(
                  child: Text("Filter Only Existing Types"),
                  onPressed: () {
                    _filterExistingTypes();
                  }),
              Text('Valid types: $_exisitngTypesString\n'),
              RaisedButton(
                  child: Text("Get basic data"),
                  onPressed: _getUserBasicHealthData),
              Text('Basic health: $_basicHealthString\n'),
            ],
          ),
        ),
      ),
    );
  }
}

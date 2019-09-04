import 'dart:async';

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
  String _updateStatusString = "";
  String _updateMessageString = "";
  bool _isSubscribed = false;

  StreamSubscription _subscription = null;

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
    request.type = HealthTypes.QUANTITY_HEIGHT;
    request.startDate = "2019-06-19T18:58:00.000Z";
    request.endDate = "2019-09-19T20:58:00.000Z";
    request.limit = 2;
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

  _subscribeToUpdates() {
    var request = HealthTypeList();
    request.types.addAll(HealthTypes.values); // Subscribe to everything
    _subscription =
        NanoHealthkitPlugin.subscribeToUpdates(request, _updatesReceived);
    setState(() {
      _isSubscribed = true;
      _updateMessageString = "";
    });
  }

  _unsubscribeToUpdates() {
    NanoHealthkitPlugin.unsubscribeToUpdates(_subscription);
    setState(() {
      _isSubscribed = false;
      _updateMessageString = "";
    });
  }

  _updatesReceived(HealthTypeList updates) {
    //TODO: PARSE THE UPDATES
    setState(() {
      _updateMessageString = updates.toString();
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
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text("Authorize"),
                    onPressed: () {
                      _authorize();
                    }),
              ),
              Text('Authorized: $_isAuthorized\n'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text("Filter Only Existing Types"),
                    onPressed: () {
                      _filterExistingTypes();
                    }),
              ),
              Text('Valid types: $_exisitngTypesString\n'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text(_isSubscribed
                        ? "Unsubscribe to updates"
                        : "Subscribe to updates"),
                    onPressed: _isSubscribed
                        ? _unsubscribeToUpdates
                        : _subscribeToUpdates),
              ),
              Text('$_updateMessageString\n'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text("Get basic data"),
                    onPressed: _getUserBasicHealthData),
              ),
              Text('Basic health: $_basicHealthString\n'),
            ],
          ),
        ),
      ),
    );
  }
}

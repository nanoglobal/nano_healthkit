import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nano_healthkit_plugin/nano_healthkit_plugin.dart';
import 'package:nano_healthkit_plugin/healthdata.pb.dart';
import 'package:nano_healthkit_plugin/healthdata.pbenum.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthorized = false;
  String _basicHealthString = "";
  String _statisticsString = "";
  String _exisitngTypesString = "";
  String _updateMessageString = "";
  bool _isSubscribed = false;
  String _pulledBackgroundDataString = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    print('Initializing...');
    await NanoHealthkitPlugin.initialize(_updatesReceivedInBackground);
    print('Initialization done');
  }

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
    request.type = HealthTypes.CORRELATION_FOOD;
    //request.startDate = "2019-06-19T18:58:00.000Z";
    //request.endDate = "2019-09-19T20:58:00.000Z";
    //request.limit = 2;
    //request.units.add("ft");
    //request.units.add("kcal");
    //request.units.add("km");
    var resultToShow = "";
    try {
      var basicHealth = await NanoHealthkitPlugin.fetchData(request);
      resultToShow = basicHealth.toString();
    } on Exception catch (error) {
      resultToShow = error.toString();
    }
    setState(() {
      _basicHealthString = resultToShow;
    });
  }

  _getUserStatisticsData() async {
    var request = StatisticsRequest();
    request.type = HealthTypes.QUANTITY_HEART_RATE;
    request.options.add(StatisticsOptions.DISCRETE_MAX);
    request.options.add(StatisticsOptions.DISCRETE_MIN);
    request.options.add(StatisticsOptions.DISCRETE_AVERAGE);
    request.options.add(StatisticsOptions.SEPARATE_BY_SOURCE);
    var resultToShow = "";
    try {
      var result = await NanoHealthkitPlugin.fetchStatisticsData(request);
      resultToShow = result.toString();
    } on Exception catch (error) {
      resultToShow = error.toString();
    }
    setState(() {
      _statisticsString = resultToShow;
    });
  }

  _filterExistingTypes() async {
    var request = HealthTypeList();
    request.types.addAll(HealthTypes.values);
    var filtered = await NanoHealthkitPlugin.filterExistingTypes(request);
    setState(() {
      _exisitngTypesString = filtered.toString();
    });
  }

  _subscribeToUpdates() {
    var request = HealthTypeList();
    request.types.addAll(HealthTypes.values); // Subscribe to everything
    NanoHealthkitPlugin.subscribeToUpdates(request, _updatesReceived);
    setState(() {
      _isSubscribed = true;
      _updateMessageString = "";
    });
  }

  _unsubscribeToUpdates() {
    NanoHealthkitPlugin.unsubscribeToUpdates();
    setState(() {
      _isSubscribed = false;
      _updateMessageString = "";
    });
  }

  _updatesReceived(HealthDataList updates) {
    _saveUpdateData(updates);
    setState(() {
      _updateMessageString = updates.toString();
    });
  }

  _updatesReceivedInBackground(HealthDataList updates) {
    _saveUpdateData(updates);
  }

  _saveUpdateData(HealthDataList updates) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saves = prefs.getStringList("savedUpdates") ?? List<String>();
    saves.add(updates.toString() + "\n");
    prefs.setStringList("savedUpdates", saves);
  }

  _pullSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saves = prefs.getStringList("savedUpdates") ?? List<String>();
    setState(() {
      _pulledBackgroundDataString = saves.toString();
    });
    saves.clear();
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
                    child: Text("Pull saved updates"),
                    onPressed: _pullSavedData),
              ),
              Text('Saved data: $_pulledBackgroundDataString\n'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text("Get basic data"),
                    onPressed: _getUserBasicHealthData),
              ),
              Text('Basic health: $_basicHealthString\n'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton(
                    child: Text("Get statistics data"),
                    onPressed: _getUserStatisticsData),
              ),
              Text('Statistics data: $_statisticsString\n'),
            ],
          ),
        ),
      ),
    );
  }
}

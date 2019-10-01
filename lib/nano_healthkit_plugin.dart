import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/healthdata.pb.dart';

class NanoHealthkitPlugin {
  static const _channel = const MethodChannel('nano_healthkit_plugin');
  static const _stream = const EventChannel('nano_healthkit_plugin_stream');
  static var _subscriberMethod;

  static Future<bool> authorize(HealthTypeList request) async {
    return await _channel.invokeMethod(
        'requestPermissions', request.writeToBuffer());
  }

  static Future<HealthTypeList> filterExistingTypes(
      HealthTypeList request) async {
    final Uint8List rawData = await _channel.invokeMethod(
        'filterExistingTypes', request.writeToBuffer());
    return HealthTypeList.fromBuffer(rawData);
  }

  static Future<HealthDataList> fetchData(HealthDataRequest request) async {
    final Uint8List rawData =
        await _channel.invokeMethod('fetchData', request.writeToBuffer());
    return HealthDataList.fromBuffer(rawData);
  }

  static StreamSubscription subscribeToUpdates<T>(
      HealthTypeList request, void onData(T event)) {
    _subscriberMethod = onData;
    return _stream
        .receiveBroadcastStream(request.writeToBuffer())
        .listen(_updatesReceived);
  }

  static Future<bool> unsubscribeToUpdates(StreamSubscription stream) async {
    if (stream != null) {
      stream.cancel();
      _subscriberMethod = null;
    }
    return await _channel.invokeMethod('unsubscribeToUpdates');
  }

  static void _updatesReceived(updates) {
    if (_subscriberMethod != null) {
      final HealthDataList result = HealthDataList.fromBuffer(updates);
      _subscriberMethod(result);
    }
  }

  static Future<StatisticsData> fetchStatisticsData(
      StatisticsRequest request) async {
    final Uint8List rawData = await _channel.invokeMethod(
        'fetchStatisticsData', request.writeToBuffer());
    return StatisticsData.fromBuffer(rawData);
  }
}

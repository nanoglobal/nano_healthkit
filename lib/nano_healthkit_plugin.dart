import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/healthdata.pb.dart';

class NanoHealthkitPlugin {
  static const _channel = const MethodChannel('nano_healthkit_plugin');
  static const _stream = const EventChannel('nano_healthkit_plugin_stream');
  static var _subscriberMethod;

  /// Requests permissions
  ///
  /// Desired health types to request permissions are indicated in the [request].
  static Future<bool> authorize(HealthTypeList request) async {
    return await _channel.invokeMethod(
        'requestPermissions', request.writeToBuffer());
  }

  /// Filters types that are available on the user's device
  ///
  /// Depending on the OS version, some types may not be available.
  /// Returns the valid types.
  static Future<HealthTypeList> filterExistingTypes(
      HealthTypeList request) async {
    final Uint8List rawData = await _channel.invokeMethod(
        'filterExistingTypes', request.writeToBuffer());
    return HealthTypeList.fromBuffer(rawData);
  }

  /// Reads data
  ///
  /// [request] need a type of health data to read. Optionally a limit,
  /// startDate, endDate and sort options can be indicated. If no limit and
  /// dates are indicated, it will fetch all historical data for that type.
  static Future<HealthDataList> fetchData(HealthDataRequest request) async {
    final Uint8List rawData =
        await _channel.invokeMethod('fetchData', request.writeToBuffer());
    return HealthDataList.fromBuffer(rawData);
  }

  /// Subscribes to new available data
  ///
  /// Only subscribes to types indicated in [request]. The method in [onData]
  /// gets called on each new available data in a ``HealthDataList`` object.
  static StreamSubscription subscribeToUpdates<T>(
      HealthTypeList request, void onData(T event)) {
    _subscriberMethod = onData;
    return _stream
        .receiveBroadcastStream(request.writeToBuffer())
        .listen(_updatesReceived);
  }

  /// Removes the subscription to all types
  ///
  /// Does not receive a list of types, instead it unsubscribes from all possible
  /// types of health data. [stream] needs to be the object that the subscription
  /// method returns.
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

  /// Makes a statistics query
  ///
  /// [request] needs a Quantity type and some options to make the query. Read
  /// Apple's doc for more information regarding HKStatisticsQuery.
  static Future<StatisticsData> fetchStatisticsData(
      StatisticsRequest request) async {
    final Uint8List rawData = await _channel.invokeMethod(
        'fetchStatisticsData', request.writeToBuffer());
    return StatisticsData.fromBuffer(rawData);
  }
}

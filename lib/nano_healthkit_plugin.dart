import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nano_healthkit_plugin/healthdata.pb.dart';

class NanoHealthkitPlugin {
  static const _channel = const MethodChannel('nano_healthkit_plugin');
  static const _stream = const EventChannel('nano_healthkit_plugin_stream');
  static var _subscriberMethod;
  static StreamSubscription _subscription;

  /// Initialize the plugin and request relevant permissions from the user.
  static Future<void> initialize<T>(void onData(T event)) async {
    await _channel.invokeMethod('initialize', null);
    subscribeToUpdates(null, onData);
  }

  /// Requests Read permissions
  ///
  /// Desired health types to request permissions are indicated in the [readRequest].

  static Future<bool> authorizeRead(HealthTypeList readRequest)async {
    return await _channel.invokeMethod(
        'requestReadPermissions', <String, dynamic>{
      'read': readRequest.writeToBuffer()
    } );
  }

   /// Filters Read types that are available on the user's device
  ///
  /// Depending on the OS version, some types may not be available.
  /// Returns the valid types.
  static Future<HealthTypeList> filterExistingReadTypes(
      HealthTypeList request) async {
    final Uint8List rawData = await _channel.invokeMethod(
        'filterExistingReadTypes', request.writeToBuffer());
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

  /// Reads data of many types at once
  ///
  /// The [request] is a list of individual [HealthDataRequest] identical
  /// to the one sent on [fetchData].
  static Future<HealthDataList> fetchBatchData(
      HealthDataRequestList request) async {
    final Uint8List rawData =
        await _channel.invokeMethod('fetchBatchData', request.writeToBuffer());
    return HealthDataList.fromBuffer(rawData);
  }

  /// Subscribes to new available data
  ///
  /// Only subscribes to types indicated in [request]. The method in [onData]
  /// gets called on each new available data in a ``HealthDataList`` object.
  static void subscribeToUpdates<T>(
      HealthTypeList request, void onData(T event)) {
    _subscriberMethod = onData;
    _subscription?.cancel();
    _subscription = _stream
        .receiveBroadcastStream(request?.writeToBuffer())
        .listen(_updatesReceived);
  }

  /// Removes the subscription to all types
  ///
  /// Does not receive a list of types, instead it unsubscribes from all possible
  /// types of health data. [stream] needs to be the object that the subscription
  /// method returns.
  static Future<bool> unsubscribeToUpdates() async {
    _subscription?.cancel();
    _subscription = null;
    _subscriberMethod = null;
    return await _channel.invokeMethod('unsubscribeToUpdates');
  }

  /// Checks if there is a subscription to updates
  ///
  /// Specially useful to keep track of the subscriptions probably done during
  /// another session.
  static Future<bool> isSubscribedToUpdates() async {
    return await _channel.invokeMethod('isSubscribedToUpdates');
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

  /// Requests Write permissions
  ///
  ///
  /// Desired health types to request permissions are indicated in the [writeRequest].
  static Future<bool> authorizeWrite(HealthTypeList writeRequest)async {
    return await _channel.invokeMethod(
        'requestWritePermissions', <String, dynamic>{
      'write': writeRequest.writeToBuffer()
    } );
  }

  /// Filters Write types that are available on the user's device
  ///
  /// Depending on the OS version, some types may not be available.
  /// Returns the valid types.
  static Future<HealthTypeList> filterExistingWriteTypes(
      HealthTypeList request) async {
    final Uint8List rawData = await _channel.invokeMethod(
        'filterExistingWriteTypes', request.writeToBuffer());
    return HealthTypeList.fromBuffer(rawData);
  }

  /// Write data
  ///
  /// [healthData] need a type of health data to write.
  /// Depending on the health type others field must be supplied.
  /// Optionally a limit,
  /// startDate, endDate are optionals

  static Future<bool> writeData(HealthData healthData) async {
    return await _channel.invokeMethod('writeData', healthData.writeToBuffer());

  }

}

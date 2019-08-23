import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/healthdata.pb.dart';

class NanoHealthkitPlugin {
  static const MethodChannel _channel =
      const MethodChannel('nano_healthkit_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> authorize(HealthTypeList request) async {
    return await _channel.invokeMethod(
        'requestPermissions', request.writeToBuffer());
  }

  static Future<HealthDataList> fetchData(HealthDataRequest request) async {
    final Uint8List rawData =
        await _channel.invokeMethod('fetchData', request.writeToBuffer());
    final HealthDataList result = HealthDataList.fromBuffer(rawData);
    return result;
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/HealthKitData.pb.dart';
import 'package:nano_healthkit_plugin/HealthKitData.pbenum.dart';

class NanoHealthkitPlugin {
  static const MethodChannel _channel =
      const MethodChannel('nano_healthkit_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> get authorize async {
    return await _channel.invokeMethod('requestPermissions');
  }

  static Future<HealthKitDataBatch> getDataBatch(
      HealthKitFetchTypes type, int index) async {
    final Uint8List rawData = await _channel
        .invokeMethod('getDataBatch', {"type": type.hashCode, "index": index});
    final HealthKitDataBatch result = HealthKitDataBatch.fromBuffer(rawData);
    return result;
  }
}

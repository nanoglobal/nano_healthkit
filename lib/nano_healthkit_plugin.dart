import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:nano_healthkit_plugin/BookInfo.pb.dart';

class NanoHealthkitPlugin {
  static const MethodChannel _channel =
      const MethodChannel('nano_healthkit_plugin');

  static Future<BookInfo> get mauricio async {
    final Uint8List rawData = await _channel.invokeMethod('hola_mauro');
    final BookInfo bookInfo = BookInfo.fromBuffer(rawData);
    return bookInfo;
  }
}

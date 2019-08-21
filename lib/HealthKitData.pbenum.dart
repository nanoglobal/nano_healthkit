///
//  Generated code. Do not modify.
//  source: healthkitdata.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class HealthKitFetchTypes extends $pb.ProtobufEnum {
  static const HealthKitFetchTypes CATEGORIES = HealthKitFetchTypes._(0, 'CATEGORIES');
  static const HealthKitFetchTypes QUANTITIES = HealthKitFetchTypes._(1, 'QUANTITIES');
  static const HealthKitFetchTypes WORKOUT = HealthKitFetchTypes._(2, 'WORKOUT');

  static const $core.List<HealthKitFetchTypes> values = <HealthKitFetchTypes> [
    CATEGORIES,
    QUANTITIES,
    WORKOUT,
  ];

  static final $core.Map<$core.int, HealthKitFetchTypes> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HealthKitFetchTypes valueOf($core.int value) => _byValue[value];

  const HealthKitFetchTypes._($core.int v, $core.String n) : super(v, n);
}


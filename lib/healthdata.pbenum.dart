///
//  Generated code. Do not modify.
//  source: healthdata.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class HealthTypes extends $pb.ProtobufEnum {
  static const HealthTypes WORKOUT_MAIN = HealthTypes._(0, 'WORKOUT_MAIN');
  static const HealthTypes CATEGORY_SLEEP_ANALYSIS = HealthTypes._(1, 'CATEGORY_SLEEP_ANALYSIS');
  static const HealthTypes CATEGORY_APPLE_STAND_HOUR = HealthTypes._(2, 'CATEGORY_APPLE_STAND_HOUR');
  static const HealthTypes CATEGORY_CervicalMucusQuality = HealthTypes._(3, 'CATEGORY_CervicalMucusQuality');
  static const HealthTypes QUANTITY_BodyMassIndex = HealthTypes._(4, 'QUANTITY_BodyMassIndex');
  static const HealthTypes QUANTITY_BodyFatPercentage = HealthTypes._(5, 'QUANTITY_BodyFatPercentage');
  static const HealthTypes QUANTITY_HEIGHT = HealthTypes._(6, 'QUANTITY_HEIGHT');

  static const $core.List<HealthTypes> values = <HealthTypes> [
    WORKOUT_MAIN,
    CATEGORY_SLEEP_ANALYSIS,
    CATEGORY_APPLE_STAND_HOUR,
    CATEGORY_CervicalMucusQuality,
    QUANTITY_BodyMassIndex,
    QUANTITY_BodyFatPercentage,
    QUANTITY_HEIGHT,
  ];

  static final $core.Map<$core.int, HealthTypes> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HealthTypes valueOf($core.int value) => _byValue[value];

  const HealthTypes._($core.int v, $core.String n) : super(v, n);
}


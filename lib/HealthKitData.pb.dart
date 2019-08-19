///
//  Generated code. Do not modify.
//  source: HealthKitData.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

class HealthKitData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthKitData')
    ..aOS(1, 'type')
    ..aOS(2, 'startDate')
    ..aOS(3, 'endDate')
    ..aOS(4, 'device')
    ..aOS(5, 'metadata')
    ..aInt64(6, 'count')
    ..aOS(7, 'quantityUnit')
    ..a<$core.double>(8, 'quantity', $pb.PbFieldType.OD)
    ..aInt64(9, 'value')
    ..a<$core.double>(10, 'totalEnergyBurned', $pb.PbFieldType.OD)
    ..aOS(11, 'totalEnergyBurnedUnit')
    ..a<$core.double>(12, 'totalDistance', $pb.PbFieldType.OD)
    ..aOS(13, 'totalDistanceUnit')
    ..a<$core.double>(14, 'duration', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  HealthKitData._() : super();
  factory HealthKitData() => create();
  factory HealthKitData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthKitData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthKitData clone() => HealthKitData()..mergeFromMessage(this);
  HealthKitData copyWith(void Function(HealthKitData) updates) => super.copyWith((message) => updates(message as HealthKitData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthKitData create() => HealthKitData._();
  HealthKitData createEmptyInstance() => create();
  static $pb.PbList<HealthKitData> createRepeated() => $pb.PbList<HealthKitData>();
  static HealthKitData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthKitData _defaultInstance;

  $core.String get type => $_getS(0, '');
  set type($core.String v) { $_setString(0, v); }
  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.String get startDate => $_getS(1, '');
  set startDate($core.String v) { $_setString(1, v); }
  $core.bool hasStartDate() => $_has(1);
  void clearStartDate() => clearField(2);

  $core.String get endDate => $_getS(2, '');
  set endDate($core.String v) { $_setString(2, v); }
  $core.bool hasEndDate() => $_has(2);
  void clearEndDate() => clearField(3);

  $core.String get device => $_getS(3, '');
  set device($core.String v) { $_setString(3, v); }
  $core.bool hasDevice() => $_has(3);
  void clearDevice() => clearField(4);

  $core.String get metadata => $_getS(4, '');
  set metadata($core.String v) { $_setString(4, v); }
  $core.bool hasMetadata() => $_has(4);
  void clearMetadata() => clearField(5);

  Int64 get count => $_getI64(5);
  set count(Int64 v) { $_setInt64(5, v); }
  $core.bool hasCount() => $_has(5);
  void clearCount() => clearField(6);

  $core.String get quantityUnit => $_getS(6, '');
  set quantityUnit($core.String v) { $_setString(6, v); }
  $core.bool hasQuantityUnit() => $_has(6);
  void clearQuantityUnit() => clearField(7);

  $core.double get quantity => $_getN(7);
  set quantity($core.double v) { $_setDouble(7, v); }
  $core.bool hasQuantity() => $_has(7);
  void clearQuantity() => clearField(8);

  Int64 get value => $_getI64(8);
  set value(Int64 v) { $_setInt64(8, v); }
  $core.bool hasValue() => $_has(8);
  void clearValue() => clearField(9);

  $core.double get totalEnergyBurned => $_getN(9);
  set totalEnergyBurned($core.double v) { $_setDouble(9, v); }
  $core.bool hasTotalEnergyBurned() => $_has(9);
  void clearTotalEnergyBurned() => clearField(10);

  $core.String get totalEnergyBurnedUnit => $_getS(10, '');
  set totalEnergyBurnedUnit($core.String v) { $_setString(10, v); }
  $core.bool hasTotalEnergyBurnedUnit() => $_has(10);
  void clearTotalEnergyBurnedUnit() => clearField(11);

  $core.double get totalDistance => $_getN(11);
  set totalDistance($core.double v) { $_setDouble(11, v); }
  $core.bool hasTotalDistance() => $_has(11);
  void clearTotalDistance() => clearField(12);

  $core.String get totalDistanceUnit => $_getS(12, '');
  set totalDistanceUnit($core.String v) { $_setString(12, v); }
  $core.bool hasTotalDistanceUnit() => $_has(12);
  void clearTotalDistanceUnit() => clearField(13);

  $core.double get duration => $_getN(13);
  set duration($core.double v) { $_setDouble(13, v); }
  $core.bool hasDuration() => $_has(13);
  void clearDuration() => clearField(14);
}

class HealthKitDataBatch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthKitDataBatch')
    ..pc<HealthKitData>(1, 'type', $pb.PbFieldType.PM,HealthKitData.create)
    ..hasRequiredFields = false
  ;

  HealthKitDataBatch._() : super();
  factory HealthKitDataBatch() => create();
  factory HealthKitDataBatch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthKitDataBatch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthKitDataBatch clone() => HealthKitDataBatch()..mergeFromMessage(this);
  HealthKitDataBatch copyWith(void Function(HealthKitDataBatch) updates) => super.copyWith((message) => updates(message as HealthKitDataBatch));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthKitDataBatch create() => HealthKitDataBatch._();
  HealthKitDataBatch createEmptyInstance() => create();
  static $pb.PbList<HealthKitDataBatch> createRepeated() => $pb.PbList<HealthKitDataBatch>();
  static HealthKitDataBatch getDefault() => _defaultInstance ??= create()..freeze();
  static HealthKitDataBatch _defaultInstance;

  $core.List<HealthKitData> get type => $_getList(0);
}


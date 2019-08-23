///
//  Generated code. Do not modify.
//  source: healthdata.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

import 'healthdata.pbenum.dart';

export 'healthdata.pbenum.dart';

class HealthTypeList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthTypeList')
    ..pc<HealthTypes>(1, 'types', $pb.PbFieldType.PE, null, HealthTypes.valueOf, HealthTypes.values)
    ..hasRequiredFields = false
  ;

  HealthTypeList._() : super();
  factory HealthTypeList() => create();
  factory HealthTypeList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthTypeList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthTypeList clone() => HealthTypeList()..mergeFromMessage(this);
  HealthTypeList copyWith(void Function(HealthTypeList) updates) => super.copyWith((message) => updates(message as HealthTypeList));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthTypeList create() => HealthTypeList._();
  HealthTypeList createEmptyInstance() => create();
  static $pb.PbList<HealthTypeList> createRepeated() => $pb.PbList<HealthTypeList>();
  static HealthTypeList getDefault() => _defaultInstance ??= create()..freeze();
  static HealthTypeList _defaultInstance;

  $core.List<HealthTypes> get types => $_getList(0);
}

class HealthDataRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthDataRequest')
    ..e<HealthTypes>(1, 'type', $pb.PbFieldType.OE, HealthTypes.WORKOUT_MAIN, HealthTypes.valueOf, HealthTypes.values)
    ..aOS(2, 'startDate')
    ..aOS(3, 'endDate')
    ..hasRequiredFields = false
  ;

  HealthDataRequest._() : super();
  factory HealthDataRequest() => create();
  factory HealthDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthDataRequest clone() => HealthDataRequest()..mergeFromMessage(this);
  HealthDataRequest copyWith(void Function(HealthDataRequest) updates) => super.copyWith((message) => updates(message as HealthDataRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthDataRequest create() => HealthDataRequest._();
  HealthDataRequest createEmptyInstance() => create();
  static $pb.PbList<HealthDataRequest> createRepeated() => $pb.PbList<HealthDataRequest>();
  static HealthDataRequest getDefault() => _defaultInstance ??= create()..freeze();
  static HealthDataRequest _defaultInstance;

  HealthTypes get type => $_getN(0);
  set type(HealthTypes v) { setField(1, v); }
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
}

class HealthDataRequestList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthDataRequestList')
    ..pc<HealthDataRequest>(1, 'requests', $pb.PbFieldType.PM,HealthDataRequest.create)
    ..hasRequiredFields = false
  ;

  HealthDataRequestList._() : super();
  factory HealthDataRequestList() => create();
  factory HealthDataRequestList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthDataRequestList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthDataRequestList clone() => HealthDataRequestList()..mergeFromMessage(this);
  HealthDataRequestList copyWith(void Function(HealthDataRequestList) updates) => super.copyWith((message) => updates(message as HealthDataRequestList));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthDataRequestList create() => HealthDataRequestList._();
  HealthDataRequestList createEmptyInstance() => create();
  static $pb.PbList<HealthDataRequestList> createRepeated() => $pb.PbList<HealthDataRequestList>();
  static HealthDataRequestList getDefault() => _defaultInstance ??= create()..freeze();
  static HealthDataRequestList _defaultInstance;

  $core.List<HealthDataRequest> get requests => $_getList(0);
}

class HealthData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData')
    ..aOS(1, 'sampleType')
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
    ..e<HealthTypes>(15, 'type', $pb.PbFieldType.OE, HealthTypes.WORKOUT_MAIN, HealthTypes.valueOf, HealthTypes.values)
    ..hasRequiredFields = false
  ;

  HealthData._() : super();
  factory HealthData() => create();
  factory HealthData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData clone() => HealthData()..mergeFromMessage(this);
  HealthData copyWith(void Function(HealthData) updates) => super.copyWith((message) => updates(message as HealthData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData create() => HealthData._();
  HealthData createEmptyInstance() => create();
  static $pb.PbList<HealthData> createRepeated() => $pb.PbList<HealthData>();
  static HealthData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData _defaultInstance;

  $core.String get sampleType => $_getS(0, '');
  set sampleType($core.String v) { $_setString(0, v); }
  $core.bool hasSampleType() => $_has(0);
  void clearSampleType() => clearField(1);

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

  HealthTypes get type => $_getN(14);
  set type(HealthTypes v) { setField(15, v); }
  $core.bool hasType() => $_has(14);
  void clearType() => clearField(15);
}

class HealthDataList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthDataList')
    ..pc<HealthData>(1, 'data', $pb.PbFieldType.PM,HealthData.create)
    ..hasRequiredFields = false
  ;

  HealthDataList._() : super();
  factory HealthDataList() => create();
  factory HealthDataList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthDataList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthDataList clone() => HealthDataList()..mergeFromMessage(this);
  HealthDataList copyWith(void Function(HealthDataList) updates) => super.copyWith((message) => updates(message as HealthDataList));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthDataList create() => HealthDataList._();
  HealthDataList createEmptyInstance() => create();
  static $pb.PbList<HealthDataList> createRepeated() => $pb.PbList<HealthDataList>();
  static HealthDataList getDefault() => _defaultInstance ??= create()..freeze();
  static HealthDataList _defaultInstance;

  $core.List<HealthData> get data => $_getList(0);
}


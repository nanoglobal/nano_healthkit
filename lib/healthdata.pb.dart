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
    ..a<$core.int>(4, 'limit', $pb.PbFieldType.O3)
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

  $core.int get limit => $_get(3, 0);
  set limit($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasLimit() => $_has(3);
  void clearLimit() => clearField(4);
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

class HealthData_EmptySpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.EmptySpecificData')
    ..hasRequiredFields = false
  ;

  HealthData_EmptySpecificData._() : super();
  factory HealthData_EmptySpecificData() => create();
  factory HealthData_EmptySpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_EmptySpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_EmptySpecificData clone() => HealthData_EmptySpecificData()..mergeFromMessage(this);
  HealthData_EmptySpecificData copyWith(void Function(HealthData_EmptySpecificData) updates) => super.copyWith((message) => updates(message as HealthData_EmptySpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_EmptySpecificData create() => HealthData_EmptySpecificData._();
  HealthData_EmptySpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_EmptySpecificData> createRepeated() => $pb.PbList<HealthData_EmptySpecificData>();
  static HealthData_EmptySpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_EmptySpecificData _defaultInstance;
}

class HealthData_QuantitySpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.QuantitySpecificData')
    ..aInt64(101, 'count')
    ..aOS(102, 'quantityUnit')
    ..a<$core.double>(103, 'quantity', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  HealthData_QuantitySpecificData._() : super();
  factory HealthData_QuantitySpecificData() => create();
  factory HealthData_QuantitySpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_QuantitySpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_QuantitySpecificData clone() => HealthData_QuantitySpecificData()..mergeFromMessage(this);
  HealthData_QuantitySpecificData copyWith(void Function(HealthData_QuantitySpecificData) updates) => super.copyWith((message) => updates(message as HealthData_QuantitySpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_QuantitySpecificData create() => HealthData_QuantitySpecificData._();
  HealthData_QuantitySpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_QuantitySpecificData> createRepeated() => $pb.PbList<HealthData_QuantitySpecificData>();
  static HealthData_QuantitySpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_QuantitySpecificData _defaultInstance;

  Int64 get count => $_getI64(0);
  set count(Int64 v) { $_setInt64(0, v); }
  $core.bool hasCount() => $_has(0);
  void clearCount() => clearField(101);

  $core.String get quantityUnit => $_getS(1, '');
  set quantityUnit($core.String v) { $_setString(1, v); }
  $core.bool hasQuantityUnit() => $_has(1);
  void clearQuantityUnit() => clearField(102);

  $core.double get quantity => $_getN(2);
  set quantity($core.double v) { $_setDouble(2, v); }
  $core.bool hasQuantity() => $_has(2);
  void clearQuantity() => clearField(103);
}

class HealthData_CategorySpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.CategorySpecificData')
    ..aInt64(101, 'value')
    ..hasRequiredFields = false
  ;

  HealthData_CategorySpecificData._() : super();
  factory HealthData_CategorySpecificData() => create();
  factory HealthData_CategorySpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_CategorySpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_CategorySpecificData clone() => HealthData_CategorySpecificData()..mergeFromMessage(this);
  HealthData_CategorySpecificData copyWith(void Function(HealthData_CategorySpecificData) updates) => super.copyWith((message) => updates(message as HealthData_CategorySpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_CategorySpecificData create() => HealthData_CategorySpecificData._();
  HealthData_CategorySpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_CategorySpecificData> createRepeated() => $pb.PbList<HealthData_CategorySpecificData>();
  static HealthData_CategorySpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_CategorySpecificData _defaultInstance;

  Int64 get value => $_getI64(0);
  set value(Int64 v) { $_setInt64(0, v); }
  $core.bool hasValue() => $_has(0);
  void clearValue() => clearField(101);
}

class HealthData_WorkoutSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.WorkoutSpecificData')
    ..a<$core.double>(101, 'totalEnergyBurned', $pb.PbFieldType.OD)
    ..aOS(102, 'totalEnergyBurnedUnit')
    ..a<$core.double>(103, 'totalDistance', $pb.PbFieldType.OD)
    ..aOS(104, 'totalDistanceUnit')
    ..a<$core.double>(105, 'duration', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  HealthData_WorkoutSpecificData._() : super();
  factory HealthData_WorkoutSpecificData() => create();
  factory HealthData_WorkoutSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_WorkoutSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_WorkoutSpecificData clone() => HealthData_WorkoutSpecificData()..mergeFromMessage(this);
  HealthData_WorkoutSpecificData copyWith(void Function(HealthData_WorkoutSpecificData) updates) => super.copyWith((message) => updates(message as HealthData_WorkoutSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_WorkoutSpecificData create() => HealthData_WorkoutSpecificData._();
  HealthData_WorkoutSpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_WorkoutSpecificData> createRepeated() => $pb.PbList<HealthData_WorkoutSpecificData>();
  static HealthData_WorkoutSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_WorkoutSpecificData _defaultInstance;

  $core.double get totalEnergyBurned => $_getN(0);
  set totalEnergyBurned($core.double v) { $_setDouble(0, v); }
  $core.bool hasTotalEnergyBurned() => $_has(0);
  void clearTotalEnergyBurned() => clearField(101);

  $core.String get totalEnergyBurnedUnit => $_getS(1, '');
  set totalEnergyBurnedUnit($core.String v) { $_setString(1, v); }
  $core.bool hasTotalEnergyBurnedUnit() => $_has(1);
  void clearTotalEnergyBurnedUnit() => clearField(102);

  $core.double get totalDistance => $_getN(2);
  set totalDistance($core.double v) { $_setDouble(2, v); }
  $core.bool hasTotalDistance() => $_has(2);
  void clearTotalDistance() => clearField(103);

  $core.String get totalDistanceUnit => $_getS(3, '');
  set totalDistanceUnit($core.String v) { $_setString(3, v); }
  $core.bool hasTotalDistanceUnit() => $_has(3);
  void clearTotalDistanceUnit() => clearField(104);

  $core.double get duration => $_getN(4);
  set duration($core.double v) { $_setDouble(4, v); }
  $core.bool hasDuration() => $_has(4);
  void clearDuration() => clearField(105);
}

class HealthData_CharacteristicSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.CharacteristicSpecificData')
    ..aOS(101, 'value')
    ..hasRequiredFields = false
  ;

  HealthData_CharacteristicSpecificData._() : super();
  factory HealthData_CharacteristicSpecificData() => create();
  factory HealthData_CharacteristicSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_CharacteristicSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_CharacteristicSpecificData clone() => HealthData_CharacteristicSpecificData()..mergeFromMessage(this);
  HealthData_CharacteristicSpecificData copyWith(void Function(HealthData_CharacteristicSpecificData) updates) => super.copyWith((message) => updates(message as HealthData_CharacteristicSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_CharacteristicSpecificData create() => HealthData_CharacteristicSpecificData._();
  HealthData_CharacteristicSpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_CharacteristicSpecificData> createRepeated() => $pb.PbList<HealthData_CharacteristicSpecificData>();
  static HealthData_CharacteristicSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_CharacteristicSpecificData _defaultInstance;

  $core.String get value => $_getS(0, '');
  set value($core.String v) { $_setString(0, v); }
  $core.bool hasValue() => $_has(0);
  void clearValue() => clearField(101);
}

class HealthData_ClinicalRecordSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.ClinicalRecordSpecificData')
    ..aOS(101, 'displayName')
    ..aOS(102, 'fhirResource')
    ..hasRequiredFields = false
  ;

  HealthData_ClinicalRecordSpecificData._() : super();
  factory HealthData_ClinicalRecordSpecificData() => create();
  factory HealthData_ClinicalRecordSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_ClinicalRecordSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_ClinicalRecordSpecificData clone() => HealthData_ClinicalRecordSpecificData()..mergeFromMessage(this);
  HealthData_ClinicalRecordSpecificData copyWith(void Function(HealthData_ClinicalRecordSpecificData) updates) => super.copyWith((message) => updates(message as HealthData_ClinicalRecordSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_ClinicalRecordSpecificData create() => HealthData_ClinicalRecordSpecificData._();
  HealthData_ClinicalRecordSpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_ClinicalRecordSpecificData> createRepeated() => $pb.PbList<HealthData_ClinicalRecordSpecificData>();
  static HealthData_ClinicalRecordSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_ClinicalRecordSpecificData _defaultInstance;

  $core.String get displayName => $_getS(0, '');
  set displayName($core.String v) { $_setString(0, v); }
  $core.bool hasDisplayName() => $_has(0);
  void clearDisplayName() => clearField(101);

  $core.String get fhirResource => $_getS(1, '');
  set fhirResource($core.String v) { $_setString(1, v); }
  $core.bool hasFhirResource() => $_has(1);
  void clearFhirResource() => clearField(102);
}

class HealthData_DocumentSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.DocumentSpecificData')
    ..aOS(101, 'authorName')
    ..aOS(102, 'custodianName')
    ..aOS(103, 'documentData')
    ..aOS(104, 'patientName')
    ..aOS(105, 'title')
    ..hasRequiredFields = false
  ;

  HealthData_DocumentSpecificData._() : super();
  factory HealthData_DocumentSpecificData() => create();
  factory HealthData_DocumentSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_DocumentSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_DocumentSpecificData clone() => HealthData_DocumentSpecificData()..mergeFromMessage(this);
  HealthData_DocumentSpecificData copyWith(void Function(HealthData_DocumentSpecificData) updates) => super.copyWith((message) => updates(message as HealthData_DocumentSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_DocumentSpecificData create() => HealthData_DocumentSpecificData._();
  HealthData_DocumentSpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_DocumentSpecificData> createRepeated() => $pb.PbList<HealthData_DocumentSpecificData>();
  static HealthData_DocumentSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_DocumentSpecificData _defaultInstance;

  $core.String get authorName => $_getS(0, '');
  set authorName($core.String v) { $_setString(0, v); }
  $core.bool hasAuthorName() => $_has(0);
  void clearAuthorName() => clearField(101);

  $core.String get custodianName => $_getS(1, '');
  set custodianName($core.String v) { $_setString(1, v); }
  $core.bool hasCustodianName() => $_has(1);
  void clearCustodianName() => clearField(102);

  $core.String get documentData => $_getS(2, '');
  set documentData($core.String v) { $_setString(2, v); }
  $core.bool hasDocumentData() => $_has(2);
  void clearDocumentData() => clearField(103);

  $core.String get patientName => $_getS(3, '');
  set patientName($core.String v) { $_setString(3, v); }
  $core.bool hasPatientName() => $_has(3);
  void clearPatientName() => clearField(104);

  $core.String get title => $_getS(4, '');
  set title($core.String v) { $_setString(4, v); }
  $core.bool hasTitle() => $_has(4);
  void clearTitle() => clearField(105);
}

class HealthData_CorrelationSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.CorrelationSpecificData')
    ..pc<HealthData>(101, 'objects', $pb.PbFieldType.PM,HealthData.create)
    ..hasRequiredFields = false
  ;

  HealthData_CorrelationSpecificData._() : super();
  factory HealthData_CorrelationSpecificData() => create();
  factory HealthData_CorrelationSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_CorrelationSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_CorrelationSpecificData clone() => HealthData_CorrelationSpecificData()..mergeFromMessage(this);
  HealthData_CorrelationSpecificData copyWith(void Function(HealthData_CorrelationSpecificData) updates) => super.copyWith((message) => updates(message as HealthData_CorrelationSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_CorrelationSpecificData create() => HealthData_CorrelationSpecificData._();
  HealthData_CorrelationSpecificData createEmptyInstance() => create();
  static $pb.PbList<HealthData_CorrelationSpecificData> createRepeated() => $pb.PbList<HealthData_CorrelationSpecificData>();
  static HealthData_CorrelationSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_CorrelationSpecificData _defaultInstance;

  $core.List<HealthData> get objects => $_getList(0);
}

class HealthData_SourceRevision extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData.SourceRevision')
    ..aOS(101, 'version')
    ..aOS(102, 'operatingSystemVersion')
    ..aOS(103, 'productType')
    ..aOS(104, 'name')
    ..aOS(105, 'bundleIdentifier')
    ..hasRequiredFields = false
  ;

  HealthData_SourceRevision._() : super();
  factory HealthData_SourceRevision() => create();
  factory HealthData_SourceRevision.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthData_SourceRevision.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HealthData_SourceRevision clone() => HealthData_SourceRevision()..mergeFromMessage(this);
  HealthData_SourceRevision copyWith(void Function(HealthData_SourceRevision) updates) => super.copyWith((message) => updates(message as HealthData_SourceRevision));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HealthData_SourceRevision create() => HealthData_SourceRevision._();
  HealthData_SourceRevision createEmptyInstance() => create();
  static $pb.PbList<HealthData_SourceRevision> createRepeated() => $pb.PbList<HealthData_SourceRevision>();
  static HealthData_SourceRevision getDefault() => _defaultInstance ??= create()..freeze();
  static HealthData_SourceRevision _defaultInstance;

  $core.String get version => $_getS(0, '');
  set version($core.String v) { $_setString(0, v); }
  $core.bool hasVersion() => $_has(0);
  void clearVersion() => clearField(101);

  $core.String get operatingSystemVersion => $_getS(1, '');
  set operatingSystemVersion($core.String v) { $_setString(1, v); }
  $core.bool hasOperatingSystemVersion() => $_has(1);
  void clearOperatingSystemVersion() => clearField(102);

  $core.String get productType => $_getS(2, '');
  set productType($core.String v) { $_setString(2, v); }
  $core.bool hasProductType() => $_has(2);
  void clearProductType() => clearField(103);

  $core.String get name => $_getS(3, '');
  set name($core.String v) { $_setString(3, v); }
  $core.bool hasName() => $_has(3);
  void clearName() => clearField(104);

  $core.String get bundleIdentifier => $_getS(4, '');
  set bundleIdentifier($core.String v) { $_setString(4, v); }
  $core.bool hasBundleIdentifier() => $_has(4);
  void clearBundleIdentifier() => clearField(105);
}

enum HealthData_SpecificData {
  emptyData, 
  quantityData, 
  categoryData, 
  workoutData, 
  characteristicData, 
  clinicalRecordData, 
  documentData, 
  correlationData, 
  notSet
}

class HealthData extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, HealthData_SpecificData> _HealthData_SpecificDataByTag = {
    10 : HealthData_SpecificData.emptyData,
    11 : HealthData_SpecificData.quantityData,
    12 : HealthData_SpecificData.categoryData,
    13 : HealthData_SpecificData.workoutData,
    14 : HealthData_SpecificData.characteristicData,
    15 : HealthData_SpecificData.clinicalRecordData,
    16 : HealthData_SpecificData.documentData,
    17 : HealthData_SpecificData.correlationData,
    0 : HealthData_SpecificData.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HealthData')
    ..oo(0, [10, 11, 12, 13, 14, 15, 16, 17])
    ..e<HealthTypes>(1, 'type', $pb.PbFieldType.OE, HealthTypes.WORKOUT_MAIN, HealthTypes.valueOf, HealthTypes.values)
    ..aOS(2, 'objectType')
    ..aOS(3, 'startDate')
    ..aOS(4, 'endDate')
    ..aOS(5, 'device')
    ..aOS(6, 'metadata')
    ..aOS(7, 'uuid')
    ..a<HealthData_SourceRevision>(8, 'source', $pb.PbFieldType.OM, HealthData_SourceRevision.getDefault, HealthData_SourceRevision.create)
    ..a<HealthData_EmptySpecificData>(10, 'emptyData', $pb.PbFieldType.OM, HealthData_EmptySpecificData.getDefault, HealthData_EmptySpecificData.create)
    ..a<HealthData_QuantitySpecificData>(11, 'quantityData', $pb.PbFieldType.OM, HealthData_QuantitySpecificData.getDefault, HealthData_QuantitySpecificData.create)
    ..a<HealthData_CategorySpecificData>(12, 'categoryData', $pb.PbFieldType.OM, HealthData_CategorySpecificData.getDefault, HealthData_CategorySpecificData.create)
    ..a<HealthData_WorkoutSpecificData>(13, 'workoutData', $pb.PbFieldType.OM, HealthData_WorkoutSpecificData.getDefault, HealthData_WorkoutSpecificData.create)
    ..a<HealthData_CharacteristicSpecificData>(14, 'characteristicData', $pb.PbFieldType.OM, HealthData_CharacteristicSpecificData.getDefault, HealthData_CharacteristicSpecificData.create)
    ..a<HealthData_ClinicalRecordSpecificData>(15, 'clinicalRecordData', $pb.PbFieldType.OM, HealthData_ClinicalRecordSpecificData.getDefault, HealthData_ClinicalRecordSpecificData.create)
    ..a<HealthData_DocumentSpecificData>(16, 'documentData', $pb.PbFieldType.OM, HealthData_DocumentSpecificData.getDefault, HealthData_DocumentSpecificData.create)
    ..a<HealthData_CorrelationSpecificData>(17, 'correlationData', $pb.PbFieldType.OM, HealthData_CorrelationSpecificData.getDefault, HealthData_CorrelationSpecificData.create)
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

  HealthData_SpecificData whichSpecificData() => _HealthData_SpecificDataByTag[$_whichOneof(0)];
  void clearSpecificData() => clearField($_whichOneof(0));

  HealthTypes get type => $_getN(0);
  set type(HealthTypes v) { setField(1, v); }
  $core.bool hasType() => $_has(0);
  void clearType() => clearField(1);

  $core.String get objectType => $_getS(1, '');
  set objectType($core.String v) { $_setString(1, v); }
  $core.bool hasObjectType() => $_has(1);
  void clearObjectType() => clearField(2);

  $core.String get startDate => $_getS(2, '');
  set startDate($core.String v) { $_setString(2, v); }
  $core.bool hasStartDate() => $_has(2);
  void clearStartDate() => clearField(3);

  $core.String get endDate => $_getS(3, '');
  set endDate($core.String v) { $_setString(3, v); }
  $core.bool hasEndDate() => $_has(3);
  void clearEndDate() => clearField(4);

  $core.String get device => $_getS(4, '');
  set device($core.String v) { $_setString(4, v); }
  $core.bool hasDevice() => $_has(4);
  void clearDevice() => clearField(5);

  $core.String get metadata => $_getS(5, '');
  set metadata($core.String v) { $_setString(5, v); }
  $core.bool hasMetadata() => $_has(5);
  void clearMetadata() => clearField(6);

  $core.String get uuid => $_getS(6, '');
  set uuid($core.String v) { $_setString(6, v); }
  $core.bool hasUuid() => $_has(6);
  void clearUuid() => clearField(7);

  HealthData_SourceRevision get source => $_getN(7);
  set source(HealthData_SourceRevision v) { setField(8, v); }
  $core.bool hasSource() => $_has(7);
  void clearSource() => clearField(8);

  HealthData_EmptySpecificData get emptyData => $_getN(8);
  set emptyData(HealthData_EmptySpecificData v) { setField(10, v); }
  $core.bool hasEmptyData() => $_has(8);
  void clearEmptyData() => clearField(10);

  HealthData_QuantitySpecificData get quantityData => $_getN(9);
  set quantityData(HealthData_QuantitySpecificData v) { setField(11, v); }
  $core.bool hasQuantityData() => $_has(9);
  void clearQuantityData() => clearField(11);

  HealthData_CategorySpecificData get categoryData => $_getN(10);
  set categoryData(HealthData_CategorySpecificData v) { setField(12, v); }
  $core.bool hasCategoryData() => $_has(10);
  void clearCategoryData() => clearField(12);

  HealthData_WorkoutSpecificData get workoutData => $_getN(11);
  set workoutData(HealthData_WorkoutSpecificData v) { setField(13, v); }
  $core.bool hasWorkoutData() => $_has(11);
  void clearWorkoutData() => clearField(13);

  HealthData_CharacteristicSpecificData get characteristicData => $_getN(12);
  set characteristicData(HealthData_CharacteristicSpecificData v) { setField(14, v); }
  $core.bool hasCharacteristicData() => $_has(12);
  void clearCharacteristicData() => clearField(14);

  HealthData_ClinicalRecordSpecificData get clinicalRecordData => $_getN(13);
  set clinicalRecordData(HealthData_ClinicalRecordSpecificData v) { setField(15, v); }
  $core.bool hasClinicalRecordData() => $_has(13);
  void clearClinicalRecordData() => clearField(15);

  HealthData_DocumentSpecificData get documentData => $_getN(14);
  set documentData(HealthData_DocumentSpecificData v) { setField(16, v); }
  $core.bool hasDocumentData() => $_has(14);
  void clearDocumentData() => clearField(16);

  HealthData_CorrelationSpecificData get correlationData => $_getN(15);
  set correlationData(HealthData_CorrelationSpecificData v) { setField(17, v); }
  $core.bool hasCorrelationData() => $_has(15);
  void clearCorrelationData() => clearField(17);
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


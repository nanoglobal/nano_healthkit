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
    ..e<RequestSorting>(5, 'sorting', $pb.PbFieldType.OE, RequestSorting.DESCENDING_START_DATE, RequestSorting.valueOf, RequestSorting.values)
    ..pPS(6, 'units')
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

  RequestSorting get sorting => $_getN(4);
  set sorting(RequestSorting v) { setField(5, v); }
  $core.bool hasSorting() => $_has(4);
  void clearSorting() => clearField(5);

  $core.List<$core.String> get units => $_getList(5);
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
    ..a<SourceRevision>(8, 'source', $pb.PbFieldType.OM, SourceRevision.getDefault, SourceRevision.create)
    ..a<EmptySpecificData>(10, 'emptyData', $pb.PbFieldType.OM, EmptySpecificData.getDefault, EmptySpecificData.create)
    ..a<QuantitySpecificData>(11, 'quantityData', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<CategorySpecificData>(12, 'categoryData', $pb.PbFieldType.OM, CategorySpecificData.getDefault, CategorySpecificData.create)
    ..a<WorkoutSpecificData>(13, 'workoutData', $pb.PbFieldType.OM, WorkoutSpecificData.getDefault, WorkoutSpecificData.create)
    ..a<CharacteristicSpecificData>(14, 'characteristicData', $pb.PbFieldType.OM, CharacteristicSpecificData.getDefault, CharacteristicSpecificData.create)
    ..a<ClinicalRecordSpecificData>(15, 'clinicalRecordData', $pb.PbFieldType.OM, ClinicalRecordSpecificData.getDefault, ClinicalRecordSpecificData.create)
    ..a<DocumentSpecificData>(16, 'documentData', $pb.PbFieldType.OM, DocumentSpecificData.getDefault, DocumentSpecificData.create)
    ..a<CorrelationSpecificData>(17, 'correlationData', $pb.PbFieldType.OM, CorrelationSpecificData.getDefault, CorrelationSpecificData.create)
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

  SourceRevision get source => $_getN(7);
  set source(SourceRevision v) { setField(8, v); }
  $core.bool hasSource() => $_has(7);
  void clearSource() => clearField(8);

  EmptySpecificData get emptyData => $_getN(8);
  set emptyData(EmptySpecificData v) { setField(10, v); }
  $core.bool hasEmptyData() => $_has(8);
  void clearEmptyData() => clearField(10);

  QuantitySpecificData get quantityData => $_getN(9);
  set quantityData(QuantitySpecificData v) { setField(11, v); }
  $core.bool hasQuantityData() => $_has(9);
  void clearQuantityData() => clearField(11);

  CategorySpecificData get categoryData => $_getN(10);
  set categoryData(CategorySpecificData v) { setField(12, v); }
  $core.bool hasCategoryData() => $_has(10);
  void clearCategoryData() => clearField(12);

  WorkoutSpecificData get workoutData => $_getN(11);
  set workoutData(WorkoutSpecificData v) { setField(13, v); }
  $core.bool hasWorkoutData() => $_has(11);
  void clearWorkoutData() => clearField(13);

  CharacteristicSpecificData get characteristicData => $_getN(12);
  set characteristicData(CharacteristicSpecificData v) { setField(14, v); }
  $core.bool hasCharacteristicData() => $_has(12);
  void clearCharacteristicData() => clearField(14);

  ClinicalRecordSpecificData get clinicalRecordData => $_getN(13);
  set clinicalRecordData(ClinicalRecordSpecificData v) { setField(15, v); }
  $core.bool hasClinicalRecordData() => $_has(13);
  void clearClinicalRecordData() => clearField(15);

  DocumentSpecificData get documentData => $_getN(14);
  set documentData(DocumentSpecificData v) { setField(16, v); }
  $core.bool hasDocumentData() => $_has(14);
  void clearDocumentData() => clearField(16);

  CorrelationSpecificData get correlationData => $_getN(15);
  set correlationData(CorrelationSpecificData v) { setField(17, v); }
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

class EmptySpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('EmptySpecificData')
    ..hasRequiredFields = false
  ;

  EmptySpecificData._() : super();
  factory EmptySpecificData() => create();
  factory EmptySpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptySpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  EmptySpecificData clone() => EmptySpecificData()..mergeFromMessage(this);
  EmptySpecificData copyWith(void Function(EmptySpecificData) updates) => super.copyWith((message) => updates(message as EmptySpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EmptySpecificData create() => EmptySpecificData._();
  EmptySpecificData createEmptyInstance() => create();
  static $pb.PbList<EmptySpecificData> createRepeated() => $pb.PbList<EmptySpecificData>();
  static EmptySpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static EmptySpecificData _defaultInstance;
}

class QuantitySpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('QuantitySpecificData')
    ..aInt64(101, 'count')
    ..aOS(102, 'quantityUnit')
    ..a<$core.double>(103, 'quantity', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  QuantitySpecificData._() : super();
  factory QuantitySpecificData() => create();
  factory QuantitySpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuantitySpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  QuantitySpecificData clone() => QuantitySpecificData()..mergeFromMessage(this);
  QuantitySpecificData copyWith(void Function(QuantitySpecificData) updates) => super.copyWith((message) => updates(message as QuantitySpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuantitySpecificData create() => QuantitySpecificData._();
  QuantitySpecificData createEmptyInstance() => create();
  static $pb.PbList<QuantitySpecificData> createRepeated() => $pb.PbList<QuantitySpecificData>();
  static QuantitySpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static QuantitySpecificData _defaultInstance;

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

class CategorySpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CategorySpecificData')
    ..aInt64(101, 'value')
    ..hasRequiredFields = false
  ;

  CategorySpecificData._() : super();
  factory CategorySpecificData() => create();
  factory CategorySpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CategorySpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CategorySpecificData clone() => CategorySpecificData()..mergeFromMessage(this);
  CategorySpecificData copyWith(void Function(CategorySpecificData) updates) => super.copyWith((message) => updates(message as CategorySpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CategorySpecificData create() => CategorySpecificData._();
  CategorySpecificData createEmptyInstance() => create();
  static $pb.PbList<CategorySpecificData> createRepeated() => $pb.PbList<CategorySpecificData>();
  static CategorySpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static CategorySpecificData _defaultInstance;

  Int64 get value => $_getI64(0);
  set value(Int64 v) { $_setInt64(0, v); }
  $core.bool hasValue() => $_has(0);
  void clearValue() => clearField(101);
}

class WorkoutSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('WorkoutSpecificData')
    ..a<$core.double>(101, 'totalEnergyBurned', $pb.PbFieldType.OD)
    ..aOS(102, 'totalEnergyBurnedUnit')
    ..a<$core.double>(103, 'totalDistance', $pb.PbFieldType.OD)
    ..aOS(104, 'totalDistanceUnit')
    ..a<$core.double>(105, 'duration', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  WorkoutSpecificData._() : super();
  factory WorkoutSpecificData() => create();
  factory WorkoutSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkoutSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  WorkoutSpecificData clone() => WorkoutSpecificData()..mergeFromMessage(this);
  WorkoutSpecificData copyWith(void Function(WorkoutSpecificData) updates) => super.copyWith((message) => updates(message as WorkoutSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static WorkoutSpecificData create() => WorkoutSpecificData._();
  WorkoutSpecificData createEmptyInstance() => create();
  static $pb.PbList<WorkoutSpecificData> createRepeated() => $pb.PbList<WorkoutSpecificData>();
  static WorkoutSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static WorkoutSpecificData _defaultInstance;

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

class CharacteristicSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CharacteristicSpecificData')
    ..aOS(101, 'value')
    ..hasRequiredFields = false
  ;

  CharacteristicSpecificData._() : super();
  factory CharacteristicSpecificData() => create();
  factory CharacteristicSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CharacteristicSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CharacteristicSpecificData clone() => CharacteristicSpecificData()..mergeFromMessage(this);
  CharacteristicSpecificData copyWith(void Function(CharacteristicSpecificData) updates) => super.copyWith((message) => updates(message as CharacteristicSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CharacteristicSpecificData create() => CharacteristicSpecificData._();
  CharacteristicSpecificData createEmptyInstance() => create();
  static $pb.PbList<CharacteristicSpecificData> createRepeated() => $pb.PbList<CharacteristicSpecificData>();
  static CharacteristicSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static CharacteristicSpecificData _defaultInstance;

  $core.String get value => $_getS(0, '');
  set value($core.String v) { $_setString(0, v); }
  $core.bool hasValue() => $_has(0);
  void clearValue() => clearField(101);
}

class ClinicalRecordSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ClinicalRecordSpecificData')
    ..aOS(101, 'displayName')
    ..aOS(102, 'fhirResource')
    ..hasRequiredFields = false
  ;

  ClinicalRecordSpecificData._() : super();
  factory ClinicalRecordSpecificData() => create();
  factory ClinicalRecordSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClinicalRecordSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ClinicalRecordSpecificData clone() => ClinicalRecordSpecificData()..mergeFromMessage(this);
  ClinicalRecordSpecificData copyWith(void Function(ClinicalRecordSpecificData) updates) => super.copyWith((message) => updates(message as ClinicalRecordSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ClinicalRecordSpecificData create() => ClinicalRecordSpecificData._();
  ClinicalRecordSpecificData createEmptyInstance() => create();
  static $pb.PbList<ClinicalRecordSpecificData> createRepeated() => $pb.PbList<ClinicalRecordSpecificData>();
  static ClinicalRecordSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static ClinicalRecordSpecificData _defaultInstance;

  $core.String get displayName => $_getS(0, '');
  set displayName($core.String v) { $_setString(0, v); }
  $core.bool hasDisplayName() => $_has(0);
  void clearDisplayName() => clearField(101);

  $core.String get fhirResource => $_getS(1, '');
  set fhirResource($core.String v) { $_setString(1, v); }
  $core.bool hasFhirResource() => $_has(1);
  void clearFhirResource() => clearField(102);
}

class DocumentSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DocumentSpecificData')
    ..aOS(101, 'authorName')
    ..aOS(102, 'custodianName')
    ..aOS(103, 'documentData')
    ..aOS(104, 'patientName')
    ..aOS(105, 'title')
    ..hasRequiredFields = false
  ;

  DocumentSpecificData._() : super();
  factory DocumentSpecificData() => create();
  factory DocumentSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DocumentSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DocumentSpecificData clone() => DocumentSpecificData()..mergeFromMessage(this);
  DocumentSpecificData copyWith(void Function(DocumentSpecificData) updates) => super.copyWith((message) => updates(message as DocumentSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DocumentSpecificData create() => DocumentSpecificData._();
  DocumentSpecificData createEmptyInstance() => create();
  static $pb.PbList<DocumentSpecificData> createRepeated() => $pb.PbList<DocumentSpecificData>();
  static DocumentSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static DocumentSpecificData _defaultInstance;

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

class CorrelationSpecificData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CorrelationSpecificData')
    ..pc<HealthData>(101, 'objects', $pb.PbFieldType.PM,HealthData.create)
    ..hasRequiredFields = false
  ;

  CorrelationSpecificData._() : super();
  factory CorrelationSpecificData() => create();
  factory CorrelationSpecificData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CorrelationSpecificData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  CorrelationSpecificData clone() => CorrelationSpecificData()..mergeFromMessage(this);
  CorrelationSpecificData copyWith(void Function(CorrelationSpecificData) updates) => super.copyWith((message) => updates(message as CorrelationSpecificData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CorrelationSpecificData create() => CorrelationSpecificData._();
  CorrelationSpecificData createEmptyInstance() => create();
  static $pb.PbList<CorrelationSpecificData> createRepeated() => $pb.PbList<CorrelationSpecificData>();
  static CorrelationSpecificData getDefault() => _defaultInstance ??= create()..freeze();
  static CorrelationSpecificData _defaultInstance;

  $core.List<HealthData> get objects => $_getList(0);
}

class SourceRevision extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SourceRevision')
    ..aOS(101, 'version')
    ..aOS(102, 'operatingSystemVersion')
    ..aOS(103, 'productType')
    ..aOS(104, 'name')
    ..aOS(105, 'bundleIdentifier')
    ..hasRequiredFields = false
  ;

  SourceRevision._() : super();
  factory SourceRevision() => create();
  factory SourceRevision.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SourceRevision.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SourceRevision clone() => SourceRevision()..mergeFromMessage(this);
  SourceRevision copyWith(void Function(SourceRevision) updates) => super.copyWith((message) => updates(message as SourceRevision));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SourceRevision create() => SourceRevision._();
  SourceRevision createEmptyInstance() => create();
  static $pb.PbList<SourceRevision> createRepeated() => $pb.PbList<SourceRevision>();
  static SourceRevision getDefault() => _defaultInstance ??= create()..freeze();
  static SourceRevision _defaultInstance;

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

class StatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatisticsRequest')
    ..e<HealthTypes>(1, 'type', $pb.PbFieldType.OE, HealthTypes.WORKOUT_MAIN, HealthTypes.valueOf, HealthTypes.values)
    ..aOS(2, 'startDate')
    ..aOS(3, 'endDate')
    ..pc<StatisticsOptions>(4, 'options', $pb.PbFieldType.PE, null, StatisticsOptions.valueOf, StatisticsOptions.values)
    ..hasRequiredFields = false
  ;

  StatisticsRequest._() : super();
  factory StatisticsRequest() => create();
  factory StatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StatisticsRequest clone() => StatisticsRequest()..mergeFromMessage(this);
  StatisticsRequest copyWith(void Function(StatisticsRequest) updates) => super.copyWith((message) => updates(message as StatisticsRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatisticsRequest create() => StatisticsRequest._();
  StatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<StatisticsRequest> createRepeated() => $pb.PbList<StatisticsRequest>();
  static StatisticsRequest getDefault() => _defaultInstance ??= create()..freeze();
  static StatisticsRequest _defaultInstance;

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

  $core.List<StatisticsOptions> get options => $_getList(3);
}

class StatisticsData_StatisticsDataBySource extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatisticsData.StatisticsDataBySource')
    ..a<SourceRevision>(1, 'source', $pb.PbFieldType.OM, SourceRevision.getDefault, SourceRevision.create)
    ..a<StatisticsData>(2, 'data', $pb.PbFieldType.OM, StatisticsData.getDefault, StatisticsData.create)
    ..hasRequiredFields = false
  ;

  StatisticsData_StatisticsDataBySource._() : super();
  factory StatisticsData_StatisticsDataBySource() => create();
  factory StatisticsData_StatisticsDataBySource.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatisticsData_StatisticsDataBySource.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StatisticsData_StatisticsDataBySource clone() => StatisticsData_StatisticsDataBySource()..mergeFromMessage(this);
  StatisticsData_StatisticsDataBySource copyWith(void Function(StatisticsData_StatisticsDataBySource) updates) => super.copyWith((message) => updates(message as StatisticsData_StatisticsDataBySource));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatisticsData_StatisticsDataBySource create() => StatisticsData_StatisticsDataBySource._();
  StatisticsData_StatisticsDataBySource createEmptyInstance() => create();
  static $pb.PbList<StatisticsData_StatisticsDataBySource> createRepeated() => $pb.PbList<StatisticsData_StatisticsDataBySource>();
  static StatisticsData_StatisticsDataBySource getDefault() => _defaultInstance ??= create()..freeze();
  static StatisticsData_StatisticsDataBySource _defaultInstance;

  SourceRevision get source => $_getN(0);
  set source(SourceRevision v) { setField(1, v); }
  $core.bool hasSource() => $_has(0);
  void clearSource() => clearField(1);

  StatisticsData get data => $_getN(1);
  set data(StatisticsData v) { setField(2, v); }
  $core.bool hasData() => $_has(1);
  void clearData() => clearField(2);
}

class StatisticsData_TimeInterval extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatisticsData.TimeInterval')
    ..aOS(3, 'startDate')
    ..aOS(4, 'endDate')
    ..hasRequiredFields = false
  ;

  StatisticsData_TimeInterval._() : super();
  factory StatisticsData_TimeInterval() => create();
  factory StatisticsData_TimeInterval.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatisticsData_TimeInterval.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StatisticsData_TimeInterval clone() => StatisticsData_TimeInterval()..mergeFromMessage(this);
  StatisticsData_TimeInterval copyWith(void Function(StatisticsData_TimeInterval) updates) => super.copyWith((message) => updates(message as StatisticsData_TimeInterval));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatisticsData_TimeInterval create() => StatisticsData_TimeInterval._();
  StatisticsData_TimeInterval createEmptyInstance() => create();
  static $pb.PbList<StatisticsData_TimeInterval> createRepeated() => $pb.PbList<StatisticsData_TimeInterval>();
  static StatisticsData_TimeInterval getDefault() => _defaultInstance ??= create()..freeze();
  static StatisticsData_TimeInterval _defaultInstance;

  $core.String get startDate => $_getS(0, '');
  set startDate($core.String v) { $_setString(0, v); }
  $core.bool hasStartDate() => $_has(0);
  void clearStartDate() => clearField(3);

  $core.String get endDate => $_getS(1, '');
  set endDate($core.String v) { $_setString(1, v); }
  $core.bool hasEndDate() => $_has(1);
  void clearEndDate() => clearField(4);
}

class StatisticsData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('StatisticsData')
    ..pc<SourceRevision>(1, 'sources', $pb.PbFieldType.PM,SourceRevision.create)
    ..a<QuantitySpecificData>(2, 'averageQuantity', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<QuantitySpecificData>(3, 'maximumQuantity', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<QuantitySpecificData>(4, 'minimumQuantity', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<QuantitySpecificData>(5, 'sumQuantity', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<QuantitySpecificData>(6, 'duration', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<QuantitySpecificData>(7, 'mostRecentQuantity', $pb.PbFieldType.OM, QuantitySpecificData.getDefault, QuantitySpecificData.create)
    ..a<StatisticsData_TimeInterval>(8, 'mostRecentQuantityDateInterval', $pb.PbFieldType.OM, StatisticsData_TimeInterval.getDefault, StatisticsData_TimeInterval.create)
    ..a<StatisticsData_TimeInterval>(9, 'dataInterval', $pb.PbFieldType.OM, StatisticsData_TimeInterval.getDefault, StatisticsData_TimeInterval.create)
    ..pc<StatisticsData_StatisticsDataBySource>(10, 'dataBySource', $pb.PbFieldType.PM,StatisticsData_StatisticsDataBySource.create)
    ..hasRequiredFields = false
  ;

  StatisticsData._() : super();
  factory StatisticsData() => create();
  factory StatisticsData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StatisticsData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  StatisticsData clone() => StatisticsData()..mergeFromMessage(this);
  StatisticsData copyWith(void Function(StatisticsData) updates) => super.copyWith((message) => updates(message as StatisticsData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StatisticsData create() => StatisticsData._();
  StatisticsData createEmptyInstance() => create();
  static $pb.PbList<StatisticsData> createRepeated() => $pb.PbList<StatisticsData>();
  static StatisticsData getDefault() => _defaultInstance ??= create()..freeze();
  static StatisticsData _defaultInstance;

  $core.List<SourceRevision> get sources => $_getList(0);

  QuantitySpecificData get averageQuantity => $_getN(1);
  set averageQuantity(QuantitySpecificData v) { setField(2, v); }
  $core.bool hasAverageQuantity() => $_has(1);
  void clearAverageQuantity() => clearField(2);

  QuantitySpecificData get maximumQuantity => $_getN(2);
  set maximumQuantity(QuantitySpecificData v) { setField(3, v); }
  $core.bool hasMaximumQuantity() => $_has(2);
  void clearMaximumQuantity() => clearField(3);

  QuantitySpecificData get minimumQuantity => $_getN(3);
  set minimumQuantity(QuantitySpecificData v) { setField(4, v); }
  $core.bool hasMinimumQuantity() => $_has(3);
  void clearMinimumQuantity() => clearField(4);

  QuantitySpecificData get sumQuantity => $_getN(4);
  set sumQuantity(QuantitySpecificData v) { setField(5, v); }
  $core.bool hasSumQuantity() => $_has(4);
  void clearSumQuantity() => clearField(5);

  QuantitySpecificData get duration => $_getN(5);
  set duration(QuantitySpecificData v) { setField(6, v); }
  $core.bool hasDuration() => $_has(5);
  void clearDuration() => clearField(6);

  QuantitySpecificData get mostRecentQuantity => $_getN(6);
  set mostRecentQuantity(QuantitySpecificData v) { setField(7, v); }
  $core.bool hasMostRecentQuantity() => $_has(6);
  void clearMostRecentQuantity() => clearField(7);

  StatisticsData_TimeInterval get mostRecentQuantityDateInterval => $_getN(7);
  set mostRecentQuantityDateInterval(StatisticsData_TimeInterval v) { setField(8, v); }
  $core.bool hasMostRecentQuantityDateInterval() => $_has(7);
  void clearMostRecentQuantityDateInterval() => clearField(8);

  StatisticsData_TimeInterval get dataInterval => $_getN(8);
  set dataInterval(StatisticsData_TimeInterval v) { setField(9, v); }
  $core.bool hasDataInterval() => $_has(8);
  void clearDataInterval() => clearField(9);

  $core.List<StatisticsData_StatisticsDataBySource> get dataBySource => $_getList(9);
}


///
//  Generated code. Do not modify.
//  source: BookInfo.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, pragma, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

class BookInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BookInfo')
    ..aInt64(1, 'id')
    ..aOS(2, 'title')
    ..aOS(3, 'author')
    ..hasRequiredFields = false
  ;

  BookInfo._() : super();
  factory BookInfo() => create();
  factory BookInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BookInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  BookInfo clone() => BookInfo()..mergeFromMessage(this);
  BookInfo copyWith(void Function(BookInfo) updates) => super.copyWith((message) => updates(message as BookInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BookInfo create() => BookInfo._();
  BookInfo createEmptyInstance() => create();
  static $pb.PbList<BookInfo> createRepeated() => $pb.PbList<BookInfo>();
  static BookInfo getDefault() => _defaultInstance ??= create()..freeze();
  static BookInfo _defaultInstance;

  Int64 get id => $_getI64(0);
  set id(Int64 v) { $_setInt64(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get title => $_getS(1, '');
  set title($core.String v) { $_setString(1, v); }
  $core.bool hasTitle() => $_has(1);
  void clearTitle() => clearField(2);

  $core.String get author => $_getS(2, '');
  set author($core.String v) { $_setString(2, v); }
  $core.bool hasAuthor() => $_has(2);
  void clearAuthor() => clearField(3);
}


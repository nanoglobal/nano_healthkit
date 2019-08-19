// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: HealthKitData.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct HealthKitData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var type: String = String()

  var startDate: String = String()

  var endDate: String = String()

  var device: String = String()

  var metadata: String = String()

  var count: Int64 = 0

  var quantityUnit: String = String()

  var quantity: Double = 0

  var value: Int64 = 0

  var totalEnergyBurned: Double = 0

  var totalEnergyBurnedUnit: String = String()

  var totalDistance: Double = 0

  var totalDistanceUnit: String = String()

  var duration: Double = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct HealthKitDataBatch {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var type: [HealthKitData] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension HealthKitData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "HealthKitData"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .same(proto: "startDate"),
    3: .same(proto: "endDate"),
    4: .same(proto: "device"),
    5: .same(proto: "metadata"),
    6: .same(proto: "count"),
    7: .same(proto: "quantityUnit"),
    8: .same(proto: "quantity"),
    9: .same(proto: "value"),
    10: .same(proto: "totalEnergyBurned"),
    11: .same(proto: "totalEnergyBurnedUnit"),
    12: .same(proto: "totalDistance"),
    13: .same(proto: "totalDistanceUnit"),
    14: .same(proto: "duration"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.type)
      case 2: try decoder.decodeSingularStringField(value: &self.startDate)
      case 3: try decoder.decodeSingularStringField(value: &self.endDate)
      case 4: try decoder.decodeSingularStringField(value: &self.device)
      case 5: try decoder.decodeSingularStringField(value: &self.metadata)
      case 6: try decoder.decodeSingularInt64Field(value: &self.count)
      case 7: try decoder.decodeSingularStringField(value: &self.quantityUnit)
      case 8: try decoder.decodeSingularDoubleField(value: &self.quantity)
      case 9: try decoder.decodeSingularInt64Field(value: &self.value)
      case 10: try decoder.decodeSingularDoubleField(value: &self.totalEnergyBurned)
      case 11: try decoder.decodeSingularStringField(value: &self.totalEnergyBurnedUnit)
      case 12: try decoder.decodeSingularDoubleField(value: &self.totalDistance)
      case 13: try decoder.decodeSingularStringField(value: &self.totalDistanceUnit)
      case 14: try decoder.decodeSingularDoubleField(value: &self.duration)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.type.isEmpty {
      try visitor.visitSingularStringField(value: self.type, fieldNumber: 1)
    }
    if !self.startDate.isEmpty {
      try visitor.visitSingularStringField(value: self.startDate, fieldNumber: 2)
    }
    if !self.endDate.isEmpty {
      try visitor.visitSingularStringField(value: self.endDate, fieldNumber: 3)
    }
    if !self.device.isEmpty {
      try visitor.visitSingularStringField(value: self.device, fieldNumber: 4)
    }
    if !self.metadata.isEmpty {
      try visitor.visitSingularStringField(value: self.metadata, fieldNumber: 5)
    }
    if self.count != 0 {
      try visitor.visitSingularInt64Field(value: self.count, fieldNumber: 6)
    }
    if !self.quantityUnit.isEmpty {
      try visitor.visitSingularStringField(value: self.quantityUnit, fieldNumber: 7)
    }
    if self.quantity != 0 {
      try visitor.visitSingularDoubleField(value: self.quantity, fieldNumber: 8)
    }
    if self.value != 0 {
      try visitor.visitSingularInt64Field(value: self.value, fieldNumber: 9)
    }
    if self.totalEnergyBurned != 0 {
      try visitor.visitSingularDoubleField(value: self.totalEnergyBurned, fieldNumber: 10)
    }
    if !self.totalEnergyBurnedUnit.isEmpty {
      try visitor.visitSingularStringField(value: self.totalEnergyBurnedUnit, fieldNumber: 11)
    }
    if self.totalDistance != 0 {
      try visitor.visitSingularDoubleField(value: self.totalDistance, fieldNumber: 12)
    }
    if !self.totalDistanceUnit.isEmpty {
      try visitor.visitSingularStringField(value: self.totalDistanceUnit, fieldNumber: 13)
    }
    if self.duration != 0 {
      try visitor.visitSingularDoubleField(value: self.duration, fieldNumber: 14)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: HealthKitData, rhs: HealthKitData) -> Bool {
    if lhs.type != rhs.type {return false}
    if lhs.startDate != rhs.startDate {return false}
    if lhs.endDate != rhs.endDate {return false}
    if lhs.device != rhs.device {return false}
    if lhs.metadata != rhs.metadata {return false}
    if lhs.count != rhs.count {return false}
    if lhs.quantityUnit != rhs.quantityUnit {return false}
    if lhs.quantity != rhs.quantity {return false}
    if lhs.value != rhs.value {return false}
    if lhs.totalEnergyBurned != rhs.totalEnergyBurned {return false}
    if lhs.totalEnergyBurnedUnit != rhs.totalEnergyBurnedUnit {return false}
    if lhs.totalDistance != rhs.totalDistance {return false}
    if lhs.totalDistanceUnit != rhs.totalDistanceUnit {return false}
    if lhs.duration != rhs.duration {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension HealthKitDataBatch: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "HealthKitDataBatch"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.type)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.type.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.type, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: HealthKitDataBatch, rhs: HealthKitDataBatch) -> Bool {
    if lhs.type != rhs.type {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

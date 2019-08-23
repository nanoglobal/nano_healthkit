///
//  Generated code. Do not modify.
//  source: healthdata.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const HealthTypes$json = const {
  '1': 'HealthTypes',
  '2': const [
    const {'1': 'WORKOUT_MAIN', '2': 0},
    const {'1': 'CATEGORY_SLEEP_ANALYSIS', '2': 1},
    const {'1': 'CATEGORY_APPLE_STAND_HOUR', '2': 2},
    const {'1': 'CATEGORY_CervicalMucusQuality', '2': 3},
    const {'1': 'QUANTITY_BodyMassIndex', '2': 4},
    const {'1': 'QUANTITY_BodyFatPercentage', '2': 5},
    const {'1': 'QUANTITY_HEIGHT', '2': 6},
  ],
};

const HealthTypeList$json = const {
  '1': 'HealthTypeList',
  '2': const [
    const {'1': 'types', '3': 1, '4': 3, '5': 14, '6': '.HealthTypes', '10': 'types'},
  ],
};

const HealthDataRequest$json = const {
  '1': 'HealthDataRequest',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.HealthTypes', '10': 'type'},
    const {'1': 'startDate', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'endDate', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
  ],
};

const HealthDataRequestList$json = const {
  '1': 'HealthDataRequestList',
  '2': const [
    const {'1': 'requests', '3': 1, '4': 3, '5': 11, '6': '.HealthDataRequest', '10': 'requests'},
  ],
};

const HealthData$json = const {
  '1': 'HealthData',
  '2': const [
    const {'1': 'sampleType', '3': 1, '4': 1, '5': 9, '10': 'sampleType'},
    const {'1': 'startDate', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    const {'1': 'endDate', '3': 3, '4': 1, '5': 9, '10': 'endDate'},
    const {'1': 'device', '3': 4, '4': 1, '5': 9, '10': 'device'},
    const {'1': 'metadata', '3': 5, '4': 1, '5': 9, '10': 'metadata'},
    const {'1': 'count', '3': 6, '4': 1, '5': 3, '10': 'count'},
    const {'1': 'quantityUnit', '3': 7, '4': 1, '5': 9, '10': 'quantityUnit'},
    const {'1': 'quantity', '3': 8, '4': 1, '5': 1, '10': 'quantity'},
    const {'1': 'value', '3': 9, '4': 1, '5': 3, '10': 'value'},
    const {'1': 'totalEnergyBurned', '3': 10, '4': 1, '5': 1, '10': 'totalEnergyBurned'},
    const {'1': 'totalEnergyBurnedUnit', '3': 11, '4': 1, '5': 9, '10': 'totalEnergyBurnedUnit'},
    const {'1': 'totalDistance', '3': 12, '4': 1, '5': 1, '10': 'totalDistance'},
    const {'1': 'totalDistanceUnit', '3': 13, '4': 1, '5': 9, '10': 'totalDistanceUnit'},
    const {'1': 'duration', '3': 14, '4': 1, '5': 1, '10': 'duration'},
    const {'1': 'type', '3': 15, '4': 1, '5': 14, '6': '.HealthTypes', '10': 'type'},
  ],
};

const HealthDataList$json = const {
  '1': 'HealthDataList',
  '2': const [
    const {'1': 'data', '3': 1, '4': 3, '5': 11, '6': '.HealthData', '10': 'data'},
  ],
};


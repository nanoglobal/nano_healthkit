# Nano's Healthkit Plugin for Flutter

## Installation

To modify the model, change the .proto files.

### Install Protobuf:
```
brew install protobuf
pub global activate protoc_plugin
```

If couldnt find 'pub' then add to your path:
```
{YOUR FLUTTER DIR}/flutter/bin/cache/dart-sdk/bin
```

### To convert a .proto file to Swift *:
First cd to the proto folder
```
protoc --swift_out=. HealthKitData.proto
```

### To convert a .proto file to Dart *:
First cd to the proto folder
```
protoc --dart_out=. HealthKitData.proto
```

\* Remember to move the generated files to the correct project folders (both in Swift and in Flutter).

## Requirements

The plugin needs a deployment target of at least iOS 11.2.

For more information check out the Example project.


## Usage

The methods are the following:

### Request permissions
```
authorize() -> Bool
```
The user will be presented with a native modal that request permissions to read all contamplated values, the answer will be successfull even when the user chooses to aprobe none of the permissions (thats because iOS doesnt give feedback of which permissions the user has aprobed).

#### Params
None

#### Return
Bool: False only in case of an error and true in any other case.

### Fetch data
```
getUserBasicHealthData(HealthKitDataBatchRequest request) -> HealthKitDataBatch
```
#### Params
HealthKitDataBatchRequest: Indicate the type of data wanted to be read, an index depending on the type of data (check the arrays in AppleHealthUtils), startDate and endDate. The dates can be empty strings to fetch all historical data, otherwise use ISO8601 format ("yyyy-MM-dd'T'HH:mm:ss.SSSX"). The index values can be as follows:
- Between `0 and 79` for Quantities
- Between `0 and 7` for Categories
- Only `0` for Workout

#### Return
HealthKitDataBatch: Contains a list of HealthKitData. It will return nil in case of error.




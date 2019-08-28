# Nano's Healthkit Plugin for Flutter

## Installation

To modify the model, change the .proto files.

### Install Protobuf:
```
brew install protobuf
pub global activate protoc_plugin
```

If couldn't find 'pub' then add to your path:
```
{YOUR FLUTTER DIR}/flutter/bin/cache/dart-sdk/bin
```

### To convert all proto files:
First cd to the proto folder
```
./auto_proto.sh --dart=../lib --swift=../ios/Classes
```

\* You can also indicate a different origin folder, different destinies and also add a java option if needed.

## Requirements

The plugin needs a deployment target of at least iOS 9.0.

For more information check out the Example project.


## Usage

The methods are the following:

### Request permissions
```
authorize(HealthTypeList request) -> Bool
```
The user will be presented with a native modal that request permissions to read all values in the request, the answer will be successful even when the user chooses not to approve any of the permissions (that's because iOS doesn't give feedback of which permissions the user has approved).

All invalid permission types (because the iOS version is lower than the requested type) will be ignored.

#### Params
HealthTypeList: Contains a list of HealthTypes to request for reading permissions. 

#### Return
Bool: False only in case of an error and true in any other case.

### Filter Existing Types
```
filterExistingTypes(HealthDataList request) -> HealthDataList
```
Will check if the requested types are available in the user's phone model. The fact that a type exists doesn't mean that there are enough permissions to read that value (this is due to the fact that you can't check if permissions to read where given or not).

#### Params
HealthDataList: Contains a list of HealthTypes to check. 

#### Return
HealthDataList: Contains a similar list to the requested one that only contains valid items to fetch.


### Fetch data
```
fetchData(HealthDataRequest request) -> HealthDataList
```
The requested type gets fetched from Apple's HealthKit and returned.

If querying for an invalid type (because the iOS version is lower than the requested type) an exception will be thrown.

#### Params
HealthDataRequest: Indicate the type of data wanted to be read (see HealthTypes), startDate and endDate. The dates can be empty strings to fetch all historical data, otherwise use ISO8601 format ("yyyy-MM-dd'T'HH:mm:ss.SSSX").

#### Return
HealthDataList: Contains a list of HealthData.

## A word about Timezones

The values in Apple Health are stored in the local time of the phone at the moment they are written but they don't hold timezone information. That means that if you record something at 13:00 in timezone -3 it will be retrieved as 10:00 in GMT and when showed, considering the user is still at that same timezone it will be shown as 13:00. However, the timezone the user currently is doesn't necessary matches the timezone in which he/she made the record and this might lead to misunderstandings.

Depending on the source, Apple Health sometimes saves information about the timezone in which the record was made inside the metadata.


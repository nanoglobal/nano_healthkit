# Nano's HealthKit Plugin for Flutter

Flutter plugin to read data from Apple's HealthKit, request for permissions, subscribe to updates in background and run statistics queries. It also supports Health Records, batch fetching of historical data and more.

It supports readings of _ALL_ types of data available up to iOS 13.0 (except for series types). Check the HealthTypes section for a full list.

Currently, writing data into HealthKit is not supported.

## Quick setup

1. Add the plugin to your project's `pubspec.yaml`.

2. Enable HealthKit capabilities (and also HealthRecords if desired) in Xcode.

3. Add the necessary entitlements in `Info.plist`.

Detailed instructions can be found on [our wiki](https://github.com/nanoglobal/nano-healthkit-plugin-flutter/wiki/Installation).

## Examples

#### Permissions

Request permissions to read heart rate and height:
```dart
var request = HealthTypeList();
request.types.add(HealthTypes.QUANTITY_HEART_RATE);
request.types.add(HealthTypes.QUANTITY_HEIGHT);
bool isAuthorized = await NanoHealthkitPlugin.authorize(request);
```
 
#### Read data

Fetch the latest entry of heart rate:
```dart
var request = HealthDataRequest();
request.type = HealthTypes.QUANTITY_HEART_RATE;
request.limit = 1; // If the limit is removed, it will fetch all historical data for heart rate
var response = await NanoHealthkitPlugin.fetchData(request);
```

The response looks like this:
```bash
{
  type: QUANTITY_HEART_RATE
  objectType: HKQuantityTypeIdentifierHeartRate
  startDate: 2019-10-03T18:30:00.000Z
  endDate: 2019-10-03T18:30:00.000Z
  metadata: {"HKWasUserEntered":1}
  uuid: FA64A6C0-B330-48D7-A6D5-B588533E9D4D
  source: {
    version: 13.0
    operatingSystemVersion: 13.0.0
    productType: iPhone12,5
    name: Health
    bundleIdentifier: com.apple.Health
  }
  quantityData: {
    count: 1
    quantityUnit: count/s
    quantity: 2.1666666666666665
  }
}
```

#### Subscribe

Subscribe to new entries of height:
```dart
var request = HealthTypeList();
request.types.add(HealthTypes.QUANTITY_HEIGHT);
_subscription = NanoHealthkitPlugin.subscribeToUpdates(request, _updatesReceived);
```

The updatesReceived method gets all new entries (even while the app is in background) in the same structure as the fetching of data.

## Docs

Check our [Wiki](https://github.com/nanoglobal/nano-healthkit-plugin-flutter/wiki) for more details.


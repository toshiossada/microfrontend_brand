# Responsys

This package provides integration with PushIOManager SDK from Oracle's Responsys.

# Installation

## Android configurarion

Follow the steps 1 and 2 from [Android Step-By-Step](https://docs.oracle.com/en/cloud/saas/marketing/responsys-develop-mobile/android/step-by-step.htm) guide, puting the `pushio_config.json` inside of the `android/app/src/main/assets` folder.

Add the Responsys dependency on pubspec.yaml

## IOS configurarion

// PENDING

## Usage

```yaml
dependencies:
  responsys:
```

Import the Responsys on the file where it's used:

```dart
import 'package:responsys/responsys.dart';
```

Initialize the Responsys package:

```dart
Responsys.init();
```

## Notification icon location

The Responsys package expects an icon file named `notification.webp` located on the `android/app/src/main/res/drawable` folder. If does'n existe, the notification will use the default notification icon from Android.

## Registering and unregistering userId

To register and unregister an userId the Responsys provides the `Responsys.registerUserId` and `Responsys.unregisterUserId` methods

```dart
Responsys.registerUserId("teste@email.com");
Responsys.unregisterUserId();
```

## Listening for foreground notifications

To handle foreground notification the Responsys provides the `Responsys.handleForegroundNotification` method, it returns a stream of `PushNotification` that streams every time a new push is fired by the PushIOManager SDK while the app is oppen.

```dart
Responsys.handleForegroundNotification.listen((PushNotification notification) => print(notification.alert));
```
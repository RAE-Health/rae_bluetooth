# rae_bluetooth

Gets the state/status of a phone's bluetooth.

## Install

```text
dependencies:
  rae_bluetooth:
    git:
      url: {url of github repo}
```

## Import

```dart
import 'package:empty_packge/rae_bluetooth.dart';
```

## iOS Settings

```text
info.plist
 Privacy - Bluetooth Always Usage Description       "Reason to use bluetooth always"
 Privacy - Bluetooth Peripheral Usage Description   "Reason to use bluetooth"
 > Required background modes
    Item 0                                          App communicates using CoreBluetooth

info.plist as keys:
  NSBluetoothAlwaysUsageDescription                 "Reason to use bluetooth always"
  NSBluetoothPeripheralUsageDescription             "Reason to use bluetooth"
  > UIBackgroundModes
     Item 0                                         bluetooth-central
```

### NOTE

"**Reason to use bluetooth always**", "**Reason to use bluetooth**" text that appears in system prompts

Provide details/examples on usage.

## Final Note

Be kind to each other

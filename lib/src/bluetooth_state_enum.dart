import 'package:flutter/material.dart';

enum BluetoothStateEnum {
  notReceivingData, //Custom
  poweredOff, //iOS
  poweredOn, //iOS
  receivingData, //Custom
  resetting, //iOS
  unauthorized, //iOS
  unknown, //iOS
  unsupported, //iOS
}

extension BluetoothStateEnumExtension on BluetoothStateEnum {
  static BluetoothStateEnum from({required String string}) {
    for (BluetoothStateEnum state in BluetoothStateEnum.values) {
      if (state.name == string) return state;
    }
    throw FlutterError(('could not match: $string'));
  }
}

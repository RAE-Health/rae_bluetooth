import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rae_bluetooth/src/bluetooth_state_enum.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  static const bleStateEventChannel = EventChannel('com.ltmm.ble/blestatus');
  StreamSubscription? _bleStateSubscription;
  BluetoothStateEnum _currentBluetoothState = BluetoothStateEnum.unknown;

  BluetoothCubit() : super(BluetoothInitial());

  void getBluetoothStatus() async {
    var status = await Permission.bluetooth.status;
    debugPrint('getBluetoothStatus $status');
    if (status.isDenied) emit(BluetoothDeniedState());
  }

  void requestCurrentBluetoothState() {
    emit(BluetoothCurrentState(_currentBluetoothState));
  }

  void requestBluetooth() async {
    var status = await Permission.bluetooth.request();
    debugPrint('getBluetoothStatus $status');
  }

  void startReceivingBluetoothUpdates() {
    if (_bleStateSubscription == null) {
      _bleStateSubscription = bleStateEventChannel.receiveBroadcastStream().listen((event) {
        debugPrint('BLE EVENT: ${event.toString()}');
      });
    }
  }

  void stopReceivingBluetoothUpdates() {
    _bleStateSubscription?.cancel();
    _bleStateSubscription = null;
  }
}

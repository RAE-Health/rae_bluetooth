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
    Future.delayed(Duration.zero, () {
      emit(BluetoothCurrentState(_currentBluetoothState));
    });
  }

  void requestBluetooth() async {
    var status = await Permission.bluetooth.request();
    debugPrint('getBluetoothStatus $status');
  }

  void startReceivingBluetoothUpdates() {
    if (_bleStateSubscription == null) {
      _bleStateSubscription = bleStateEventChannel.receiveBroadcastStream().listen((event) {
        debugPrint('BLE EVENT: ${event.toString()}');
        _currentBluetoothState = BluetoothStateEnumExtension.from(string: event.toString());
        debugPrint('BLE STATE: ${_currentBluetoothState.toString()}');
        switch (_currentBluetoothState) {
          case BluetoothStateEnum.notReceivingData:
            // TODO: Handle this case.
            break;
          case BluetoothStateEnum.poweredOff:
            emit(BluetoothPowerOffState());
            return;
          case BluetoothStateEnum.poweredOn:
            emit(BluetoothPowerOnState());
            return;
          case BluetoothStateEnum.receivingData:
            // TODO: Handle this case.
            break;
          case BluetoothStateEnum.resetting:
            // TODO: Handle this case.
            break;
          case BluetoothStateEnum.unauthorized:
            // TODO: Handle this case.
            break;
          case BluetoothStateEnum.unknown:
            // TODO: Handle this case.
            break;
          case BluetoothStateEnum.unsupported:
            // TODO: Handle this case.
            break;
        }
        // Future.delayed(Duration(milliseconds: 250), () {
        //   emit(BluetoothCurrentState(_currentBluetoothState));
        // });
      });
    }
  }

  void stopReceivingBluetoothUpdates() {
    _bleStateSubscription?.cancel();
    _bleStateSubscription = null;
  }
}

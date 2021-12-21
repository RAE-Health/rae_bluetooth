import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  BluetoothCubit() : super(BluetoothInitial());

  void getBluetoothStatus() async {
    var status = await Permission.bluetooth.status;
    debugPrint('getBluetoothStatus $status');
    if (status.isDenied) emit(BluetoothDeniedState());
    
  }

  void requestBluetooth() async {
    var status = await Permission.bluetooth.request();
    debugPrint('getBluetoothStatus $status');
  }
}

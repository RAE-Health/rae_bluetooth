part of 'bluetooth_cubit.dart';

@immutable
abstract class BluetoothState {}

class BluetoothInitial extends BluetoothState {}

class BluetoothDeniedState extends BluetoothState {}
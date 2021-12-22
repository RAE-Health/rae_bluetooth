import 'package:flutter/widgets.dart';

import '../../rae_bluetooth.dart';

class IOSBluetoothBannerWidget extends StatelessWidget {
  final BluetoothStateEnum iosBluetoothState;
  final Size size;
  const IOSBluetoothBannerWidget({
    required this.iosBluetoothState,
    this.size = const Size.square(48.0),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_widgetForIOSBluetoothState(), _caption()],
    );
  }

  Widget _caption() {
    var result = '';
    switch (iosBluetoothState) {
      case BluetoothStateEnum.poweredOn:
        result = 'Bluetooth is powered on';
        break;
      case BluetoothStateEnum.poweredOff:
        result = 'Bluetooth is powered off';
        break;
      case BluetoothStateEnum.unknown:
        result = 'Bluetooth is unknown';
        break;
      case BluetoothStateEnum.resetting:
        result = 'Bluetooth is resetting';
        break;
      case BluetoothStateEnum.unsupported:
        result = 'No bluetooth';
        break;
      case BluetoothStateEnum.unauthorized:
        result = 'Bluetooth permission denied';
        break;
      case BluetoothStateEnum.notReceivingData:
        result = 'No sensor data';
        break;
      case BluetoothStateEnum.receivingData:
        result = 'Device is receiving data!';
        break;
    }
    return Text(
      result,
      style: TextStyle(fontSize: 20.0),
    );
  }

  Widget _widgetForIOSBluetoothState() {
    final defaultUseSize = size;
    switch (iosBluetoothState) {
      case BluetoothStateEnum.poweredOn:
        return BluetoothStatusImageWidget(state: BluetoothStateEnum.poweredOn, size: Size.copy(defaultUseSize));
      case BluetoothStateEnum.poweredOff:
        return BluetoothStatusImageWidget(state: BluetoothStateEnum.poweredOff, size: Size.copy(defaultUseSize));
      case BluetoothStateEnum.unknown:
        return Text('?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0));
      case BluetoothStateEnum.resetting:
        return Text('R', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0));
      case BluetoothStateEnum.unsupported:
        return Text('U', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0));
      case BluetoothStateEnum.unauthorized:
        return BluetoothStatusImageWidget(state: BluetoothStateEnum.unauthorized, size: Size.copy(defaultUseSize));
      case BluetoothStateEnum.notReceivingData:
        return BluetoothStatusImageWidget(state: BluetoothStateEnum.notReceivingData, size: Size.copy(defaultUseSize));
      case BluetoothStateEnum.receivingData:
        return BluetoothStatusImageWidget(state: BluetoothStateEnum.receivingData, size: Size.copy(defaultUseSize));
    }
  }
}

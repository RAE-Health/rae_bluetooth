import 'package:flutter/material.dart';

import 'bluetooth_state_enum.dart';

const double _scale = 0.35;
const double _widthScale = 1.15;

AssetImage get bluetoothAsset => AssetImage('assets/bluetooth.png', package: 'rae_bluetooth');
AssetImage get bluetoothOffAsset => AssetImage('assets/bluetooth_off.png', package: 'rae_bluetooth');
AssetImage get checkmarkAsset => AssetImage('assets/checkmark.png', package: 'rae_bluetooth');
AssetImage get circleXAsset => AssetImage('assets/circle_x.png', package: 'rae_bluetooth');
AssetImage get circleQuestionMarkAsset => AssetImage('assets/circle_question_mark.png', package: 'rae_bluetooth');
AssetImage get receivingDataAsset => AssetImage('assets/receiving_data.gif', package: 'rae_bluetooth');

class BluetoothStatusImage extends StatelessWidget {
  final Size size;
  final BluetoothStateEnum state;

  const BluetoothStatusImage({required this.state, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: size.height,
      width: size.width * _widthScale,
      child: _dispatch(),
    );
  }

  Widget _dispatch() {
    switch (state) {
      case BluetoothStateEnum.notPaired:
        return Stack(children: [_bluetooth(), detailIcon(circleQuestionMarkImage())]);
      case BluetoothStateEnum.notReceivingData:
        // TODO: Handle this case.
        break;
      case BluetoothStateEnum.off:
        return Stack(children: [_bluetoothOff(), detailIcon(circleXImage())]);
      case BluetoothStateEnum.on:
        return Stack(children: [_bluetooth(), detailIcon(checkmarkImage())]);
      case BluetoothStateEnum.permissionDenied:
        // TODO: Handle this case.
        break;
      case BluetoothStateEnum.receivingData:
        return Stack(children: [_receivingData(), _bluetooth(Colors.white38)]);
    }
    return Text('X');
  }

  Align _bluetooth([Color? color]) => Align(alignment: Alignment.centerLeft, child: bluetoothImage(color));
  Align _bluetoothOff() => Align(alignment: Alignment.centerLeft, child: bluetoothOffImage());
  Align _receivingData() => Align(alignment: Alignment.centerLeft, child: _receivingDataImage());

  Image bluetoothImage([Color? color]) => Image(image: bluetoothAsset, color: color);
  Image bluetoothOffImage() => Image(image: bluetoothOffAsset);
  Image bluetoothOnImage() => Image(image: checkmarkAsset);
  Image checkmarkImage() => Image(image: checkmarkAsset, color: Colors.green.shade700);
  Image circleXImage() => Image(image: circleXAsset, color: Colors.red.shade600);
  Image circleQuestionMarkImage() => Image(image: circleQuestionMarkAsset, color: Colors.amber);
  Image _receivingDataImage() => Image(image: receivingDataAsset, width: size.height * _widthScale);

  Align detailIcon(Widget image) => Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: SizedBox(
            child: image,
            height: size.height * _scale,
          ),
        ),
      );
}

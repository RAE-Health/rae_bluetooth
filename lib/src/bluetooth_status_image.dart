import 'package:flutter/material.dart';

import 'bluetooth_state_enum.dart';

const double _scale = 0.35;
const double _widthScale = 1.15;

AssetImage get _bluetoothAsset => AssetImage('assets/bluetooth.png', package: 'rae_bluetooth');
AssetImage get _bluetoothOffAsset => AssetImage('assets/bluetooth_off.png', package: 'rae_bluetooth');
AssetImage get _bluetoothStreamingAsset => AssetImage('assets/accelerometer.png', package: 'rae_bluetooth');
AssetImage get _checkmarkAsset => AssetImage('assets/checkmark.png', package: 'rae_bluetooth');
AssetImage get _circleCrossAsset => AssetImage('assets/circle_cross.png', package: 'rae_bluetooth');
AssetImage get _circleCrossNarrowAsset => AssetImage('assets/circle_cross_narrow.png', package: 'rae_bluetooth');
AssetImage get _circleQuestionMarkAsset => AssetImage('assets/circle_question_mark.png', package: 'rae_bluetooth');
AssetImage get _circleXAsset => AssetImage('assets/circle_x.png', package: 'rae_bluetooth');
AssetImage get _noWatchAsset => AssetImage('assets/no_watch.png', package: 'rae_bluetooth');
AssetImage get _protectedAsset => AssetImage('assets/protected.png', package: 'rae_bluetooth');
AssetImage get _receivingDataAsset => AssetImage('assets/receiving_data.gif', package: 'rae_bluetooth');
AssetImage get _shieldAsset => AssetImage('assets/shield.png', package: 'rae_bluetooth');

class BluetoothStatusImage extends StatelessWidget {
  final Size size;
  final BluetoothStateEnum state;

  Align _bluetooth([Color? color]) => Align(alignment: Alignment.centerLeft, child: _bluetoothImage(color));
  Align _bluetoothOff() => Align(alignment: Alignment.centerLeft, child: _bluetoothOffImage());
  Align _receivingData() => Align(alignment: Alignment.centerLeft, child: _receivingDataImage());
  Align _protectedAlign() => Align(alignment: Alignment.centerLeft, child: _protectedImage());

  Image _noWatchImage() => Image(image: _noWatchAsset, color: Colors.green);
  Image _bluetoothImage([Color? color]) => Image(image: _bluetoothAsset, color: color);
  Image _bluetoothOffImage() => Image(image: _bluetoothOffAsset);
  Image _checkmarkImage() => Image(image: _checkmarkAsset, color: Colors.green.shade700);
  Image _circleCrossImage() => Image(image: _circleCrossAsset, color: Colors.red);
  Image _circleCrossNarrowImage() => Image(image: _circleCrossNarrowAsset, color: Colors.red);
  Image _circleQuestionMarkImage() => Image(image: _circleQuestionMarkAsset, color: Colors.amber);
  Image _circleXImage() => Image(image: _circleXAsset, color: Colors.red.shade600);
  Image _receivingDataImage() => Image(image: _receivingDataAsset, width: size.height * _widthScale);
  Image _bluetoothStreamingImage() => Image(image: _bluetoothStreamingAsset);
  Image _protectedImage() => Image(image: _protectedAsset, color: Colors.red.shade700);
  Image _shieldImage() => Image(image: _shieldAsset, color: Colors.red);

  Widget _paddedReceivingDataImage() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: _receivingDataImage(),
      );

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
        return Stack(children: [_bluetooth(), _detailIcon(_circleQuestionMarkImage())]);
      case BluetoothStateEnum.notReceivingData:
        return Stack(children: [
          _bluetooth(),
          _detailIcon(_noWatchImage()),
          _detailIcon(_circleCrossImage()),
        ]);
      case BluetoothStateEnum.off:
        return Stack(children: [_bluetoothOff(), _detailIcon(_circleXImage())]);
      case BluetoothStateEnum.on:
        return Stack(children: [_bluetooth(), _detailIcon(_checkmarkImage())]);
      case BluetoothStateEnum.permissionDenied:
        return Stack(children: [_bluetooth(), _protectedAlign()]);
      case BluetoothStateEnum.receivingData:
        return Stack(children: [_paddedReceivingDataImage(), _bluetooth(Colors.white38)]);
    }
  }

  Align _detailIcon(Widget image) => Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: SizedBox(
            child: image,
            height: size.height * _scale,
          ),
        ),
      );

  // Align _dataTransmissionIcon(Widget image) => Align(
  //       alignment: Alignment.topRight,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 3, top: 3, bottom: 3, right: 3),
  //         child: SizedBox(
  //           child: image,
  //           height: size.height * _scale,
  //         ),
  //       ),
  //     );
}

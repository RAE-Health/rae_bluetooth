import 'package:flutter/material.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rae_bluetooth/rae_bluetooth.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:xample/cubit/locale_cubit.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> {
  String message = 'Tap for Size';
  String instruction = 'Tap + to change the text';
  String instruction2 = 'Tap again';
  bool isFirst = true;
  
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            ThemeControlWidget(),
          ],
        ),
        body: _body(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //_getBLEState();

            setState(() {
              isFirst = !isFirst;
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );

  Widget _body(BuildContext context) {
    LocaleCubit localeCubit = Modular.get<LocaleCubit>();
    final cubit = Modular.get<BluetoothCubit>();

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              message,
            ),
            WidgetSize(
              onChange: (Size size) {
                setState(() {
                  final height = context.height;
                  final width = context.width;
                  debugPrint('height: $height, width: $width $isFirst');
                  message = 'Size - $size';
                });
              },
              child: Text(
                isFirst ? instruction : instruction2,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(height: 24),
            Wrap(children: [
              ElevatedButton(onPressed: () => localeCubit.updateLocale(Locale('en', '')), child: Text('English')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: () => localeCubit.updateLocale(Locale('es', '')), child: Text('Spanish')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: () => localeCubit.updateLocale(Locale('de', '')), child: Text('German')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: () => cubit.getBluetoothStatus(), child: Text('Request BLE')),
              SizedBox(width: 8),
            ]),
            Column(
              children: _stateButtions(),
            ),
            SizedBox(height: 8),
            Wrap(children: _sizeButton()),
          ],
        ),
      ),
    );
  }

  List<Widget> _stateButtions() {
    List<Widget> result = [];
    for (BluetoothStateEnum bse in BluetoothStateEnum.values) {
      result.add(BluetoothBannerWidget(iosBluetoothState: bse, size: Size.square(32.0)));
      result.add(BluetoothBannerWidget(iosBluetoothState: bse, size: Size.square(48.0)));
      result.add(BluetoothBannerWidget(iosBluetoothState: bse, size: Size.square(64.0)));
    }
    return result;
  }

  List<Widget> _sizeButton() {
    List<Widget> result = [];
    for (BluetoothStateEnum bse in BluetoothStateEnum.values) {
      result.add(SizedBox(height: 2));
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImageWidget(size: Size.square(48.0), state: bse),
        ),
      );
      result.add(SizedBox(height: 2));
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImageWidget(size: Size.square(56.0), state: bse),
        ),
      );
      result.add(SizedBox(height: 2));
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImageWidget(size: Size.square(80.0), state: bse),
        ),
      );
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImageWidget(size: Size.square(128.0), state: bse),
        ),
      );
    }
    return result;
  }
}

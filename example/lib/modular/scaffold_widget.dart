import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extras/flutter_extras.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rae_bluetooth/rae_bluetooth.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:xample/cubit/locale_cubit.dart';
import 'package:xample/l10n/mixin.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ScaffoldWidget createState() => _ScaffoldWidget();
}

class _ScaffoldWidget extends ObservingStatefulWidget<ScaffoldWidget> with DictionaryEnumMixin {
  String message = 'Tap for Size';
  String instruction = 'Tap + to change the text';
  String instruction2 = 'Tap again';
  bool isFirst = true;
  static const bleStateEventChannel = EventChannel('com.ltmm.ble/blestatus');
  StreamSubscription? bleStateSubscription;

  void _getBLEState() {
    bleStateSubscription = bleStateEventChannel.receiveBroadcastStream().listen((event) {
      debugPrint('EVENT: ${event.toString()}');
    });
  }

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
            _getBLEState();

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
            Text(lookup(DictionaryEnum.helloWorld, of: context)), //Example of localization
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
            Wrap(
              children: _stateButtions(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _stateButtions() {
    List<Widget> result = [];
    for (BluetoothStateEnum bse in BluetoothStateEnum.values) {
      result.add(SizedBox(width: 2));
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImage(size: Size.square(48.0), state: bse),
        ),
      );
      result.add(SizedBox(width: 2));
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImage(size: Size.square(56.0), state: bse),
        ),
      );
      result.add(SizedBox(width: 2));
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImage(size: Size.square(80.0), state: bse),
        ),
      );
      result.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: BluetoothStatusImage(size: Size.square(128.0), state: bse),
        ),
      );
    }
    return result;
  }
}

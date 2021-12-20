import 'package:flutter/material.dart';
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
          onPressed: () {
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
    return Center(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => localeCubit.updateLocale(Locale('en', '')), child: Text('English')),
              ElevatedButton(onPressed: () => localeCubit.updateLocale(Locale('es', '')), child: Text('Spanish')),
              ElevatedButton(onPressed: () => localeCubit.updateLocale(Locale('de', '')), child: Text('German')),
            ],
          )
        ],
      ),
    );
  }
}

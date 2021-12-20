//*********************************************************************************
// If errors like 'Traget URI doesn't...' or 'Undefined name 'AppLocalizations'
// try 'flutter pub get' again (or 2 - 3 times), or just run the app and they
// should disappear
//*********************************************************************************

import 'package:empty_package/empty_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin DictionaryEnumMixin {
  String lookup(DictionaryEnum item, {required BuildContext of}) {
    switch (item) {
      case DictionaryEnum.helloWorld:
        return AppLocalizations.of(of)!.helloWorld;
    }
  }
}

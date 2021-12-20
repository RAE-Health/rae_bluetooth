//*********************************************************************************
// If errors like 'Traget URI doesn't...' or 'Undefined name 'AppLocalizations'
// try 'flutter pub get' once more (or twice), or just run the app and they
// should disappear
//*********************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/package_localizations.dart';

import '../empty_package.dart';

mixin DictionaryEnumMixin {
  String lookup(DictionaryEnum item, {required BuildContext of}) {
    switch (item) {
      case DictionaryEnum.helloWorld:
        return AppLocalizations.of(of)!.helloWorld;
    }
  }
}

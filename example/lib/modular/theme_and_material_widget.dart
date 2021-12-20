import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:xample/cubit/locale_cubit.dart';

class ThemeAndMaterialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _localeWidget();
  }

/// Widget wrapper to enclose the BlocBuilder that manages state for changing lanaguage/locale
  Widget _localeWidget() {
    LocaleCubit localeCubit = Modular.get<LocaleCubit>();
    Locale? currentLocale;
    return BlocBuilder<LocaleCubit, LocaleState>(
        bloc: localeCubit,
        builder: (_, state) {
          debugPrint(state.toString());
          if (state is LocaleInitial) {
            localeCubit.lookupInitialLocale();
          }
          if (state is LocaleUpdated) {
            currentLocale = state.updatedLocale;
          }
          return _materialAppBloc(currentLocale);
        });
  }

/// Widget wrapper to enclose switching dark/light mode themes of the MaterialApp
  Widget _materialAppBloc(Locale? locale) {
    return BlocBuilder<ThemeCubit, ThemeCubitState>(
        bloc: ThemeManager.themeCubit,
        builder: (_, state) {
          if (state is UpdateThemeMode) {}
          return MaterialApp(
            title: 'Flutter Demo',
            locale: locale,
            theme: ThemeManager.lightTheme,
            darkTheme: ThemeManager.darkTheme,
            themeMode: ThemeManager.themeMode,
            initialRoute: '/',
            localizationsDelegates: [
              AppLocalizations.delegate, //Used to translate strings in /l10n/app_en.arb or /l10n/app_es.arb files
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('de', ''), // German, no country code
              const Locale('en', ''), // English, no country code
              const Locale('es', ''), // Spanish, no country code
            ],
          ).modular();
        });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial());

  void lookupInitialLocale() async {
    Future.delayed(Duration(microseconds: 0), () {
      emit(LocaleUpdated(Locale('es', '')));
    });
  }

  void updateLocale(Locale locale) {
    emit(LocaleUpdated(locale));
  }
}

part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {}

class LocaleInitial extends LocaleState {}

class LocaleUpdated extends LocaleState {
  final Locale updatedLocale;
  LocaleUpdated(this.updatedLocale);
}

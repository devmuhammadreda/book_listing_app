part of 'localizations_cubit.dart';

abstract class LocalizationsState {
  const LocalizationsState();
}

class LocalizationsInitial extends LocalizationsState {}

class ChangeAppLocalizationsState extends LocalizationsState {
  final Locale locale;
  const ChangeAppLocalizationsState(this.locale);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeAppLocalizationsState && locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}

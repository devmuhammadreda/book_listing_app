import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/get_storage_helper.dart';

part 'localizations_state.dart';

class LocalizationsCubit extends Cubit<LocalizationsState> {
  LocalizationsCubit() : super(LocalizationsInitial()) {
    _initLocale();
  }

  late Locale _locale;
  Locale get locale => _locale;

  Future<void> _initLocale() async {
    final cachedLangCode = CacheHelper.getLocale;
    _locale = Locale(cachedLangCode);
    emit(ChangeAppLocalizationsState(_locale));
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    await CacheHelper.cacheLocale(langCode: newLocale.languageCode);
    emit(ChangeAppLocalizationsState(newLocale));
  }
}

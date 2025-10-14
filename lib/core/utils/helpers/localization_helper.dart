import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(_getInitialLocale());

  static Locale _getInitialLocale() {
    // Check if user has saved language in cache
    final savedLangCode = CacheHelper.getString(appLang);
    if (savedLangCode != null && savedLangCode.isNotEmpty) {
      return Locale(savedLangCode);
    }

    // Otherwise, use system default
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (['en', 'ar'].contains(deviceLocale.languageCode)) {
      return deviceLocale;
    }

    // Fallback to English if system language not supported
    return const Locale('en');
  }

  void changeLocale(Locale locale) {
    emit(locale);
   
    CacheHelper.saveString(appLang, locale.languageCode);
  }

  void toggleLocale() {
    if (state.languageCode == 'en') {
      changeLocale(const Locale('ar'));
    } else {
      changeLocale(const Locale('en'));
    }
  }
}



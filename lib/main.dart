import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/app.dart';
import 'package:mahu_home_services_app/bloc_observer.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runZonedGuarded(() {
    if (kDebugMode) {
      Bloc.observer = const SimpleBlocObserver();
    }
    runApp(const MyApp()); // فقط شغل MyApp، ما تحدد startScreen هنا
  }, (error, stackTrace) {
    debugPrint('Unhandled error: $error');
  });
}

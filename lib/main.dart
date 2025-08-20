import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/app.dart';
import 'package:mahu_home_services_app/bloc_observer.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  // Use runZonedGuarded to catch all errors in release mode
  runZonedGuarded(() {
    if (kDebugMode) {
      Bloc.observer = const SimpleBlocObserver();
    }
    runApp(MyAppWrapper());
  }, (error, stackTrace) {
    // You can log to Firebase Crashlytics or Sentry here in release mode
    debugPrint('Unhandled error: $error');
  });
}

class MyAppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserRoleCubit().loadSavedRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ),
          );
        }
        return const MyApp();
      },
    );
  }
}

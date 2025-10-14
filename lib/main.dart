import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/app.dart';
import 'package:mahu_home_services_app/bloc_observer.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mahu_home_services_app/core/utils/helpers/notifications_helper.dart';
import 'package:mahu_home_services_app/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This runs when the app is in background/terminated
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await CacheHelper.init();
    if (kDebugMode) {
      Bloc.observer = const SimpleBlocObserver();
    }
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Initialize notifications
    await NotificationsHelper().initNotifications();

    print(
        '=====================================================================');
    print('token: ${await FirebaseMessaging.instance.getToken()}');
    print(
        '=====================================================================');
    runApp(const MyApp()); // فقط شغل MyApp، ما تحدد startScreen هنا
  }, (error, stackTrace) {
    debugPrint('Unhandled error: $error');
  });
}

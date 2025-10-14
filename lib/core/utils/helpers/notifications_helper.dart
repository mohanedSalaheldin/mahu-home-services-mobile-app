import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mahu_home_services_app/app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationsHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get token
    String? token = await _firebaseMessaging.getToken();
    // print("Token: $token");

    // Handle background/terminated state
    handleBackgroundNotification();
  }

  // Handle notification taps
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => FutureBuilder<Widget>(
          future: getInitialScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(child: Text('حدث خطأ!')),
              );
            } else {
              return snapshot.data!;
            }
          },
        ),
      ),
      (route) => false, // removes all previous routes
    );
  }

  Future<void> handleBackgroundNotification() async {
    // When app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // When app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

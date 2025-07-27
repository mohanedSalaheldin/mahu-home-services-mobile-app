import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/upload_media_helper.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/landing_screen1.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/views/screens/all_services_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/customer_home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(create: (_) => UserRoleCubit()..loadUserRole()),
          BlocProvider<ServiceCubit>(
            create: (_) => ServiceCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'MAHU Booking Platform',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(color: Colors.white),
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
            useMaterial3: true,
          ),
          // home: const UploadTestScreen(),
          home: FutureBuilder<Widget>(
            future: getInitialScreen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // أثناء التحميل
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                // في حال حدوث خطأ
                return const Scaffold(
                  body: Center(child: Text('حدث خطأ!')),
                );
              } else {
                // عند اكتمال المستقبل
                return snapshot.data!;
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<Widget> getInitialScreen() async {
  final bool? isFirstTime = CacheHelper.getBool('first_time');
  final String? userRole =
      CacheHelper.getString('user_role'); // client أو provider
  final String? token = CacheHelper.getString('token');

  // الحالة 1: أول مرة يفتح التطبيق
  if (isFirstTime == null || isFirstTime == true) {
    return const LandingScreen1();
  }

  // الحالة 2: ما اختار دور لسه
  if (userRole == null || userRole.isEmpty) {
    return const ChooseRuleScreen();
  }

  // الحالة 3: اختار دور لكن ما عمل تسجيل دخول
  if (token == null || token.isEmpty) {
    return const LoginScreen();
  }

  // الحالة 4: اختار دور وسجّل دخول
  if (userRole == 'client') {
    return const CustomerHomeScreen();
  } else if (userRole == 'provider') {
    return const ServiceProviderDashboardScreen();
  }

  // fallback
  return const ChooseRuleScreen();
}

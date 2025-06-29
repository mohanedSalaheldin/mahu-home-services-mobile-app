import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/views/screens/home_test.dart';
import 'package:mahu_home_services_app/features/auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/landing_screen1.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/views/screens/select_service_type_screen.dart';

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
          BlocProvider<ServiceCubit>(
            create: (_) => ServiceCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'MAHU Service Booking Platform',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
            useMaterial3: true,
          ),
          home: const SelectServiceTypeScreen(),
          // home: FutureBuilder<Widget>(
          //   future: getInitialScreen(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       // أثناء التحميل
          //       return const Scaffold(
          //         body: Center(child: CircularProgressIndicator()),
          //       );
          //     } else if (snapshot.hasError) {
          //       // في حال حدوث خطأ
          //       return const Scaffold(
          //         body: Center(child: Text('حدث خطأ!')),
          //       );
          //     } else {
          //       // عند اكتمال المستقبل
          //       return snapshot.data!;
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}

Future<Widget> getInitialScreen() async {
  final bool? isFirstTime = CacheHelper.getBool('first_time');
  print('-------------------------------------------------');
  print('first_time is $isFirstTime');
  print('-------------------------------------------------');
  final String? token = CacheHelper.getString('token');
  print('-------------------------------------------------');
  print('token is $token');
  print('-------------------------------------------------');

  if (isFirstTime == null || isFirstTime == true) {
    // أول مرة يفتح التطبيق
    return const LandingScreen1();
  } else if (token != null && token.isNotEmpty) {
    // المستخدم مسجل دخول
    return const HomeTestScreen();
  } else {
    // المستخدم شاف شاشة المقدمة لكنه غير مسجل دخول
    return const LoginScreen();
  }
}

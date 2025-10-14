import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/landing_screen1.dart';
import 'package:mahu_home_services_app/features/layouts/client_layout_screen.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

import 'core/utils/helpers/localization_helper.dart';

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
          BlocProvider<UserRoleCubit>(
            create: (_) {
              final cubit = UserRoleCubit();
              cubit.loadSavedRole(); // load saved role if exists
              return cubit;
            },
          ),
          BlocProvider<ServiceCubit>(
            create: (_) => ServiceCubit(),
          ),
          BlocProvider<UserBookingCubit>(
            create: (context) => UserBookingCubit(),
          ),
          BlocProvider<LocaleCubit>(
            create: (context) => LocaleCubit(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              locale: locale,
              // locale: const Locale('ar'),
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              title: 'MAHU Booking Platform',
              debugShowCheckedModeBanner: false,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              ),
              theme: ThemeData(
                fontFamily: 'Poppins',
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(color: Colors.white),
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
                useMaterial3: true,
              ),
              home: FutureBuilder<Widget>(
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
            );
          },
        ),
      ),
    );
  }
}

Future<Widget> getInitialScreen() async {
  final bool? isFirstTime = CacheHelper.getBool('first_time');
  final String? userRole =
      CacheHelper.getString('user_role'); // user أو provider
  final String? token = CacheHelper.getString('token');

  // الحالة 1: أول مرة يفتح التطبيق
  if (isFirstTime == null || isFirstTime == true) {
    return const LandingScreen1();
  }

  // الحالة 2: ما اختار دور لسه
  if (userRole == null || userRole.isEmpty) {
    return const RoleSelectionScreen();
  }

  // الحالة 3: اختار دور لكن ما عمل تسجيل دخول
  if (token == null || token.isEmpty) {
    return const LoginScreen();
  }

  // print("The role of user: "+userRole);
  // الحالة 4: اختار دور وسجّل دخول
  if (userRole == 'user') {
    return ClientLayoutScreen();
  } else if (userRole == 'provider') {
    return ProviderLayoutScreen();
  }

  // fallback
  return const RoleSelectionScreen();
}

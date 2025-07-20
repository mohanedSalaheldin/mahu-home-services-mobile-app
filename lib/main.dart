import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/app.dart';
import 'package:mahu_home_services_app/bloc_observer.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = const SimpleBlocObserver();
  final userRoleCubit = UserRoleCubit();
  await userRoleCubit.loadUserRole();

  runApp(const MyApp());
}

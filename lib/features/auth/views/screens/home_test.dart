import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/auth/cubit/auth_cubit.dart';
import 'package:mahu_home_services_app/features/auth/cubit/auth_state.dart';
import 'package:mahu_home_services_app/features/auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';

import '../../../../core/utils/helpers/helping_functions.dart';

class HomeTestScreen extends StatelessWidget {
  const HomeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen (Test)'),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Home Screen (Test)',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                AppFilledButton(
                  text: 'Logout',
                  onPressed: () async {
                    await CacheHelper.remove('token');

                    if (context.mounted) {
                      navigateTo(context, const LoginScreen());
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

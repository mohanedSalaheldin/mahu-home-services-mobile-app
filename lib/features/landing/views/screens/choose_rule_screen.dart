import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/next_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/user_rule_item.dart';
import 'package:mahu_home_services_app/features/auth/provider_auth/views/screens/provider_register_screen.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/customer_home_screen.dart';

class ChooseRuleScreen extends StatefulWidget {
  const ChooseRuleScreen({super.key});

  @override
  State<ChooseRuleScreen> createState() => _ChooseRuleScreenState();
}

var isClient = true;

class _ChooseRuleScreenState extends State<ChooseRuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConst.appPadding.w),
          child: BlocBuilder<UserRoleCubit, UserRole?>(
            builder: (context, role) {
              return Column(
                children: [
                  const Spacer(),
                  UserRuleItem(
                    txt: 'Customer',
                    icon: 'assets/icons/user_rule.png',
                    hasBorder: role == UserRole.client,
                    onTap: () {
                      context
                          .read<UserRoleCubit>()
                          .setUserRole(UserRole.client);
                    },
                  ),
                  Gap(66.h),
                  UserRuleItem(
                    txt: 'Service Provider',
                    icon: 'assets/icons/provider_rule.png',
                    hasBorder: role == UserRole.serviceProvider,
                    onTap: () {
                      context
                          .read<UserRoleCubit>()
                          .setUserRole(UserRole.serviceProvider);
                    },
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NextButton(
                        onTap: () {
                          if (role == UserRole.client) {
                            navigateTo(context, const CustomerHomeScreen());
                          } else if (role == UserRole.serviceProvider) {
                            navigateTo(context, ProviderLayoutScreen());
                          }
                        },
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

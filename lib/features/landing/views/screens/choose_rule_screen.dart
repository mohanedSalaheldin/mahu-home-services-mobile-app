import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/auth/provider_auth/views/screens/provider_register_screen.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/customer_home_screen.dart';

class ChooseRuleScreen extends StatefulWidget {
  const ChooseRuleScreen({super.key});

  @override
  State<ChooseRuleScreen> createState() => _ChooseRuleScreenState();
}

class _ChooseRuleScreenState extends State<ChooseRuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(40.h),
              // Header with animation
              Text(
                'Join as a...',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              )
                  .animate()
                  .fadeIn(delay: 100.ms)
                  .slide(begin: const Offset(0, -0.1)),
              Text(
                'Select your role to continue',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ).animate().fadeIn(delay: 200.ms),
              Gap(40.h),

              // Role Selection Cards
              BlocBuilder<UserRoleCubit, UserRole?>(
                builder: (context, role) {
                  return Column(
                    children: [
                      // Customer Card
                      _buildRoleCard(
                        context: context,
                        title: 'Customer',
                        description: 'Book and manage cleaning services',
                        icon: Icons.person_outline,
                        isSelected: role == UserRole.client,
                        onTap: () => context
                            .read<UserRoleCubit>()
                            .setUserRole(UserRole.client),
                        color: Colors.blue,
                        delay: 300.ms,
                      ),
                      Gap(24.h),

                      // Service Provider Card
                      _buildRoleCard(
                        context: context,
                        title: 'Service Provider',
                        description: 'Offer and manage your cleaning services',
                        icon: Icons.work_outline,
                        isSelected: role == UserRole.provider,
                        onTap: () => context
                            .read<UserRoleCubit>()
                            .setUserRole(UserRole.provider),
                        color: Colors.orange,
                        delay: 400.ms,
                      ),
                    ],
                  );
                },
              ),

              const Spacer(),

              // Continue Button
              BlocBuilder<UserRoleCubit, UserRole?>(
                builder: (context, role) {
                  return AnimatedOpacity(
                    opacity: role != null ? 1.0 : 0.5,
                    duration: 300.ms,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: role != null
                            ? () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          role == UserRole.client
                                              ? const ClientRegisterScreen()
                                              : const ProviderRegisterScreen(),
                                    ));
                              }
                            : null,
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 500.ms),
                  );
                },
              ),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
    required Duration delay,
  }) {
    return Animate(
      effects: [
        FadeEffect(duration: 300.ms, delay: delay),
        ScaleEffect(duration: 300.ms, delay: delay),
      ],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24.w,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: color,
                  size: 24.w,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

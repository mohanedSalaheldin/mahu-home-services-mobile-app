import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/models/user_type_enum.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/client_register_screen.dart';
import 'package:mahu_home_services_app/features/auth/provider_auth/views/screens/provider_register_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart'; // << لازم تتأكد انه موجود

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  void initState() {
    super.initState();
    // Clear any previous selection when screen loads
    context.read<UserRoleCubit>().clearSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Header Section
              _buildHeader(context),
              const Spacer(),

              // Role Selection Cards
              BlocBuilder<UserRoleCubit, UserRole>(
                builder: (context, selectedRole) {
                  return Column(
                    children: [
                      _buildRoleCard(
                        context: context,
                        role: UserRole.client,
                        isSelected: selectedRole == UserRole.client,
                        icon: Icons.person_rounded,
                        title: S.of(context).roleCustomerTitle,
                        description: S.of(context).roleCustomerDesc,
                        color: Colors.blue,
                      ),
                      Gap(24.h),
                      _buildRoleCard(
                        context: context,
                        role: UserRole.provider,
                        isSelected: selectedRole == UserRole.provider,
                        icon: Icons.handyman_rounded,
                        title: S.of(context).roleProviderTitle,
                        description: S.of(context).roleProviderDesc,
                        color: Colors.orange,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(flex: 2),

              // Continue Button (only shows when role is selected)
              BlocBuilder<UserRoleCubit, UserRole>(
                builder: (context, role) {
                  if (role == UserRole.unknown) return const SizedBox.shrink();

                  return FilledButton(
                    onPressed: () =>
                        _navigateToRegistrationScreen(context, role),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: Size(double.infinity, 56.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      S.of(context).continueBtn,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).roleJoinTitle,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        Gap(8.h),
        Text(
          S.of(context).roleJoinSubtitle,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required UserRole role,
    required bool isSelected,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return InkWell(
      onTap: () => context.read<UserRoleCubit>().setUserRole(role),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: color,
                size: 24.w,
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToRegistrationScreen(BuildContext context, UserRole role) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => role == UserRole.client
            ? const ClientRegisterScreen()
            : const ProviderRegisterScreen(),
      ),
    );
  }
}

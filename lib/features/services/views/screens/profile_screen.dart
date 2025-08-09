import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/app.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/models/provider_performance.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';

class ProfileScreen extends StatelessWidget {
  final bool hasProfilePicture;
  final String? profileImageUrl;
  final String companyName;
  final String companyDescription;
  final double rating;
  final int reviewCount;
  final double totalEarnings;
  final int completedJobs;
  final String responseTime;
  final String subscriptionPlan;
  final String subscriptionEndDate;

  const ProfileScreen({
    super.key,
    this.hasProfilePicture = false,
    this.profileImageUrl,
    required this.companyName,
    required this.companyDescription,
    required this.rating,
    required this.reviewCount,
    required this.totalEarnings,
    required this.completedJobs,
    required this.responseTime,
    required this.subscriptionPlan,
    required this.subscriptionEndDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeaderSection(context),
              Gap(24.h),

              // Stats Section
              _buildStatsSection(context),
              Gap(24.h),

              // Response Time Section
              _buildResponseTimeSection(),
              Gap(24.h),

              // Subscription Section
              _buildSubscriptionSection(),
              Gap(24.h),

              // Settings Section
              _buildSettingsSection(context),
              Gap(32.h),

              // Upgrade Button
              _buildUpgradeButton(),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    var cubit = context.read<ServiceCubit>();
    UserBaseProfileModel user = cubit.profile;
    ProviderPerformanceModel performance = cubit.performanceModel;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Avatar
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            image: user.avatar != ''
                ? DecorationImage(
                    image: NetworkImage(user.avatar),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: !hasProfilePicture
              ? Icon(
                  Icons.person,
                  size: 40.w,
                  color: Colors.grey.shade600,
                )
              : null,
        ),
        Gap(16.w),

        // Company Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(4.h),
              Text(
                companyDescription,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              Gap(8.h),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18.sp,
                  ),
                  Gap(4.w),
                  Text(
                    '${performance.averageRating} reviews',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    var cubit = context.read<ServiceCubit>();
    UserBaseProfileModel user = cubit.profile;
    ProviderPerformanceModel performance = cubit.performanceModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stats',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Completed', performance.totalBookings.toString()),
            _buildStatItem('Total Earnings', '\$${performance.cancelled}'),
            _buildStatItem('Jobs', performance.completed.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
        Gap(8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildResponseTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Avg. Response Time',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8.h),
        Text(
          responseTime,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscription',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8.h),
        Text(
          subscriptionPlan,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        Gap(4.h),
        Text(
          'Renews on $subscriptionEndDate',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        _buildSettingOption(Icons.edit, 'Edit Profile', () {
          // Navigate to edit profile
        }),
        _buildSettingOption(Icons.payment, 'Payment Methods', () {
          // Navigate to payment methods
        }),
        _buildSettingOption(Icons.help_outline, 'Support', () {
          // Navigate to support
        }),
        _buildSettingOption(Icons.logout, 'Log Out', () {
          _showLogoutConfirmation(context);
        }),
      ],
    );
  }

  Widget _buildSettingOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: Colors.grey.shade600,
            ),
            Gap(16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              size: 24.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // Handle upgrade plan
        },
        child: Text(
          'Upgrade Plan',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle logout logic
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseRuleScreen(),
                  ));
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

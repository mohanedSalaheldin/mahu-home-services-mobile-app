import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/provider_performance.dart';
import 'package:mahu_home_services_app/features/services/models/subscription_model.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/services/services/subscription_services.dart';
import 'package:mahu_home_services_app/features/services/views/screens/editprofile_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/upgrade_plan_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SubscriptionServices _subscriptionServices = SubscriptionServices();
  Subscription? _currentSubscription;
  bool _isLoadingSubscription = true;

  @override
  void initState() {
    super.initState();
    _loadUserSubscription();
  }

  Future<void> _loadUserSubscription() async {
    final cubit = context.read<ServiceCubit>();
    // ignore: unnecessary_null_comparison
    if (cubit.profile == null) return;
    final userId = cubit.profile.id;

    final result = await _subscriptionServices.getUserSubscription(userId);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (subscription) {
        setState(() {
          _currentSubscription = subscription;
          _isLoadingSubscription = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServiceCubit, ServiceState>(
        builder: (context, state) {
          final cubit = context.read<ServiceCubit>();

          if (state is UserProfileLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blue));
          }

          if (state is ServiceErrorState) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (cubit.profile == null) {
            return const Center(child: Text("No profile loaded"));
          }

          final user = cubit.profile;
          final performance = cubit.performanceModel;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(user, performance),
                  Gap(24.h),
                  _buildStatsSection(performance),
                  Gap(24.h),
                  _buildResponseTimeSection(),
                  Gap(24.h),
                  _buildSubscriptionSection(),
                  Gap(24.h),
                  _buildSettingsSection(user),
                  Gap(32.h),
                  _buildUpgradeButton(user.id),
                  Gap(40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(
      UserBaseProfileModel user, ProviderPerformanceModel performance) {
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
            image: DecorationImage(
              image: (user.avatar != null && user.avatar.isNotEmpty)
                  ? NetworkImage(user.avatar)
                  : const AssetImage('assets/imgs/no_avatar.png')
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(4.h),
              Text(
                user.businessName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              Gap(4.w),
              Text(
                'The Reference Id : ${CacheHelper.getString("referenceId")}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(8.h),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  Gap(4.w),
                  Text(
                    '${performance.averageRating.toStringAsFixed(1)} (${performance.totalBookings} reviews)',
                    style: TextStyle(
                      fontSize: 14,
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

  Widget _buildStatsSection(ProviderPerformanceModel performance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stats',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem('Completed', performance.completed.toString()),
            _buildStatItem('Total Earnings',
                '\$${performance.totalEarnings.toStringAsFixed(2)}'),
            _buildStatItem('All Jobs', performance.totalBookings.toString()),
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
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Gap(8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8.h),
        Text(
          'Within 1 hour', // You can make this dynamic
          style: TextStyle(
            fontSize: 16,
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
          'Subscription Plan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(12.h),
        _isLoadingSubscription
            ? const CircularProgressIndicator(color: Colors.blue)
            : _currentSubscription == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          'You are not subscribed to any plan yet.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Gap(12.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            final userId =
                                context.read<ServiceCubit>().profile!.id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    UpgradePlanScreen(userId: userId),
                              ),
                            ).then((_) => _loadUserSubscription());
                          },
                          child: Text(
                            'Subscribe Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.all(16.0.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Icon(
                                Icons.workspace_premium,
                                color: AppColors.primary,
                              ),
                            ),
                            Gap(12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _currentSubscription!.plan.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${_currentSubscription!.plan.price.toStringAsFixed(2)}/${_currentSubscription!.plan.duration} month(s)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  DateFormat('MMM d, yyyy')
                                      .format(_currentSubscription!.startDate),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End Date',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  DateFormat('MMM d, yyyy')
                                      .format(_currentSubscription!.endDate),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(12.h),
                        Text(
                          'Status: ${_currentSubscription!.status}',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                _getStatusColor(_currentSubscription!.status),
                          ),
                        ),
                      ],
                    ),
                  ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSettingsSection(UserBaseProfileModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        _buildSettingOption(Icons.edit, 'Edit Profile', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditProfileScreen(user: user)),
          );
        }),
        _buildSettingOption(Icons.logout, 'Log Out', () {
          _showLogoutConfirmation();
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
              size: 24,
              color: Colors.grey.shade600,
            ),
            Gap(16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              size: 24,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeButton(String userId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UpgradePlanScreen(userId: userId),
            ),
          ).then((_) {
            // Refresh subscription data when returning from upgrade screen
            _loadUserSubscription();
          });
        },
        child: Text(
          _currentSubscription == null ? 'Subscribe Now' : 'Upgrade Plan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmation() async {
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
            onPressed: () async {
              // Remove token from SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('auth_token');

              // Reset ServiceCubit state
              context.read<ServiceCubit>().close();

              // Navigate to ChooseRuleScreen and clear navigation stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                (Route<dynamic> route) => false, // Remove all previous routes
              );
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

class UserProfileLoading {
}

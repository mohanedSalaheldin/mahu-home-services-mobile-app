import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/helpers/localization_helper.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
// import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/provider_performance.dart';
import 'package:mahu_home_services_app/features/services/models/subscription_model.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/services/services/subscription_services.dart';
import 'package:mahu_home_services_app/features/services/views/screens/editprofile_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/upgrade_plan_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SubscriptionServices _subscriptionServices = SubscriptionServices();
  Subscription? _currentSubscription;
  // Reserved for future loading indicator

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
        // if no active subscription or failed, clear loading so UI updates
        setState(() {
          _currentSubscription = null;
        });
      },
      (subscription) {
        setState(() {
          _currentSubscription = subscription;
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
                S.of(context).profileScreenError(state.message),
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
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
                  // Gap(24.h),
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

  void _showChangeLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).changeLanguageTitle),
        content: Text(S.of(context).changeLanguageConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).profileScreenCancelButton),
          ),
          TextButton(
            onPressed: () async {
              context.read<LocaleCubit>().toggleLocale();
            },
            child: Text(
              S.of(context).confirmButton,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(
      UserBaseProfileModel user, ProviderPerformanceModel performance) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            image: DecorationImage(
              image: (user.avatar.isNotEmpty)
                  ? NetworkImage(user.avatar)
                  : const AssetImage('assets/imgs/no_avatar.png')
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
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
                S.of(context).profileScreenReferenceId(
                    CacheHelper.getString("referenceId")!),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(8.h),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  Gap(4.w),
                  Text(
                    '${performance.averageRating.toStringAsFixed(1)} (${performance.totalBookings} ${S.of(context).profileScreenReviews})',
                    style: const TextStyle(
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
          S.of(context).profileScreenStatsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatItem(S.of(context).profileScreenStatsCompleted,
                performance.completed.toString()),
            _buildStatItem(S.of(context).profileScreenStatsTotalEarnings,
                '\$${performance.totalEarnings.toStringAsFixed(2)}'),
            _buildStatItem(S.of(context).profileScreenStatsAllJobs,
                performance.totalBookings.toString()),
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
          style: const TextStyle(
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
          S.of(context).profileScreenResponseTimeTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8.h),
        Text(
          S.of(context).profileScreenResponseTimeValue,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

//
  Widget _buildSubscriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).profileScreenSubscriptionPlanTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(12.h),
        // _isLoadingSubscription
        //     ? const CircularProgressIndicator(color: Colors.blue)
        //     :
        _currentSubscription == null
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
                      S.of(context).profileScreenNoSubscription,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Gap(12.h),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.primary,
                  //       padding: EdgeInsets.symmetric(vertical: 16.h),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       final userId = context.read<ServiceCubit>().profile.id;
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (_) => UpgradePlanScreen(userId: userId),
                  //         ),
                  //       ).then((_) => _loadUserSubscription());
                  //     },
                  //     child: Text(
                  //       S.of(context).profileScreenSubscribeButton,
                  //       style: const TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                
                ],
              )
            : Container(
                padding: EdgeInsets.all(16.0.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // plan icon / logo placeholder
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.workspace_premium,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentSubscription!.plan.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _currentSubscription!.plan.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  // Plan active badge
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: _currentSubscription!.plan.isActive
                                          ? Colors.green.withOpacity(0.12)
                                          : Colors.grey.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _currentSubscription!.plan.isActive
                                          ? 'Plan Active'
                                          : 'Plan Inactive',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _currentSubscription!
                                                .plan.isActive
                                            ? Colors.green
                                            : Colors.grey.shade700,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(8.w),
                        // Right side constrained column for provider badge + price
                        SizedBox(
                          width: 120.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: (context.read<ServiceCubit>().profile
                                                  .isVerified ==
                                              true)
                                      ? Colors.blue.withOpacity(0.12)
                                      : Colors.grey.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  (context.read<ServiceCubit>().profile.isVerified ==
                                          true)
                                      ? 'Verified Provider'
                                      : 'Unverified Provider',
                                  style: TextStyle(
                                    color: (context.read<ServiceCubit>().profile
                                                    .isVerified ==
                                                true)
                                        ? Colors.blue
                                        : Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '\$${_currentSubscription!.plan.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                '${_currentSubscription!.plan.duration} mo',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Gap(14.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).profileScreenSubscriptionStartDate,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              DateFormat('MMM d, yyyy')
                                  .format(_currentSubscription!.startDate),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              S.of(context).profileScreenSubscriptionEndDate,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              DateFormat('MMM d, yyyy')
                                  .format(_currentSubscription!.endDate),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Gap(12.h),

                    // Remaining days + status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(builder: (context) {
                          final today = DateTime.now();
                          final remaining = _currentSubscription!.endDate
                              .difference(today)
                              .inDays;
                          return Row(
                            children: [
                                Wrap(
                                  spacing: 12.w,
                                  runSpacing: 8.h,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        remaining >= 0
                                            ? '$remaining days left'
                                            : 'Expired',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.build_circle,
                                            size: 18, color: Colors.grey),
                                        SizedBox(width: 6.w),
                                        Text(
                                          '${_currentSubscription!.plan.maxServices} services',
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.book_online,
                                            size: 18, color: Colors.grey),
                                        SizedBox(width: 6.w),
                                        Text(
                                          '${_currentSubscription!.plan.maxBookings} bookings',
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                          );
                        }),

                        // status badge
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: _getStatusColor(_currentSubscription!.status)
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _currentSubscription!.status,
                            style: TextStyle(
                              color: _getStatusColor(_currentSubscription!.status),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Gap(14.h),
                    const Divider(),
                    Gap(12.h),

                    // Features
                    Text(
                      'Included Features',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Gap(10.h),
                    Column(
                      children:
                          _currentSubscription!.plan.features.map((f) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  f,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
          S.of(context).profileScreenSettingsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        _buildSettingOption(Icons.edit, S.of(context).profileScreenEditProfile,
            () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditProfileScreen(user: user)),
          );
        }),
        // ✅ زر تغيير اللغة
        _buildSettingOption(
          Icons.language,
          S.of(context).changeLanguageButton,
          _showChangeLanguageDialog,
        ),
        _buildSettingOption(Icons.logout, S.of(context).profileScreenLogOut,
            () {
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
              style: const TextStyle(
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
            _loadUserSubscription();
          });
        },
        child: Text(
          _currentSubscription == null
              ? S.of(context).profileScreenSubscribeButton
              : S.of(context).profileScreenUpgradePlanButton,
          style: const TextStyle(
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
        title: Text(S.of(context).profileScreenLogOutTitle),
        content: Text(S.of(context).profileScreenLogOutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).profileScreenCancelButton),
          ),
          TextButton(
            onPressed: () async {
              CacheHelper.remove('token');
              navigateToAndKill(context, const RoleSelectionScreen());
            },
            child: Text(
              S.of(context).profileScreenLogOutButton,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileLoading {}

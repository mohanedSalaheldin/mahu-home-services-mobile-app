import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/edit_profile_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/help_center_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/privacy_policy_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/terms_of_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

import '../../../../core/utils/helpers/localization_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileServices _profileServices = ProfileServices();
  UserBaseProfileModel? _userProfile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _profileServices.getProfile();

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.message;
        });
      },
      (profile) {
        setState(() {
          _isLoading = false;
          _userProfile = profile;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _isLoading
          ? _buildLoadingState()
          : RefreshIndicator(
              onRefresh: _loadUserProfile,
              color: AppColors.primary,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_errorMessage != null) _buildErrorState(),
                      if (_userProfile != null)
                        _ProfileHeader(user: _userProfile!)
                            .animate()
                            .fadeIn(delay: 100.ms),
                      if (_userProfile == null && _errorMessage == null)
                        _buildEmptyState(),
                      Gap(32.h),
                      _sectionTitle(S.of(context).profileScreenSectionAccount,
                          delay: 200.ms),

                      Gap(16.h),
                      _ProfileOption(
                        icon: Icons.person_outline_rounded,
                        title: S.of(context).profileScreenPersonalInfoTitle,
                        subtitle:
                            S.of(context).profileScreenPersonalInfoSubtitle,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(user: _userProfile!),
                          ),
                        ).then((updatedProfile) {
                          if (updatedProfile != null) {
                            // setState(() {
                            //   _userProfile = updatedProfile;
                            // });
                          }
                        }),
                      ).animate().fadeIn(delay: 250.ms),
                      Gap(16.h),
                      // _ProfileOption(
                      //   icon: Icons.location_on_outlined,
                      //   title: S.of(context).profileScreenAddressBookTitle,
                      //   subtitle: S.of(context).profileScreenAddressBookSubtitle,
                      //   onTap: () => _showComingSoon(context),
                      // ).animate().fadeIn(delay: 300.ms),
                      // Gap(32.h),
                      _sectionTitle(S.of(context).profileScreenSectionSupport,
                          delay: 600.ms),
                      Gap(16.h),
                      _ProfileOption(
                        icon: Icons.language_rounded,
                        title: S.of(context).profileScreenLanguageTitle,
                        subtitle: S.of(context).profileScreenLanguageSubtitle,
                        onTap: () {
                          // استدعاء الـ Cubit لتغيير اللغة
                          context.read<LocaleCubit>().toggleLocale();
                        },
                      ).animate().fadeIn(delay: 750.ms),
                      Gap(16.h),
                      _ProfileOption(
                        icon: Icons.help_outline_rounded,
                        title: S.of(context).profileScreenHelpCenterTitle,
                        subtitle: S.of(context).profileScreenHelpCenterSubtitle,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpCenterScreen()),
                        ),
                      ).animate().fadeIn(delay: 650.ms),
                      Gap(16.h),
                      _ProfileOption(
                        icon: Icons.security_outlined,
                        title: S.of(context).profileScreenPrivacyPolicyTitle,
                        subtitle:
                            S.of(context).profileScreenPrivacyPolicySubtitle,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PrivacyPolicyScreen()),
                        ),
                      ).animate().fadeIn(delay: 700.ms),
                      Gap(16.h),
                      _ProfileOption(
                        icon: Icons.description_outlined,
                        title: S.of(context).profileScreenTermsOfServiceTitle,
                        subtitle:
                            S.of(context).profileScreenTermsOfServiceSubtitle,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TermsOfServiceScreen()),
                        ),
                      ).animate().fadeIn(delay: 750.ms),
                      Gap(32.h),
                      _ProfileOption(
                        icon: Icons.logout_rounded,
                        title: S.of(context).profileScreenLogoutTitle,
                        subtitle: S.of(context).profileScreenLogoutSubtitle,
                        onTap: _logout,
                        color: Colors.red,
                      ).animate().fadeIn(delay: 800.ms),
                      Gap(40.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _sectionTitle(String title, {Duration? delay}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade600,
        letterSpacing: 1.3,
      ),
    ).animate().fadeIn(delay: delay ?? 0.ms);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70.w,
            height: 70.w,
            child: const CircularProgressIndicator(
              strokeWidth: 4,
              color: AppColors.primary,
            ),
          ),
          Gap(28.h),
          Text(
            S.of(context).profileScreenLoading,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 52,
              color: Colors.red.shade400,
            ),
            Gap(14.h),
            Text(
              S.of(context).profileScreenErrorTitle,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            Gap(10.h),
            Text(
              _errorMessage ?? S.of(context).profileScreenErrorDefault,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(18.h),
            ElevatedButton(
              onPressed: _loadUserProfile,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                S.of(context).profileScreenTryAgain,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            Container(
              width: 85.w,
              height: 85.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Icon(
                Icons.person,
                size: 36,
                color: Colors.grey.shade400,
              ),
            ),
            Gap(18.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).profileScreenEmptyTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Gap(6.h),
                  Text(
                    S.of(context).profileScreenEmptyMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).profileScreenComingSoon),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          S.of(context).profileScreenLogoutDialogTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          S.of(context).profileScreenLogoutDialogContent,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.remove('token');
              navigateToAndKill(context, const RoleSelectionScreen());
            },
            child: Text(
              S.of(context).profileScreenLogoutCancel,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigator.pop(context, true);
              navigateToAndKill(context, const RoleSelectionScreen());
            },
            child: Text(
              S.of(context).profileScreenLogoutConfirm,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await CacheHelper.remove('token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserBaseProfileModel user;

  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    final name = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    final displayName =
        name.isNotEmpty ? name : S.of(context).profileScreenUnknownUser;
    final email = user.email ?? S.of(context).profileScreenNoEmail;
    final phone = user.phone ?? S.of(context).profileScreenNoPhone;
    final avatar = user.avatar ?? '';
    final businessName = user.businessName ?? '';

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      margin: EdgeInsets.symmetric(vertical: 12.h),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            Container(
              width: 85.w,
              height: 85.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: avatar.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: avatar,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.primary.withOpacity(0.1),
                          child: const Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (businessName.isNotEmpty) ...[
                    Text(
                      businessName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                  ],
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: businessName.isNotEmpty ? 15 : 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(6.h),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.h),
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 6.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: (color ?? AppColors.primary).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: color ?? AppColors.primary,
                ),
              ),
              Gap(18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: color ?? Colors.grey.shade800,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

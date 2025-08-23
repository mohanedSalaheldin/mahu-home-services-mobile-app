import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/Help_center_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/privacy_policy_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/terms_of_service.dart';

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
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                    Gap(24.h),

                    // Account Section
                    Text(
                      'ACCOUNT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                    Gap(12.h),

                    _ProfileOption(
                      icon: Icons.person_outline_rounded,
                      title: 'Personal Information',
                      subtitle: 'Update your personal details',
                      onTap: () => _showComingSoon(context),
                    ).animate().fadeIn(delay: 250.ms),
                    Gap(12.h),

                    _ProfileOption(
                      icon: Icons.location_on_outlined,
                      title: 'Address Book',
                      subtitle: 'Manage your addresses',
                      onTap: () => _showComingSoon(context),
                    ).animate().fadeIn(delay: 300.ms),
                    Gap(12.h),

                    // _ProfileOption(
                    //   icon: Icons.notifications_outlined,
                    //   title: 'Notifications',
                    //   subtitle: 'Manage your preferences',
                    //   onTap: () => _showComingSoon(context),
                    // ).animate().fadeIn(delay: 350.ms),

                    // // Services Section
                    // Text(
                    //   'SERVICES',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.grey.shade600,
                    //     letterSpacing: 1.2,
                    //   ),
                    // ).animate().fadeIn(delay: 400.ms),
                    // Gap(12.h),

                    // _ProfileOption(
                    //   icon: Icons.history_rounded,
                    //   title: 'Booking History',
                    //   subtitle: 'View your past bookings',
                    //   onTap: () => _showComingSoon(context),
                    // ).animate().fadeIn(delay: 450.ms),
                    // Gap(12.h),

                    // _ProfileOption(
                    //   icon: Icons.favorite_outline_rounded,
                    //   title: 'Favorites',
                    //   subtitle: 'Your saved services',
                    //   onTap: () => _showComingSoon(context),
                    // ).animate().fadeIn(delay: 500.ms),
                    // Gap(12.h),

                    // _ProfileOption(
                    //   icon: Icons.star_outline_rounded,
                    //   title: 'Reviews',
                    //   subtitle: 'Your service reviews',
                    //   onTap: () => _showComingSoon(context),
                    // ).animate().fadeIn(delay: 550.ms),

                    Gap(24.h),

                    // Support Section
                    Text(
                      'SUPPORT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 1.2,
                      ),
                    ).animate().fadeIn(delay: 600.ms),
                    Gap(12.h),

                    _ProfileOption(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      subtitle: 'Get help and support',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpCenterScreen()),
                      ),
                    ).animate().fadeIn(delay: 650.ms),
                    Gap(12.h),

                    _ProfileOption(
                      icon: Icons.security_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'Read our privacy policy',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen()),
                      ),
                    ).animate().fadeIn(delay: 700.ms),
                    Gap(12.h),

                    _ProfileOption(
                      icon: Icons.description_outlined,
                      title: 'Terms of Service',
                      subtitle: 'Read our terms and conditions',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsOfServiceScreen()),
                      ),
                    ).animate().fadeIn(delay: 750.ms),

                    Gap(24.h),

                    // Logout Section
                    _ProfileOption(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      subtitle: 'Sign out of your account',
                      onTap: _logout,
                      color: Colors.red,
                    ).animate().fadeIn(delay: 800.ms),

                    Gap(32.h),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60.w,
            height: 60.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ),
          Gap(24.h),
          Text(
            'Loading your profile...',
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Colors.red.shade400,
            ),
            Gap(12.h),
            Text(
              'Failed to load profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            Gap(8.h),
            Text(
              _errorMessage ?? 'Please try again later',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(16.h),
            ElevatedButton(
              onPressed: _loadUserProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: Icon(
                Icons.person,
                size: 32,
                color: Colors.grey.shade400,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'No profile information available',
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
        content: Text('This feature is coming soon!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Log Out',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your account?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Log Out',
              style: TextStyle(
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
          builder: (context) => const RoleSelectionScreen(),
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
    final displayName = name.isNotEmpty ? name : 'User';
    final email = user.email ?? 'user@example.com';
    final phone = user.phone ?? 'No phone number';
    final avatar = user.avatar;
    final businessName = user.businessName;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      margin: EdgeInsets.all(10.w),
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Row(
          children: [
            // Profile Avatar
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: avatar != null && avatar.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: avatar,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.primary.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
              ),
            ),
            Gap(16.w),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (businessName != null && businessName.isNotEmpty) ...[
                    Text(
                      businessName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(2.h),
                  ],
                  Text(
                    displayName,
                    style: TextStyle(
                      fontSize: businessName != null ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.h),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(2.h),
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

            // Edit Button
            // IconButton(
            //   onPressed: () => _showComingSoon(context),
            //   icon: Icon(
            //     Icons.edit_outlined,
            //     color: AppColors.primary,
            //     size: 20,
            //   ),
            // ),
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
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: (color ?? AppColors.primary).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color ?? AppColors.primary,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: color ?? Colors.grey.shade800,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
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

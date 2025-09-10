import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms of Service',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.description_rounded,
                    size: 64.w,
                    color: AppColors.primary,
                  ),
                  Gap(16.h),
                  Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Last updated: ${_getCurrentDate()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),

            // Agreement
            Text(
              'Please read these Terms of Service carefully before using our services.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            Gap(24.h),

            // Terms Sections
            _buildTermSection(
              title: '1. Acceptance of Terms',
              content: '''
By accessing or using Mahu Home Services, you agree to be bound by these Terms of Service and our Privacy Policy. If you do not agree to these terms, please do not use our services.
''',
            ),

            _buildTermSection(
              title: '2. Service Description',
              content: '''
Mahu Home Services connects users with service providers for various home services including cleaning, repair, painting, and electrical services. We act as an intermediary platform.
''',
            ),

            _buildTermSection(
              title: '3. User Accounts',
              content: '''
You must create an account to use our services. You are responsible for:
- Maintaining account security
- Providing accurate information
- All activities under your account
- Notifying us of unauthorized access
''',
            ),

            _buildTermSection(
              title: '4. Booking and Payments',
              content: '''
- Bookings are subject to provider availability
- Payments are processed through secure channels
- Cancellation policies vary by service type
- Refunds are subject to our refund policy
''',
            ),

            _buildTermSection(
              title: '5. User Conduct',
              content: '''
You agree not to:
- Use the service for illegal purposes
- Harass service providers or other users
- Post false or misleading information
- Attempt to circumvent the platform
- Damage the reputation of the service
''',
            ),

            _buildTermSection(
              title: '6. Limitation of Liability',
              content: '''
Mahu Home Services is not liable for:
- Quality of services provided by third parties
- Damages or losses during service provision
- Disputes between users and service providers
- Technical issues beyond our control
''',
            ),

            _buildTermSection(
              title: '7. Termination',
              content: '''
We may terminate or suspend your account at our discretion if you violate these terms. You may also terminate your account at any time.
''',
            ),

            _buildTermSection(
              title: '8. Changes to Terms',
              content: '''
We may modify these terms at any time. Continued use of the service constitutes acceptance of modified terms.
''',
            ),

            _buildTermSection(
              title: '9. Governing Law',
              content: '''
These terms are governed by the laws of [Your Country/State]. Any disputes shall be resolved in the courts of [Your Jurisdiction].
''',
            ),

            Gap(24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'By using Mahu Home Services, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Gap(8.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
        Gap(24.h),
      ],
    );
  }

  String _getCurrentDate() {
    return 'December 15, 2024';
  }
}

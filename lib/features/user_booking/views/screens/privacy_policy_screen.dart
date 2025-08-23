import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
                    Icons.security_rounded,
                    size: 64.w,
                    color: AppColors.primary,
                  ),
                  Gap(16.h),
                  Text(
                    'Privacy Policy',
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

            // Policy Sections
            _buildPolicySection(
              title: '1. Information We Collect',
              content: '''
We collect information you provide directly to us, including:
- Personal information (name, email, phone number)
- Service preferences and booking history
- Payment information
- Location data for service delivery
''',
            ),

            _buildPolicySection(
              title: '2. How We Use Your Information',
              content: '''
We use your information to:
- Provide and improve our services
- Process your bookings and payments
- Communicate with you about services
- Ensure safety and security
- Comply with legal obligations
''',
            ),

            _buildPolicySection(
              title: '3. Data Sharing',
              content: '''
We may share your information with:
- Service providers to fulfill bookings
- Payment processors for transaction processing
- Legal authorities when required by law
- Business partners with your consent
''',
            ),

            _buildPolicySection(
              title: '4. Data Security',
              content: '''
We implement security measures including:
- Encryption of sensitive data
- Secure servers and infrastructure
- Regular security audits
- Access controls and authentication
''',
            ),

            _buildPolicySection(
              title: '5. Your Rights',
              content: '''
You have the right to:
- Access your personal information
- Correct inaccurate data
- Request data deletion
- Opt-out of marketing communications
- Data portability
''',
            ),

            _buildPolicySection(
              title: '6. Contact Us',
              content: '''
If you have questions about this privacy policy, please contact us at:
- Email: privacy@mahu.com
- Phone: +1 (555) 123-4567
- Address: 123 Service Street, City, Country
''',
            ),

            Gap(24.h),
            Text(
              'By using our services, you agree to the terms of this Privacy Policy.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
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

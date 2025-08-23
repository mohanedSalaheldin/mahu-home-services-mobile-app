import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Center',
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
                    Icons.help_outline_rounded,
                    size: 64.w,
                    color: AppColors.primary,
                  ),
                  Gap(16.h),
                  Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Find answers to common questions and get support',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Gap(32.h),

            // Search
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade500),
                  Gap(12.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for help...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),

            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(16.h),

            _buildFAQItem(
              question: 'How do I book a service?',
              answer:
                  'To book a service, browse available services, select your preferred time slot, and proceed to payment.',
            ),
            _buildFAQItem(
              question: 'What payment methods are accepted?',
              answer:
                  'We accept credit cards, debit cards, and mobile payment options.',
            ),
            _buildFAQItem(
              question: 'Can I cancel or reschedule my booking?',
              answer:
                  'Yes, you can cancel or reschedule up to 24 hours before your appointment.',
            ),
            _buildFAQItem(
              question: 'How do I contact my service provider?',
              answer:
                  'You can message your provider directly through the app after booking.',
            ),

            Gap(24.h),

            // Contact Support
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Still need help?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Our support team is available 24/7 to assist you with any questions or concerns.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gap(16.h),
                  Row(
                    children: [
                      _buildContactOption(
                        icon: Icons.email,
                        title: 'Email',
                        onTap: () => _contactEmail(),
                      ),
                      Gap(16.w),
                      _buildContactOption(
                        icon: Icons.phone,
                        title: 'Call',
                        onTap: () => _contactPhone(),
                      ),
                      Gap(16.w),
                      _buildContactOption(
                        icon: Icons.chat,
                        title: 'Chat',
                        onTap: () => _contactChat(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              Gap(8.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _contactEmail() {
    // Implement email contact
  }

  void _contactPhone() {
    // Implement phone contact
  }

  void _contactChat() {
    // Implement chat contact
  }
}

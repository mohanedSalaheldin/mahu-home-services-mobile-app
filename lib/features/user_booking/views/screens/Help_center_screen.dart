import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).helpCenterScreenTitle,
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
                    S.of(context).helpCenterScreenHeader,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    S.of(context).helpCenterScreenSubheader,
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
                        hintText: S.of(context).helpCenterScreenSearchHint,
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
              S.of(context).helpCenterScreenFAQTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(16.h),

            _buildFAQItem(
              context: context,
              question: S.of(context).helpCenterScreenFAQBookServiceQuestion,
              answer: S.of(context).helpCenterScreenFAQBookServiceAnswer,
            ),
            _buildFAQItem(
              context: context,
              question: S.of(context).helpCenterScreenFAQPaymentMethodsQuestion,
              answer: S.of(context).helpCenterScreenFAQPaymentMethodsAnswer,
            ),
            _buildFAQItem(
              context: context,
              question:
                  S.of(context).helpCenterScreenFAQCancelRescheduleQuestion,
              answer: S.of(context).helpCenterScreenFAQCancelRescheduleAnswer,
            ),
            _buildFAQItem(
              context: context,
              question:
                  S.of(context).helpCenterScreenFAQContactProviderQuestion,
              answer: S.of(context).helpCenterScreenFAQContactProviderAnswer,
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
                    S.of(context).helpCenterScreenContactTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    S.of(context).helpCenterScreenContactDescription,
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
                        title: S.of(context).helpCenterScreenContactEmail,
                        onTap: () => _contactEmail(),
                      ),
                      Gap(16.w),
                      _buildContactOption(
                        icon: Icons.phone,
                        title: S.of(context).helpCenterScreenContactPhone,
                        onTap: () => _contactPhone(),
                      ),
                      Gap(16.w),
                      _buildContactOption(
                        icon: Icons.chat,
                        title: S.of(context).helpCenterScreenContactChat,
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

  Widget _buildFAQItem({
    required BuildContext context,
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
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
                style: const TextStyle(
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

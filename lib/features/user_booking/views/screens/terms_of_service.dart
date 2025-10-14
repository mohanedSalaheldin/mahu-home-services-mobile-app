import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).termsOfServiceScreenTitle,
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
                    S.of(context).termsOfServiceScreenTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    S.of(context).termsOfServiceScreenLastUpdated(
                        _getCurrentDate(context)),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),
            Text(
              S.of(context).termsOfServiceScreenIntro,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            Gap(24.h),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection1Title,
              content: S.of(context).termsOfServiceScreenSection1Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection2Title,
              content: S.of(context).termsOfServiceScreenSection2Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection3Title,
              content: S.of(context).termsOfServiceScreenSection3Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection4Title,
              content: S.of(context).termsOfServiceScreenSection4Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection5Title,
              content: S.of(context).termsOfServiceScreenSection5Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection6Title,
              content: S.of(context).termsOfServiceScreenSection6Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection7Title,
              content: S.of(context).termsOfServiceScreenSection7Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection8Title,
              content: S.of(context).termsOfServiceScreenSection8Content,
            ),
            _buildTermSection(
              title: S.of(context).termsOfServiceScreenSection9Title,
              content: S.of(context).termsOfServiceScreenSection9Content(
                  _getJurisdiction(context)),
            ),
            Gap(24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                S.of(context).termsOfServiceScreenAcknowledgment,
                style: const TextStyle(
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
          style: const TextStyle(
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

  String _getCurrentDate(BuildContext context) {
    return DateFormat(
            'MMMM dd, yyyy', Localizations.localeOf(context).languageCode)
        .format(DateTime(2024, 12, 15));
  }

  String _getJurisdiction(BuildContext context) {
    // Placeholder: Replace with actual logic to determine jurisdiction
    return S.of(context).termsOfServiceScreenDefaultJurisdiction;
  }
}

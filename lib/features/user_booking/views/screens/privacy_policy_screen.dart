import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).privacyPolicyScreenTitle,
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
                    Icons.security_rounded,
                    size: 64.w,
                    color: AppColors.primary,
                  ),
                  Gap(16.h),
                  Text(
                    S.of(context).privacyPolicyScreenTitle,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    S.of(context).privacyPolicyScreenLastUpdated(
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
            _buildPolicySection(
              title: S.of(context).privacyPolicyScreenSection1Title,
              content: S.of(context).privacyPolicyScreenSection1Content,
            ),
            _buildPolicySection(
              title: S.of(context).privacyPolicyScreenSection2Title,
              content: S.of(context).privacyPolicyScreenSection2Content,
            ),
            _buildPolicySection(
              title: S.of(context).privacyPolicyScreenSection3Title,
              content: S.of(context).privacyPolicyScreenSection3Content,
            ),
            _buildPolicySection(
              title: S.of(context).privacyPolicyScreenSection4Title,
              content: S.of(context).privacyPolicyScreenSection4Content,
            ),
            _buildPolicySection(
              title: S.of(context).privacyPolicyScreenSection5Title,
              content: S.of(context).privacyPolicyScreenSection5Content,
            ),
            _buildPolicySection(
              title: S.of(context).privacyPolicyScreenSection6Title,
              content: S.of(context).privacyPolicyScreenSection6Content,
            ),
            Gap(24.h),
            Text(
              S.of(context).privacyPolicyScreenConsent,
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
    return DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
        .format(DateTime.now());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class HomeAppbarLeadingWidget extends StatelessWidget {
  const HomeAppbarLeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(AppConst.appPadding.w),
        const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 23,
        ),
        Gap(8.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreeting(context),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(.5),
              ),
            ),
            Text(
              _getLocation(context),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getGreeting(BuildContext context) {
    // Placeholder: Replace with actual user name logic (e.g., from user profile)
    const String userName = 'Mark'; // Hardcoded for now
    return userName.isNotEmpty
        ? S.of(context).homeAppbarLeadingWidgetGreeting(userName)
        : S.of(context).homeAppbarLeadingWidgetDefaultGreeting;
  }

  String _getLocation(BuildContext context) {
    // Placeholder: Replace with actual location logic (e.g., from user settings or geolocation)
    const String location = 'UAE, Dubai'; // Hardcoded for now
    return location.isNotEmpty
        ? S.of(context).homeAppbarLeadingWidgetLocation(location)
        : S.of(context).homeAppbarLeadingWidgetDefaultLocation;
  }
}

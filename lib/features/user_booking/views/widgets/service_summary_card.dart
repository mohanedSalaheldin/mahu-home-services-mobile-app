import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class ServiceSummaryCard extends StatelessWidget {
  const ServiceSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            height: 71.h,
            width: 113.w,
            fit: BoxFit.cover,
            'assets/imgs/home_cleaning.jpg',
          ),
        ),
        Gap(12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getLocalizedServiceName(context),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            RichText(
              text: TextSpan(
                text: _getLocalizedPrice(context),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: S.of(context).serviceSummaryCardPerHour,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Color(0xffFDC95B),
              size: 18,
            ),
            Text(
              _getLocalizedRating(context),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getLocalizedServiceName(BuildContext context) {
    // Placeholder: Replace with actual logic to fetch service name
    return S.of(context).serviceSummaryCardHomeCleaningName;
  }

  String _getLocalizedPrice(BuildContext context) {
    // Placeholder: Replace with actual logic to fetch price
    const double price = 300; // Hardcoded for now
    return NumberFormat.currency(
      locale: Localizations.localeOf(context).languageCode,
      symbol: S.of(context).serviceSummaryCardCurrencySymbol,
      decimalDigits: 0,
    ).format(price);
  }

  String _getLocalizedRating(BuildContext context) {
    // Placeholder: Replace with actual logic to fetch rating
    const double rating = 4.5; // Hardcoded for now
    return NumberFormat.decimalPattern(
      Localizations.localeOf(context).languageCode,
    ).format(rating);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class PaymentCardDetailsWidget extends StatelessWidget {
  const PaymentCardDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 206.h,
      decoration: const BoxDecoration(
        color: Color(0xff333333),
        borderRadius: BorderRadius.all(Radius.circular(24)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/imgs/visa_card.PNG',
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getCardNumber(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).paymentCardDetailsWidgetCardHolderLabel,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(153, 246, 246, 246),
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      _getCardHolderName(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Gap(30.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).paymentCardDetailsWidgetExpiryDateLabel,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(153, 246, 246, 246),
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      _getExpiryDate(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getCardNumber() {
    // Placeholder: Replace with actual card number logic (e.g., from payment method data)
    return '4556 **** **** 7654';
  }

  String _getCardHolderName() {
    // Placeholder: Replace with actual cardholder name logic (e.g., from user profile)
    return 'Hosam Ali';
  }

  String _getExpiryDate() {
    // Placeholder: Replace with actual expiry date logic (e.g., from payment method data)
    return '14/2/28';
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
              '4556 ****  **** 7654',
              style: TextStyle(
                fontSize: 20.sp,
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
                      'Card Holder Name',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(153, 246, 246, 246),
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      'Hosam Ali',
                      style: TextStyle(
                        fontSize: 13.sp,
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
                      'Expiry Date',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(153, 246, 246, 246),
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      '14/2/28',
                      style: TextStyle(
                        fontSize: 13.sp,
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
}

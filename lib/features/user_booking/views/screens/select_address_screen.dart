import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/select_payment_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class SelectAddressScreen extends StatelessWidget {
  const SelectAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectAddressScreenTitle),
        centerTitle: true,
        leading: const BackButton(
          style: ButtonStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: Column(
          children: [
            const AddressCardWidget(),
            Gap(20.h),
            GestureDetector(
              onTap: () {
                // Navigate to add new address screen
              },
              child: DottedBorderButton(
                text: S.of(context).selectAddressScreenAddNew,
                icon: Icons.add_circle_outline,
              ),
            ),
            Gap(20.h),
            const Spacer(),
            AppFilledButton(
              onPressed: () {
                navigateTo(context, const SelectPaymentMethodScreen());
              },
              fontSize: 15,
              text: S.of(context).selectAddressScreenContinue,
            ),
          ],
        ),
      ),
    );
  }
}

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 104.h,
      decoration: const BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(13.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Color.fromRGBO(30, 136, 229, 0.105),
            foregroundColor: AppColors.blue,
            radius: 20,
            child: Icon(Icons.meeting_room),
          ),
          Gap(16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).selectAddressScreenHomeLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                S.of(context).selectAddressScreenSampleAddress,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
              activeColor: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class DottedBorderButton extends StatelessWidget {
  final String text;
  final IconData icon;

  const DottedBorderButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.blue,
      strokeWidth: 1,
      dashPattern: const [8, 8],
      borderType: BorderType.RRect,
      radius: const Radius.circular(30),
      child: Container(
        height: 59,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
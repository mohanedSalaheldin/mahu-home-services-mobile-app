import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/add_payment_method_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/review_booking_summary_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/home_section_label_text.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class SelectPaymentMethodScreen extends StatelessWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectPaymentMethodScreenTitle),
        centerTitle: true,
        leading: const BackButton(
          style: ButtonStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeSectionLabelText(
              txt: S.of(context).selectPaymentMethodScreenCashSection,
              fontSize: 21,
            ),
            Gap(24.h),
            PaymentMethodCardWidget(
              label: S.of(context).selectPaymentMethodScreenCashLabel,
              icon: Icons.money_outlined,
              groupValue: 1,
              value: 1,
            ),
            Gap(24.h),
            HomeSectionLabelText(
              txt: S.of(context).selectPaymentMethodScreenMoreOptionsSection,
              fontSize: 21,
            ),
            Gap(24.h),
            PaymentMethodCardWidget(
              label: S.of(context).selectPaymentMethodScreenMasterCardLabel,
              icon: FontAwesomeIcons.ccMastercard,
              groupValue: 1,
              value: 2,
            ),
            Gap(24.h),
            GestureDetector(
              onTap: () {
                navigateTo(context, const AddPaymentMethodScreen());
              },
              child: DottedBorderButton(
                text: S.of(context).selectPaymentMethodScreenAddNew,
                icon: Icons.add_circle_outline,
              ),
            ),
            Gap(20.h),
            const Spacer(),
            AppFilledButton(
              onPressed: () {
                // navigateTo(context, const ReviewBookingSummaryScreen());
              },
              fontSize: 15,
              text: S.of(context).selectPaymentMethodScreenContinue,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCardWidget extends StatelessWidget {
  const PaymentMethodCardWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.groupValue,
    required this.value,
  });
  final String label;
  final IconData icon;
  final int groupValue;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      decoration: const BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(13.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(30, 136, 229, 0.105),
            foregroundColor: AppColors.blue,
            radius: 20,
            child: Icon(icon),
          ),
          Gap(16.w),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.5,
            child: Radio(
              value: value,
              groupValue: groupValue,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/terms_checkbox.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/review_booking_summary_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/date_and_time_form_filed_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/payment_card_details_widget.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  bool agreedToTerms = false;
  bool showTermsError = false;

  // Custom validation methods to avoid modifying FormValidationMethod
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).addPaymentMethodScreenNameError;
    }
    return null;
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).addPaymentMethodScreenCardNumberError;
    }
    if (!RegExp(r'^\d{16}$').hasMatch(value)) {
      return S.of(context).addPaymentMethodScreenCardNumberInvalidError;
    }
    return null;
  }

  String? _validateCvv(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).addPaymentMethodScreenCvvError;
    }
    if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
      return S.of(context).addPaymentMethodScreenCvvInvalidError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addPaymentMethodScreenTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PaymentCardDetailsWidget(),
            Gap(10.h),
            CustomTextField(
              label: S.of(context).addPaymentMethodScreenNameLabel,
              hint: S.of(context).addPaymentMethodScreenNameHint,
              keyboardType: TextInputType.name,
              controller: TextEditingController(),
              validator: _validateName,
            ),
            Gap(10.h),
            CustomTextField(
              label: S.of(context).addPaymentMethodScreenCardNumberLabel,
              hint: S.of(context).addPaymentMethodScreenCardNumberHint,
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
              validator: _validateCardNumber,
            ),
            Gap(10.h),
            DateAndTimeFormFiledWidget(isDateNotTime: true),
            Gap(10.h),
            CustomTextField(
              label: S.of(context).addPaymentMethodScreenCvvLabel,
              hint: S.of(context).addPaymentMethodScreenCvvHint,
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
              validator: _validateCvv,
            ),
            Gap(10.h),
            const Spacer(),
            TermsCheckbox(
              value: agreedToTerms,
              onChanged: (value) {
                setState(() {
                  agreedToTerms = value ?? false;
                  if (agreedToTerms) showTermsError = false;
                });
              },
              onTapTerms: () {
                // Show terms or navigate to terms screen
              },
            ),
            if (showTermsError)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  S.of(context).addPaymentMethodScreenTermsError,
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
            Gap(10.h),
            AppFilledButton(
              onPressed: () {
                setState(() {
                  showTermsError = !agreedToTerms;
                });
                if (agreedToTerms) {
                  // navigateTo(context, const ReviewBookingSummaryScreen());
                }
              },
              fontSize: 15,
              text: S.of(context).addPaymentMethodScreenContinueButton,
            ),
          ],
        ),
      ),
    );
  }
}

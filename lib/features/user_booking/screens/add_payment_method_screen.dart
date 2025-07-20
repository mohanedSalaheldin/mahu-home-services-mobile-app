import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/terms_checkbox.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/review_booking_summary_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/date_and_time_form_filed_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/payment_card_details_widget.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  bool agreedToTerms = false;
  bool showTermsError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment Method'),
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
              label: 'Name',
              hint: 'Enter Name',
              keyboardType: TextInputType.name,
              controller: TextEditingController(),
              validator: FormValidationMethod.validateEmail,
            ),
            Gap(10.h),
            CustomTextField(
              label: 'Card Number',
              hint: 'Enter Card Number',
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
              validator: FormValidationMethod.validateEmail,
            ),
            Gap(10.h),
            DateAndTimeFormFiledWidget(isDateNotTime: true),
            Gap(10.h),
            CustomTextField(
              label: 'CVV',
              hint: 'CVV',
              keyboardType: TextInputType.number,
              controller: TextEditingController(),
              validator: FormValidationMethod.validateEmail,
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
            Gap(10.h),
            AppFilledButton(
              onPressed: () {
                navigateTo(context, const ReviewBookingSummaryScreen());
              },
              fontSize: 15,
              text: "Continue",
            ),
          ],
        ),
      ),
    );
  }
}

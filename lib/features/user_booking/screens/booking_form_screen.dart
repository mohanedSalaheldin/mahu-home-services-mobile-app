import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/phone_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/select_rooms_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/date_and_time_form_filed_widget.dart';

class BookingFormScreen extends StatelessWidget {
  const BookingFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Form'),
        centerTitle: true,
        leading: const BackButton(
          style: ButtonStyle(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.all(AppConst.appPadding.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Name',
                        hint: 'Enter Name',
                        keyboardType: TextInputType.name,
                        controller: TextEditingController(),
                        validator: FormValidationMethod.validateEmail,
                      ),
                      Gap(10.h),
                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter Email Address',
                        keyboardType: TextInputType.emailAddress,
                        controller: TextEditingController(),
                        validator: FormValidationMethod.validateEmail,
                      ),
                      Gap(10.h),
                      DateAndTimeFormFiledWidget(isDateNotTime: true),
                      Gap(10.h),
                      DateAndTimeFormFiledWidget(isDateNotTime: false),
                      Gap(10.h),
                      const AppFieledLabelText(label: 'Additional Notes'),
                      TextFormField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.name,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Add Note',
                          hintStyle: TextStyle(
                            height: 4,
                            color: Colors.black.withOpacity(.5),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                          filled: true,
                          fillColor: AppColors.greyBack,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                      ),
                      const Spacer(),
                      AppFilledButton(
                        onPressed: () {
                          navigateTo(context, const SelectRoomsScreen());
                        },
                        fontSize: 15,
                        text: "Continue",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

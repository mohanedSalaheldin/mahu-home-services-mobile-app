import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/select_payment_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/select_room_count_list_tile_widget.dart';

class SelectAddressScreen extends StatelessWidget {
  const SelectAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
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
            // Gap(20.h),
            GestureDetector(
              onTap: () {
                // Navigate to add new address screen
              },
              child: const DottedBorderButton(
                text: "Add New Address",
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
              text: "Continue",
            ),
          ],
        ),
      ),
    );
  }
}

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    super.key,
  });

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
                'Home',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '7421 Ajman Street, Ajman ,\n floor 3 , UAE',
                style: TextStyle(
                  fontSize: 12.sp,
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
          )
        ],
      ),
    );
  }
}

// Helper Widget for the dotted button
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
          // borderRadius: BorderRadius.circular(30),
          // border: Border.all(
          //     color: Colors.blue, style: BorderStyle.solid, width: 1.5),
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

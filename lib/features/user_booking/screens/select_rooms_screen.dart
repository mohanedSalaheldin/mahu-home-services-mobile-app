import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/select_address_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/select_room_count_list_tile_widget.dart';

class SelectRoomsScreen extends StatelessWidget {
  const SelectRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Rooms'),
        centerTitle: true,
        leading: const BackButton(
          style: ButtonStyle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: Column(
          children: [
            SelectRoomCountListTileWidget(
              label: 'Living Room',
              icon: Icons.meeting_room,
              onChanged: (int value) {
                // print('عدد الغرف: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: 'Living Room',
              icon: Icons.chair, // أو أيقونة مناسبة
              onChanged: (value) {
                print('Living Room: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: 'Bedroom',
              icon: Icons.bed,
              onChanged: (value) {
                print('Bedroom: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: 'Dining Room',
              icon: Icons.local_dining,
              onChanged: (value) {
                print('Dining Room: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: 'Bathroom',
              icon: Icons.bathtub,
              onChanged: (value) {
                print('Bathroom: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: 'Kitchen',
              icon: Icons.kitchen,
              onChanged: (value) {
                print('Kitchen: $value');
              },
            ),
            const Spacer(),
            AppFilledButton(
              onPressed: () {
                navigateTo(context, const SelectAddressScreen());
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

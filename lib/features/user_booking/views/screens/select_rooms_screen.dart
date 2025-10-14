import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/select_address_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/select_room_count_list_tile_widget.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class SelectRoomsScreen extends StatelessWidget {
  const SelectRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectRoomsScreenTitle),
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
              label: S.of(context).selectRoomsScreenLivingRoomLabel,
              icon: Icons.meeting_room,
              onChanged: (int value) {
                // print('عدد الغرف: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: S.of(context).selectRoomsScreenLivingRoomLabel,
              icon: Icons.chair,
              onChanged: (value) {
                print('Living Room: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: S.of(context).selectRoomsScreenBedroomLabel,
              icon: Icons.bed,
              onChanged: (value) {
                print('Bedroom: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: S.of(context).selectRoomsScreenDiningRoomLabel,
              icon: Icons.local_dining,
              onChanged: (value) {
                print('Dining Room: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: S.of(context).selectRoomsScreenBathroomLabel,
              icon: Icons.bathtub,
              onChanged: (value) {
                print('Bathroom: $value');
              },
            ),
            Gap(20.h),
            SelectRoomCountListTileWidget(
              label: S.of(context).selectRoomsScreenKitchenLabel,
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
              text: S.of(context).selectRoomsScreenContinue,
            ),
          ],
        ),
      ),
    );
  }
}
// action_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class ActionButtons extends StatelessWidget {
  final bool isActive;
  // final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onToggleStatus;

  const ActionButtons({
    super.key,
    required this.isActive,
    // required this.onDelete,
    required this.onEdit,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle Status Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onToggleStatus,
            icon: Icon(
              isActive ? Icons.pause_rounded : Icons.play_arrow_rounded,
              size: 20.sp,
            ),
            label: Text(
              isActive ? 'Deactivate Service' : 'Activate Service',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive ? AppColors.warning : AppColors.success,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Gap(12.h),
        
        // Edit and Delete Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onEdit,
                icon: Icon(
                  Icons.edit_rounded,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                label: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),
            Gap(12.w),
            
          ],
        ),
      ],
    );
  }
}
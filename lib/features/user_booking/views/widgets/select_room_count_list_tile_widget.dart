import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/select_rooms_screen.dart';

class SelectRoomCountListTileWidget extends StatefulWidget {
  const SelectRoomCountListTileWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final ValueChanged<int> onChanged;

  @override
  State<SelectRoomCountListTileWidget> createState() =>
      _SelectRoomCountListTileWidgetState();
}

class _SelectRoomCountListTileWidgetState
    extends State<SelectRoomCountListTileWidget> {
  int _count = 1;

  void _increase() {
    setState(() {
      _count++;
    });
    widget.onChanged(_count);
  }

  void _decrease() {
    if (_count > 0) {
      setState(() {
        _count--;
      });
      widget.onChanged(_count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: const BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(30, 136, 229, 0.105),
            foregroundColor: AppColors.blue,
            radius: 35 / 2,
            child: Icon(widget.icon),
          ),
          Gap(7.w),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              MinusAndPlusIconButton(
                isPlus: false,
                onPressed: _decrease,
              ),
              Gap(7.w),
              Text(
                '$_count',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(7.w),
              MinusAndPlusIconButton(
                isPlus: true,
                onPressed: _increase,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MinusAndPlusIconButton extends StatelessWidget {
  const MinusAndPlusIconButton({
    super.key,
    required this.onPressed,
    required this.isPlus,
  });
  final void Function() onPressed;
  final bool isPlus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      height: 20.w,
      child: IconButton.filled(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            isPlus ? AppColors.blue : const Color.fromRGBO(30, 136, 229, 0.105),
          ),
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(
          isPlus ? Icons.add : Icons.remove,
          color: isPlus ? Colors.white : Colors.black,
          size: 15,
        ),
      ),
    );
  }
}

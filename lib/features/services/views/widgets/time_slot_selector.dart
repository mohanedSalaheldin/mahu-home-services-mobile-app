import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class TimeSlotSelector extends StatefulWidget {
  final Function(String, String) onAddSlot;
  final Function(int) onRemoveSlot;
  final List<Map<String, String>> existingSlots;

  const TimeSlotSelector({
    super.key,
    required this.onAddSlot,
    required this.onRemoveSlot,
    required this.existingSlots,
  });

  @override
  _TimeSlotSelectorState createState() => _TimeSlotSelectorState();
}

class _TimeSlotSelectorState extends State<TimeSlotSelector> {
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      print('$hour:$minute');
      controller.text = '$hour:$minute';
    }
  }

  InputDecoration _buildDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        height: 4,
        color: Colors.black.withOpacity(.5),
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
      ),
      filled: true,
      fillColor: AppColors.greyBack,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _startTimeController,
                readOnly: true,
                onTap: () => _selectTime(_startTimeController),
                decoration: _buildDecoration('Start Time'),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: TextFormField(
                controller: _endTimeController,
                readOnly: true,
                onTap: () => _selectTime(_endTimeController),
                decoration: _buildDecoration('End Time'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: () {
                if (_startTimeController.text.isNotEmpty &&
                    _endTimeController.text.isNotEmpty) {
                  widget.onAddSlot(
                    _startTimeController.text,
                    _endTimeController.text,
                  );
                  _startTimeController.clear();
                  _endTimeController.clear();
                }
              },
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (widget.existingSlots.isNotEmpty)
          ...widget.existingSlots.map((slot) {
            final index = widget.existingSlots.indexOf(slot);
            return ListTile(
              title: Text('${slot['startTime']} - ${slot['endTime']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => widget.onRemoveSlot(index),
              ),
            );
          }),
      ],
    );
  }
}

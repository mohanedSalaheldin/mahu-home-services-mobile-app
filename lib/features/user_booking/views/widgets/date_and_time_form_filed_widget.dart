import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/booking_form_screen.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class DateAndTimeFormFiledWidget extends StatefulWidget {
  DateAndTimeFormFiledWidget({
    super.key,
    required this.isDateNotTime,
  });

  final bool isDateNotTime;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  State<DateAndTimeFormFiledWidget> createState() =>
      _DateAndTimeFormFiledWidgetState();
}

class _DateAndTimeFormFiledWidgetState
    extends State<DateAndTimeFormFiledWidget> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isDateNotTime
              ? S.of(context).dateAndTimeFormFieldWidgetDateLabel
              : S.of(context).dateAndTimeFormFieldWidgetTimeLabel,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        TextFormField(
          controller: textEditingController,
          keyboardType: TextInputType.none,
          onTap: () async {
            widget.isDateNotTime
                ? await _selectDate(context)
                : await _selectTime(context);
          },
          decoration: InputDecoration(
            hintText: widget.isDateNotTime
                ? S.of(context).dateAndTimeFormFieldWidgetSelectDateHint
                : S.of(context).dateAndTimeFormFieldWidgetSelectTimeHint,
            suffixIcon: Icon(
              widget.isDateNotTime
                  ? Icons.calendar_today_outlined
                  : Icons.timelapse,
            ),
            hintStyle: TextStyle(
              height: 4,
              color: Colors.black.withOpacity(.5),
              fontWeight: FontWeight.w400,
              fontSize: 13,
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
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        textEditingController.text = DateFormat.yMd(
          Localizations.localeOf(context).languageCode,
        ).format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != widget.selectedTime) {
      setState(() {
        widget.selectedTime = picked;
        textEditingController.text = picked.format(context);
      });
    }
  }
}

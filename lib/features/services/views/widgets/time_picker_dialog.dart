import 'package:flutter/material.dart';

class TimePickerDialog extends StatefulWidget {
  const TimePickerDialog({super.key});

  @override
  _TimePickerDialogState createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _selectStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _startTime = picked);
    }
  }

  Future<void> _selectEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ??
          (_startTime ?? TimeOfDay.now())
              .replacing(hour: (_startTime ?? TimeOfDay.now()).hour + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _endTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Time Slot'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Start Time'),
            trailing: Text(
              _startTime?.format(context) ?? 'Not selected',
              style: const TextStyle(fontSize: 16),
            ),
            onTap: _selectStartTime,
          ),
          ListTile(
            title: const Text('End Time'),
            trailing: Text(
              _endTime?.format(context) ?? 'Not selected',
              style: const TextStyle(fontSize: 16),
            ),
            onTap: _selectEndTime,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _startTime != null && _endTime != null
              ? () => Navigator.pop(context, {
                    'startTime': _startTime!,
                    'endTime': _endTime!,
                  })
              : null,
          child: const Text('Add Slot'),
        ),
      ],
    );
  }
}

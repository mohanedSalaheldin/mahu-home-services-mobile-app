import 'package:flutter/material.dart';
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
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  hintText: 'HH:MM',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _endTimeController,
                decoration: InputDecoration(
                  labelText: 'End Time',
                  hintText: 'HH:MM',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: AppColors.primary),
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
        SizedBox(height: 8),
        if (widget.existingSlots.isNotEmpty)
          ...widget.existingSlots.map((slot) => ListTile(
            title: Text('${slot['startTime']} - ${slot['endTime']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => widget.onRemoveSlot(widget.existingSlots.indexOf(slot)),
            ),
          )).toList(),
      ],
    );
  }
}
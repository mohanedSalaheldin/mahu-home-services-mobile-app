import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/prototype/summary_screen.dart';

class AvailabilityScreen extends StatelessWidget {
  const AvailabilityScreen({super.key});

  Future<void> _pickTime(
      BuildContext context, void Function(TimeOfDay) onSelected) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      onSelected(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        final cubit = ServiceCubit.get(context);
        final availability = cubit.availability;

        return Scaffold(
          appBar: AppBar(title: const Text('Availability Schedule')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                ...availability.map((a) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: a.startTime != null && a.endTime != null,
                            onChanged: (selected) async {
                              if (selected == true) {
                                final start = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      const TimeOfDay(hour: 9, minute: 0),
                                );

                                if (start != null) {
                                  final end = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: start.hour + 1,
                                        minute: start.minute),
                                  );

                                  if (end != null) {
                                    cubit.setStartTime(a.day, start);
                                    cubit.setEndTime(a.day, end);
                                  }
                                }
                              } else {
                                cubit.setStartTime(a.day, null);
                                cubit.setEndTime(a.day, null);
                              }
                            },
                          ),
                          Text(a.day,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      if (a.startTime != null && a.endTime != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              TextButton.icon(
                                icon: const Icon(Icons.schedule),
                                label: Text(a.startTime!.format(context)),
                                onPressed: () => _pickTime(context, (time) {
                                  cubit.setStartTime(a.day, time);
                                }),
                              ),
                              const Text("to"),
                              TextButton.icon(
                                icon: const Icon(Icons.schedule_outlined),
                                label: Text(a.endTime!.format(context)),
                                onPressed: () => _pickTime(context, (time) {
                                  cubit.setEndTime(a.day, time);
                                }),
                              ),
                            ],
                          ),
                        ),
                      const Divider()
                    ],
                  );
                }),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: availability
                          .any((a) => a.startTime != null && a.endTime != null)
                      ? () {
                          // Navigate or Submit
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SummaryScreen(),
                              )); // next screen
                        }
                      : null,
                  child: const Text("Next"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

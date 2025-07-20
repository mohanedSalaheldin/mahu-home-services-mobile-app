import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/prototype/availability_screen.dart';

class SelectCoverageAreaScreen extends StatefulWidget {
  const SelectCoverageAreaScreen({super.key});

  @override
  State<SelectCoverageAreaScreen> createState() =>
      _SelectCoverageAreaScreenState();
}

class _SelectCoverageAreaScreenState extends State<SelectCoverageAreaScreen> {
  final TextEditingController _manualAreaController = TextEditingController();

  final List<String> uaeCities = [
    "Abu Dhabi",
    "Dubai",
    "Sharjah",
    "Ajman",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        final cubit = ServiceCubit.get(context);
        final selectedAreas = cubit.selectedAreas;

        return Scaffold(
          appBar: AppBar(title: const Text("Select Coverage Areas")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select Cities/Areas",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: uaeCities.length,
                    itemBuilder: (context, index) {
                      final city = uaeCities[index];
                      final isSelected = selectedAreas.contains(city);
                      return CheckboxListTile(
                        title: Text(city),
                        value: isSelected,
                        onChanged: (val) {
                          if (val == true) {
                            cubit.addArea(city);
                          } else {
                            cubit.removeArea(city);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Add Custom Area (Optional)"),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _manualAreaController,
                        decoration: const InputDecoration(
                          hintText: "Enter area name",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_location_alt),
                      onPressed: () {
                        final area = _manualAreaController.text.trim();
                        if (area.isNotEmpty) {
                          cubit.addArea(area);
                          _manualAreaController.clear();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: selectedAreas
                      .map((area) => Chip(
                            label: Text(area),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => cubit.removeArea(area),
                          ))
                      .toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
          floatingActionButton: ElevatedButton(
            onPressed: selectedAreas.isNotEmpty
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AvailabilityScreen(),
                        ));
                  }
                : null,
            child: const Text("Next"),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/enter_service_details_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_sub_type_screen.dart';

import '../../models/service_type.dart';

class SelectServiceTypeScreen extends StatelessWidget {
  const SelectServiceTypeScreen({super.key});

  void _proceed(BuildContext context) {
    final selected = context.read<ServiceCubit>().state;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceSubTypeScreen(
            serviceType: context.read<ServiceCubit>().serviceType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Type")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Choose a service type:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: ServiceType.values.map((type) {
                  return BlocBuilder<ServiceCubit, ServiceState>(
                    builder: (context, state) {
                      var cubit = ServiceCubit.get(context);
                      final isSelected = cubit.serviceType == type;
                      return Card(
                        color: isSelected ? Colors.blue[100] : null,
                        child: ListTile(
                          title: Text(type.displayName),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                          onTap: () {
                            context.read<ServiceCubit>().serviceType = type;
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => _proceed(context),
        child: const Text("Next"),
      ),
    );
  }
}


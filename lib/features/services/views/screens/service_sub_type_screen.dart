import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/models/service_type.dart';
import 'package:mahu_home_services_app/features/services/views/screens/choose_pricing_model_screen.dart';

import '../../cubit/servises_state.dart';

class ServiceSubTypeScreen extends StatelessWidget {
  const ServiceSubTypeScreen({super.key, required this.serviceType});
  final ServiceType serviceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service subtypes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Choose a service subtypes:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: ServiceSubType.values.map((subType) {
                  return BlocBuilder<ServiceCubit, ServiceState>(
                    builder: (context, state) {
                      var cubit = ServiceCubit.get(context);
                      final isSelected = cubit.serviceSubType == subType;
                      return Card(
                        color: isSelected ? Colors.blue[100] : null,
                        child: ListTile(
                          title: Text(subType.displayName),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                          onTap: () {
                            context.read<ServiceCubit>().serviceSubType =
                                (subType);
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => _proceed(context),
        child: const Text("Next"),
      ),
    );
  }

  void _proceed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChoosePricingModelScreen(),
      ),
    );
  }
}

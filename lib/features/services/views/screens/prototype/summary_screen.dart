import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        final cubit = ServiceCubit.get(context);

        return Scaffold(
          appBar: AppBar(title: const Text("Service Summary")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SummaryItem(title: "Service Name", value: cubit.serviceName),
                SummaryItem(title: "Description", value: cubit.description),
                SummaryItem(
                    title: "Service Type", value: cubit.serviceType.name),
                SummaryItem(
                    title: "Sub Type", value: cubit.serviceSubType.name),
                SummaryItem(
                    title: "Pricing Model", value: cubit.pricingModel.name),
                if (cubit.pricingModel.name == 'fixed')
                  SummaryItem(
                      title: "Base Price", value: '${cubit.basePrice} AED'),
                if (cubit.pricingModel.name == 'photo')
                  SummaryItem(
                      title: "Price Instruction",
                      value: cubit.priceInstructions ?? ''),
                SummaryItem(
                    title: "Duration", value: '${cubit.duration} minutes'),
                SummaryItem(title: "Category", value: cubit.category),
                SummaryItem(
                    title: "Coverage Areas",
                    value: cubit.selectedAreas.join(", ")),
                const SizedBox(height: 10),
                const Text("Availability",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...cubit.availability
                    .where((a) => a.startTime != null && a.endTime != null)
                    .map((a) => Text(
                          '${a.day}: ${a.startTime!.format(context)} - ${a.endTime!.format(context)}',
                        )),
                const SizedBox(height: 16),
                if (cubit.imageUrl.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Service Image",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Image.network(cubit.imageUrl, height: 180),
                    ],
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Save service to backend or Firebase
                    // Then navigate to success screen
                    // Example: cubit.saveService();
                  },
                  child: const Text("Confirm & Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const SummaryItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 140,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

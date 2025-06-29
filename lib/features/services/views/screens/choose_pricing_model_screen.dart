import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_type.dart';
import 'package:mahu_home_services_app/features/services/views/screens/enter_service_details_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/select_coverage_area_screen.dart';

class ChoosePricingModelScreen extends StatelessWidget {
  const ChoosePricingModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        final cubit = ServiceCubit.get(context);
        final selectedModel = cubit.pricingModel;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Choose Pricing Model"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildOptionCard(
                  context: context,
                  title: "Fixed Price",
                  description: "Client sees the price directly before booking.",
                  selected: selectedModel == PricingModel.fixed,
                  onTap: () {
                    cubit.pricingModel = PricingModel.fixed;
                  },
                ),
                const SizedBox(height: 12),
                _buildOptionCard(
                  context: context,
                  title: "Based on Photos",
                  description:
                      "Client uploads photos. You send the final price later.",
                  selected: selectedModel == PricingModel.photoBased,
                  onTap: () {
                    cubit.pricingModel = PricingModel.photoBased;
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EnterServiceDetailsScreen(),
                  ));
            },
            child: const Text("Next"),
          ),
        );
      },
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String title,
    required String description,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: selected ? Theme.of(context).primaryColorLight : Colors.white,
        elevation: selected ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? Theme.of(context).primaryColor : Colors.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: selected
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        )),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

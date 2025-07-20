import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/services/views/screens/add_service_screen.dart';

import '../../models/service_model.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateTo(context, const AddServiceScreen());
        },
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        backgroundColor: AppColors.blue, // اختياري
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) =>
              ServicesCard(service: services[index]),
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: services.length,
        ),
      ),
    );
  }
}

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    super.key,
    required this.service,
  });
  final Service service;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // <-- نصف القطر
        ),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              service.imgUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    service.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                      ),
                      const Gap(5),
                      Text(
                        '${service.availableAreas[0]}, ${service.availableAreas[1]}...',
                        // style: ,
                      ),
                      const Spacer(),
                      Text(
                        '\$ ${service.basePrice}/Hr',
                        style: const TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        // style: ,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const sharedImageUrl =
    'https://realpristinesolutions.com/wp-content/uploads/2024/04/deep-clean.jpeg';

List<Service> services = [
  Service(
    name: 'Deep Cleaning',
    description: 'Thorough cleaning service',
    category: 'cleaning',
    serviceType: 'one-time',
    subType: 'deep',
    basePrice: 150.0,
    duration: 240,
    pricingModel: 'fixed',
    imgUrl: sharedImageUrl,
    availableAreas: ['Cairo', 'Giza', 'Alexandria'],
  ),
  Service(
    name: 'Regular Cleaning',
    description: 'Weekly cleaning for your home',
    category: 'cleaning',
    serviceType: 'recurring',
    subType: 'regular',
    basePrice: 100.0,
    duration: 120,
    pricingModel: 'fixed',
    imgUrl: sharedImageUrl,
    availableAreas: ['Cairo', '6th October'],
  ),
  Service(
    name: 'Window Washing',
    description: 'Sparkling clean windows guaranteed',
    category: 'cleaning',
    serviceType: 'one-time',
    subType: 'windows',
    basePrice: 80.0,
    duration: 90,
    pricingModel: 'fixed',
    imgUrl: sharedImageUrl,
    availableAreas: ['Alexandria', 'Mansoura'],
  ),
];

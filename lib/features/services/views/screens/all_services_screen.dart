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
  final ServiceModel service;

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
              service.image,
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
                      const Text(
                        'Location: ',
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

List<ServiceModel> services = [
  ServiceModel(
    id: '1',
    name: 'Deep Cleaning',
    description: 'Comprehensive cleaning service for your home.',
    category: 'Cleaning',
    serviceType: 'Residential',
    subType: 'Deep Clean',
    basePrice: 150,
    pricingModel: 'Hourly',
    duration: 3,
    image: sharedImageUrl,
    active: true,
    provider: 'Mahu Home Services',
    isApproved: true,
    createdAt: DateTime.now(),
    v: 0,
    availableDays: ['Monday', 'Wednesday', 'Friday'],
    availableSlots: [
      TimeSlot(startTime: '09:00', endTime: '12:00', id: '1'),
      TimeSlot(startTime: '13:00', endTime: '16:00', id: '2'),
    ],
  ),
  ServiceModel(
    id: '2',
    name: 'Gardening',
    description: 'Professional gardening services for your yard.',
    category: 'Gardening',
    serviceType: 'Residential',
    subType: 'Maintenance',
    basePrice: 100,
    pricingModel: 'Flat Rate',
    duration: 2,
    image: sharedImageUrl,
    active: true,
    provider: 'Mahu Home Services',
    isApproved: true,
    createdAt: DateTime.now(),
    availableSlots: [
      TimeSlot(startTime: '10:00', endTime: '12:00', id: '1'),
      TimeSlot(startTime: '14:00', endTime: '16:00', id: '2'),
    ],
    v: 0,
    availableDays: ['Tuesday', 'Thursday'],
    // removed duplicate availableSlots string list
  ),
  ServiceModel(
    id: '3',
    name: 'Plumbing',
    description: 'Expert plumbing services for all your needs.',
    category: 'Plumbing',
    serviceType: 'Residential',
    subType: 'Repair',
    basePrice: 80,
    pricingModel: 'Hourly',
    duration: 1,
    image: sharedImageUrl,
    active: true,
    availableSlots: [
      TimeSlot(startTime: '08:00', endTime: '10:00', id: '1'),
      TimeSlot(startTime: '15:00', endTime: '17:00', id: '2'),
    ],
    provider: 'Mahu Home Services',
    isApproved: true,
    createdAt: DateTime.now(),
    v: 0,
    availableDays: ['Saturday', 'Sunday'],
    // removed duplicate availableSlots string list
  ),
];

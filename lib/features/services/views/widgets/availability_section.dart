import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';

class AvailabilitySection extends StatelessWidget {
  final ServiceModel service;

  const AvailabilitySection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Areas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Gap(8.h),
        // if (service.availableAreas.isEmpty)
        //   Text(
        //     'No specific areas specified',
        //     style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        //   )
        // else
        //   Wrap(
        //     spacing: 8.w,
        //     runSpacing: 8.h,
        //     children: service.availableAreas.map((area) {
        //       return Chip(
        //         label: Text(area),
        //         backgroundColor: Colors.blue.shade50,
        //       );
        //     }).toList(),
        //   ),
      ],
    );
  }
}

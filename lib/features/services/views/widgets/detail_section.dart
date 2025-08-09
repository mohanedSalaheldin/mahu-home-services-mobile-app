import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_details_screen.dart';

class DetailSection extends StatelessWidget {
  final ServiceModel service;

  const DetailSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Details',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        Gap(16.h),
        DetailRow(label: "Category", value: service.category),
        DetailRow(label: "Service Type", value: service.serviceType),
        DetailRow(label: "Sub-Type", value: service.subType),
        DetailRow(label: "Pricing Model", value: service.pricingModel),
        DetailRow(
            label: "Price", value: '\$${service.basePrice.toStringAsFixed(2)}'),
        DetailRow(
          label: "Duration",
          value:
              "${service.duration ~/ 60} hours ${service.duration % 60} minutes",
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

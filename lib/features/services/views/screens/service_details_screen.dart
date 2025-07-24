import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../models/service_model.dart';
class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Service Details"),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Image
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: NetworkImage(service.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(24.h),

            // Service Name and Basic Info
            Text(
              service.name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h),
            Text(
              service.description,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
            Gap(24.h),

            // Service Details Section
            _buildDetailSection(context),
            Gap(24.h),

            // Availability Section
            _buildAvailabilitySection(),
            Gap(24.h),

            // Action Buttons
            _buildActionButtons(context),
            Gap(32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Details',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        _buildDetailRow("Category", service.category),
        _buildDetailRow("Service Type", service.serviceType),
        _buildDetailRow("Sub-Type", service.subType),
        _buildDetailRow("Pricing Model", service.pricingModel),
        _buildDetailRow("Price", '\$${service.basePrice.toStringAsFixed(2)}'),
        _buildDetailRow(
          "Duration", 
          "${service.duration ~/ 60} hours ${service.duration % 60} minutes"
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Areas',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(8.h),
        // if (service.availableAreas.isEmpty)
        //   Text(
        //     'No specific areas specified',
        //     style: TextStyle(
        //       fontSize: 16.sp,
        //       color: Colors.grey.shade600,
        //     ),
        //   ),
        // if (service.availableAreas.isNotEmpty)
        //   Wrap(
        //     spacing: 8.w,
        //     runSpacing: 8.h,
        //     children: service.availableAreas
        //         .map((area) => Chip(
        //               label: Text(area),
        //               backgroundColor: Colors.blue.shade50,
        //             ))
        //         .toList(),
        //   ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(color: Colors.red.shade200),
              ),
            ),
            onPressed: () => _showDeleteConfirmation(context),
            child: Text(
              "Delete Service",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => _navigateToEditScreen(context),
            child: Text(
              "Edit Service",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text(
            "Are you sure you want to delete this service? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Service deleted successfully")),
              );
              Navigator.pop(context); // Go back to previous screen
            },
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    // TODO: Implement navigation to edit screen
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => EditServiceScreen(service: service),
    // ));
  }
}



// Extension for String capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Information Section
            _buildClientSection(),
            Gap(24.h),
            Divider(height: 1.h, color: Colors.grey.shade300),
            Gap(24.h),

            // Service Details Section
            _buildSectionTitle("Service Details"),
            Gap(16.h),
            _buildDetailItem("Service", booking.serviceName),
            _buildDetailItem("Date & Time", 
              DateFormat('MMMM d, yyyy, h:mm a').format(booking.date)),
            _buildStatusItem(booking.status),
            _buildDetailItem("Address", booking.address),
            Gap(24.h),
            Divider(height: 1.h, color: Colors.grey.shade300),
            Gap(24.h),

            // Payment Section
            _buildSectionTitle("Payment"),
            Gap(16.h),
            _buildDetailItem("Total Amount", "\$${booking.amount}"),
            _buildPaymentStatusItem(booking.paymentStatus),
            Gap(24.h),
            Divider(height: 1.h, color: Colors.grey.shade300),
            Gap(24.h),

            // Action Buttons
            _buildActionButtons(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildClientSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.blue.withOpacity(0.1),
          child: Icon(
            Icons.person,
            size: 30.sp,
            color: AppColors.blue,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.clientName,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(4.h),
              Text(
                "Client",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              Gap(8.h),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Gap(4.w),
                  Text(
                    "${booking.rating} - ${booking.reviews} reviews",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'confirmed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 14.sp,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatusItem(String status) {
    Color statusColor;
    String statusText;
    
    switch (status.toLowerCase()) {
      case 'paid':
        statusColor = Colors.green;
        statusText = 'Paid';
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusText = 'Pending';
        break;
      case 'failed':
        statusColor = Colors.red;
        statusText = 'Failed';
        break;
      default:
        statusColor = Colors.grey;
        statusText = status;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Status",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(4.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (status.toLowerCase() == 'pending') ...[
                Gap(8.w),
                Icon(Icons.payment, size: 18.sp, color: Colors.blue),
                Gap(4.w),
                Text(
                  "Request Payment",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              backgroundColor: AppColors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Handle message action
            },
            child: Text(
              "Message Client",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Gap(12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              side: BorderSide(color: AppColors.blue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Handle start job action
              if (booking.status.toLowerCase() == 'confirmed') {
                _showStartJobDialog(context);
              }
            },
            child: Text(
              "Start Job",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showStartJobDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Start Service",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        content: Text(
          "Are you ready to start the ${booking.serviceName} service for ${booking.clientName}?",
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Update booking status and proceed
            },
            child: const Text("Start Now", style: TextStyle(color: AppColors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 2, // Calendar is selected
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}

class Booking {
  final String serviceName;
  final String clientName;
  final double rating;
  final int reviews;
  final String address;
  final DateTime date;
  final String status;
  final String paymentStatus;
  final double amount;

  Booking({
    required this.serviceName,
    required this.clientName,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.date,
    this.status = 'Confirmed',
    this.paymentStatus = 'Paid',
    this.amount = 100.00,
  });
}
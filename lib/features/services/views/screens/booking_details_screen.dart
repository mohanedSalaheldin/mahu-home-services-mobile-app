import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../../cubit/services_cubit.dart';

class BookingDetailsScreen extends StatefulWidget {
  final Booking booking;
  const BookingDetailsScreen({super.key, required this.booking});
  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  latlng.LatLng? _serviceLocation;
  bool _isMapLoading = true;
  String? _mapError;

  @override
  void initState() {
    super.initState();
    _convertAddressToLatLng();
  }

  Future<void> _convertAddressToLatLng() async {
    try {
      final address = "${widget.booking.address}, Egypt";
      final locations = await geo.locationFromAddress(address);

      if (locations.isNotEmpty) {
        setState(() {
          _serviceLocation = latlng.LatLng(
              locations.first.latitude, locations.first.longitude);
          _isMapLoading = false;
          _mapError = null;
        });
      } else {
        setState(() {
          _mapError = "Could not determine location";
          _serviceLocation =
              const latlng.LatLng(30.0444, 31.2357); // Cairo fallback
          _isMapLoading = false;
        });
      }
    } catch (e) {
      print("Error converting address: $e");
      setState(() {
        _mapError = "Location service unavailable";
        _serviceLocation =
            const latlng.LatLng(30.0444, 31.2357); // Cairo fallback
        _isMapLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            Gap(24.h),
            _buildClientInfoSection(),
            Gap(24.h),
            _buildServiceDetailsSection(),
            Gap(24.h),
            _buildPaymentSection(),
            Gap(24.h),

            // Add the Map Section
            _buildMapSection(),
            Gap(24.h),

            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.booking.serviceName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gap(8.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: _getStatusColor(widget.booking.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.booking.status,
                style: TextStyle(
                  fontSize: 12,
                  color: _getStatusColor(widget.booking.status),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Gap(8.w),
            if (widget.booking.rating > 0)
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Gap(4.w),
                  Text(
                    "${widget.booking.rating} (${widget.booking.reviews} reviews)",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMapSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Location",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(16.h),
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _isMapLoading
                  ? Center(child: CircularProgressIndicator(
                color: Colors.blue
              ))
                  : _mapError != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.red),
                              Gap(8.h),
                              Text(
                                _mapError!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )
                      : FlutterMap(
                          options: MapOptions(
                            initialCenter: _serviceLocation!,
                            initialZoom: 13.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 40.0,
                                  height: 40.0,
                                  point: _serviceLocation!,
                                  child: const Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
            ),
          ),
          if (_mapError != null) Gap(12.h),
          if (_mapError != null)
            Text(
              "Showing approximate location",
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange,
              ),
            ),
          Gap(12.h),
          Text(
            widget.booking.address,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Information",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(16.h),
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.blue,
                  size: 24,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.booking.clientName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      "Client since ${DateFormat('MMM yyyy').format(DateTime.now().subtract(const Duration(days: 90)))}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(16.h),
          Divider(color: Colors.grey.shade200, height: 1),
          Gap(16.h),
          _buildInfoRow(
            icon: Icons.phone,
            title: "Phone Number",
            value: "Tap to call",
            isClickable: true,
            onTap: () {
              // Implement call functionality
            },
          ),
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.email,
            title: "Email Address",
            value: "Tap to email",
            isClickable: true,
            onTap: () {
              // Implement email functionality
            },
          ),
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.location_on,
            title: "Service Address",
            value: widget.booking.address,
            isClickable: false,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetailsSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(16.h),
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: "Date & Time",
            value:
                DateFormat('MMM d, yyyy • h:mm a').format(widget.booking.date),
            isClickable: false,
          ),
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.access_time,
            title: "Duration",
            value:
                "2 hours (estimated)", // You might want to add duration to your Booking model
            isClickable: false,
          ),
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.description,
            title: "Special Instructions",
            value: widget.booking.details ?? "No special instructions",
            isClickable: false,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Service Fee",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                "\$${widget.booking.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                "\$${(widget.booking.amount * 0.1).toStringAsFixed(2)}", // Assuming 10% tax
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Divider(color: Colors.grey.shade200, height: 1),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "\$${(widget.booking.amount * 1.1).toStringAsFixed(2)}", // Total with tax
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Status",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getPaymentStatusColor(widget.booking.paymentStatus)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.booking.paymentStatus,
                  style: TextStyle(
                    fontSize: 12,
                    color: _getPaymentStatusColor(widget.booking.paymentStatus),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: const BorderSide(color: AppColors.blue),
                ),
                onPressed: () {
                  _showContactOptions(context);
                },
                child: const Text(
                  "Contact Client",
                  style: TextStyle(color: AppColors.blue),
                ),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  backgroundColor: _getActionButtonColor(widget.booking.status),
                ),
                onPressed: () {
                  _handleStatusAction(context);
                },
                child: Text(
                  _getActionButtonText(widget.booking.status),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        if (widget.booking.status.toLowerCase() != 'completed' &&
            widget.booking.status.toLowerCase() != 'cancelled')
          Gap(12.h),
        if (widget.booking.status.toLowerCase() != 'completed' &&
            widget.booking.status.toLowerCase() != 'cancelled')
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                side: BorderSide(color: Colors.red.shade400),
              ),
              onPressed: () {
                _showCancelDialog(context);
              },
              child: Text(
                "Cancel Booking",
                style: TextStyle(color: Colors.red.shade400),
              ),
            ),
          ),
      ],
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String title, String message, String newStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Update the booking status in the cubit
              context
                  .read<ServiceCubit>()
                  .changeBookingStatus(widget.booking.id, newStatus);
              // Update local state for UI
              setState(() {
                widget.booking.status = newStatus;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Booking status updated to ${_formatStatus(newStatus)}'),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text(
            'Are you sure you want to cancel this booking? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Update the booking status in the cubit
              context
                  .read<ServiceCubit>()
                  .changeBookingStatus(widget.booking.id, 'cancelled');
              // Update local state for UI
              setState(() {
                widget.booking.status = 'cancelled';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking has been cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
              // Navigate back after cancellation
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            },
            child: const Text('Cancel Booking',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required bool isClickable,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isClickable ? onTap : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.grey.shade500,
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isClickable ? FontWeight.w600 : FontWeight.normal,
                      color: isClickable ? AppColors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (isClickable)
              Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey.shade400,
              ),
          ],
        ),
      ),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Contact Client",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(16.h),
            ListTile(
              leading: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
              ),
              title: const Text('Call Client'),
              subtitle: const Text('Initiate a phone call'),
              onTap: () {
                Navigator.pop(context);
                // Implement call functionality
              },
            ),
            ListTile(
              leading: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.message,
                  color: Colors.blue,
                ),
              ),
              title: const Text('Send Message'),
              subtitle: const Text('Send SMS or WhatsApp message'),
              onTap: () {
                Navigator.pop(context);
                // Implement messaging functionality
              },
            ),
            ListTile(
              leading: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
              ),
              title: const Text('Send Email'),
              subtitle: const Text('Compose an email'),
              onTap: () {
                Navigator.pop(context);
                // Implement email functionality
              },
            ),
            Gap(16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
            Gap(8.h),
          ],
        ),
      ),
    );
  }

  void _handleStatusAction(BuildContext context) {
    switch (widget.booking.status.toLowerCase()) {
      case 'pending':
        _showConfirmationDialog(context, 'Confirm Booking',
            'Are you sure you want to confirm this booking?', 'confirmed');
        break;
      case 'confirmed':
        _showConfirmationDialog(context, 'Start Job',
            'Are you ready to start this job?', 'in-progress');
        break;
      case 'in-progress':
        _showConfirmationDialog(context, 'Complete Job',
            'Have you completed all the work?', 'completed');
        break;
      case 'completed':
        // Already handled by viewing details
        break;
      default:
        break;
    }
  }

  // Helper methods (same as in your original code)
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return AppColors.blue;
      case 'in-progress':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getPaymentStatusColor(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getActionButtonColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return AppColors.blue;
      case 'in-progress':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.grey;
      default:
        return AppColors.blue;
    }
  }

  String _getActionButtonText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Confirm Booking';
      case 'confirmed':
        return 'Start Job';
      case 'in-progress':
        return 'Mark as Completed';
      case 'completed':
        return 'View Receipt';
      case 'cancelled':
        return 'Reschedule';
      default:
        return 'Action';
    }
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'in-progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }
}

class Booking {
  final String id;
  final String serviceName;
  final String clientName;
  final double rating;
  final int reviews;
  final String address;
  final String details;
  final DateTime date;
  String status;
  final String paymentStatus;
  final double amount;

  Booking({
    required this.id, // Add this
    required this.serviceName,
    required this.clientName,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.date,
    required this.status,
    required this.paymentStatus,
    required this.amount,
    this.details = '',
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:url_launcher/url_launcher.dart';

import '../../cubit/services_cubit.dart';
import '../../models/booking_model.dart'; // Import your updated BookingModel

class BookingDetailsScreen extends StatefulWidget {
  final BookingModel booking;
  const BookingDetailsScreen({super.key, required this.booking});
  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  latlng.LatLng? _serviceLocation;
  bool _isMapLoading = true;
  String? _mapError;
  final MapController _mapController = MapController();
  String? _detectedCountry;

  @override
  void initState() {
    super.initState();
    _determineLocation();
  }

  Future<void> _determineLocation() async {
    try {
      // Use coordinates from address
      if (widget.booking.address.coordinates.isNotEmpty &&
          widget.booking.address.coordinates.length >= 2) {
        _setLocationWithCoordinates();
        return;
      }

      // If coordinates not available, try to geocode the address
      await _geocodeAddress();
    } catch (e) {
      print("Error determining location: $e");
      _setFallbackLocation();
    }
  }

  void _setLocationWithCoordinates() {
    setState(() {
      _serviceLocation = latlng.LatLng(
        widget.booking.address.coordinates[1], // latitude
        widget.booking.address.coordinates[0], // longitude
      );
      _detectedCountry = widget.booking.address.state;
      _isMapLoading = false;
    });
  }

  Future<void> _geocodeAddress() async {
    try {
      final address = _getFullAddress();
      final locations = await geo.locationFromAddress(address);

      if (locations.isNotEmpty) {
        final location = locations.first;

        // Reverse geocode to get country information
        final places = await geo.placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        final country = places.isNotEmpty ? places.first.country : null;

        setState(() {
          _serviceLocation = latlng.LatLng(
            location.latitude,
            location.longitude,
          );
          _detectedCountry = country;
          _isMapLoading = false;
          _mapError = null;
        });
      } else {
        _setFallbackLocation();
      }
    } catch (e) {
      print("Geocoding error: $e");
      _setFallbackLocation();
    }
  }

  String _getFullAddress() {
    return '${widget.booking.address.street}, ${widget.booking.address.city}, ${widget.booking.address.state} ${widget.booking.address.zipCode}';
  }

  void _setFallbackLocation() {
    // Determine fallback based on booking state or default to Egypt
    final fallbackState = widget.booking.address.state?.toLowerCase();
    latlng.LatLng fallbackLocation;

    if (fallbackState == 'dubai' || fallbackState == 'uae') {
      fallbackLocation = const latlng.LatLng(25.276987, 55.296249); // Dubai
      _detectedCountry = 'UAE';
    } else {
      fallbackLocation = const latlng.LatLng(30.0444, 31.2357); // Cairo
      _detectedCountry = 'Egypt';
    }

    setState(() {
      _serviceLocation = fallbackLocation;
      _isMapLoading = false;
      _mapError = "Showing approximate location";
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  Future<void> _openMapsApp() async {
    if (_serviceLocation == null) return;

    final String mapsUrl;
    final country = _detectedCountry?.toLowerCase();

    if (country == 'uae' || country == 'united arab emirates') {
      mapsUrl =
          'https://www.google.com/maps/dir/?api=1&destination=${_serviceLocation!.latitude},${_serviceLocation!.longitude}&travelmode=driving';
    } else {
      mapsUrl =
          'https://www.google.com/maps/dir/?api=1&destination=${_serviceLocation!.latitude},${_serviceLocation!.longitude}&travelmode=driving';
    }

    final uri = Uri.parse(mapsUrl);

    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open maps app')),
      );
    }
  }

  String _getMapProviderUrl() {
    final country = _detectedCountry?.toLowerCase();

    if (country == 'uae' || country == 'united arab emirates') {
      return 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    } else {
      return 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
    }
  }

  double _getInitialZoom() {
    final country = _detectedCountry?.toLowerCase();

    if (country == 'uae' || country == 'united arab emirates') {
      return 12.0;
    } else {
      return 10.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
            _buildMapSection(),
            Gap(24.h),
            _buildPaymentSection(),
            Gap(24.h),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "📍 Service Location",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
              IconButton(
                icon: Icon(Icons.directions, color: AppColors.primary),
                onPressed: _openMapsApp,
                tooltip: 'Open in Maps',
              ),
            ],
          ),
          Gap(12.h),
          Container(
            height: 250.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _isMapLoading
                  ? _buildLoadingState()
                  : _serviceLocation == null
                      ? _buildErrorState()
                      : _buildMapContent(),
            ),
          ),
          if (_mapError != null) ...[
            Gap(12.h),
            _buildWarningMessage(),
          ],
          Gap(16.h),
          _buildAddressInfo(),
          Gap(12.h),
          _buildDirectionsButton(),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
          Gap(12.h),
          Text(
            'Loading map...',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 40),
          Gap(8.h),
          Text(
            'Location not available',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildMapContent() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _serviceLocation!,
            initialZoom: _getInitialZoom(),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: _getMapProviderUrl(),
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.mahu_home_services_app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 50.w,
                  height: 50.h,
                  point: _serviceLocation!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.white,
                      size: 30.w,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 12.h,
          right: 12.w,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            onPressed: () {
              _mapController.move(_serviceLocation!, _getInitialZoom());
            },
            child: Icon(Icons.my_location, color: AppColors.primary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber, color: Colors.orange.shade600, size: 16),
          Gap(8.w),
          Expanded(
            child: Text(
              _mapError!,
              style: TextStyle(
                color: Colors.orange.shade800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade600, size: 16),
          Gap(8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_detectedCountry != null)
                  Text(
                    'Location: $_detectedCountry',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(
                  _getFullAddress(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionsButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(Icons.directions, size: 20),
        label: Text('Get Directions'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: _openMapsApp,
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.booking.service.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          Gap(12.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color:
                      _getStatusColor(widget.booking.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.booking.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor(widget.booking.status),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Gap(8.w),
              if (widget.booking.service.averageRating > 0)
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    Gap(4.w),
                    Text(
                      "${widget.booking.service.averageRating}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "👤 Client Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          Gap(16.h),
          Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.primary.withOpacity(0.1),
                    ],
                  ),
                ),
                child: widget.booking.user.profile.avatar != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(28.w),
                        child: Image.network(
                          widget.booking.user.profile.avatar!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 28,
                      ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.booking.user.profile.firstName} ${widget.booking.user.profile.lastName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Gap(4.h),
                    if (widget.booking.service.averageRating > 0)
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Gap(4.w),
                          Text(
                            "${widget.booking.service.averageRating} (${widget.booking.service.totalReviews} reviews)",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          Gap(20.h),
          const Divider(color: Colors.grey, height: 1),
          Gap(16.h),
          _buildInfoRow(
            icon: Icons.phone,
            title: "Phone Number",
            value: widget.booking.user.phone,
            isClickable: true,
            onTap: () => _makePhoneCall(widget.booking.user.phone),
          ),
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.email,
            title: "Email",
            value: widget.booking.user.email,
            isClickable: true,
            onTap: () => _launchEmail(widget.booking.user.email),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch email');
    }
  }

  Widget _buildServiceDetailsSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🛠️ Service Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          Gap(16.h),
          if (widget.booking.schedule?.startDate != null)
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: "Scheduled Date",
            value: DateFormat('MMM d, yyyy')
                .format(widget.booking.schedule!.startDate ?? DateTime.now()),
            isClickable: false,
          ),
          if (widget.booking.schedule?.startTime != null && widget.booking.schedule?.endTime != null) ...[
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.access_time,
            title: "Time Slot",
            value:
                '${widget.booking.schedule!.startTime} - ${widget.booking.schedule!.endTime}',
            isClickable: false,
          ),
          ],
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.timer,
            title: "Duration",
            value: "${widget.booking.duration / 60} hours",
            isClickable: false,
          ),
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.description,
            title: "Service Description",
            value: widget.booking.service.description,
            isClickable: false,
          ),
          if (widget.booking.details != null &&
              widget.booking.details!.isNotEmpty) ...[
            Gap(12.h),
            _buildInfoRow(
              icon: Icons.note,
              title: "Special Instructions",
              value: widget.booking.details!,
              isClickable: false,
            ),
          ],
          Gap(12.h),
          _buildInfoRow(
            icon: Icons.build,
            title: "Tools Required",
            value: widget.booking.option.hasTools
                ? "Client has tools"
                : "Bring your own tools",
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "💰 Payment Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
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
                "\$${widget.booking.price.toStringAsFixed(2)}",
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
              const Text(
                "\$0.00",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(12.h),
          const Divider(color: Colors.grey, height: 1),
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
                "\$${widget.booking.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
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
                  widget.booking.paymentStatus.toUpperCase(),
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

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required bool isClickable,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isClickable ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: isClickable
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: isClickable ? AppColors.primary : Colors.grey.shade600,
              ),
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isClickable ? FontWeight.w600 : FontWeight.normal,
                      color: isClickable
                          ? AppColors.primary
                          : Colors.grey.shade800,
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
              context
                  .read<ServiceCubit>()
                  .changeBookingStatus(widget.booking.id, newStatus);
              // Update the booking status locally
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
              context
                  .read<ServiceCubit>()
                  .changeBookingStatus(widget.booking.id, 'cancelled');
              setState(() {
                widget.booking.status = 'cancelled';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking has been cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
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
        break;
      default:
        break;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return AppColors.primary;
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
        return AppColors.primary;
      case 'in-progress':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.grey;
      default:
        return AppColors.primary;
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/views/screens/booking_details_screen.dart'
as booking_details;

// ---------------------------- MAIN SCREEN ----------------------------

class ServiceProviderJobsScreen extends StatefulWidget {
  const ServiceProviderJobsScreen({super.key});

  @override
  State<ServiceProviderJobsScreen> createState() => _ServiceProviderJobsScreenState();
}

class _ServiceProviderJobsScreenState extends State<ServiceProviderJobsScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'All';

  List<BookingModel> _getFilteredBookings(List<BookingModel> bookings) {
    return bookings.where((booking) {
      final dateMatch = booking.createdAt.isSameDate(_selectedDate);
      if (_selectedFilter == 'All') return dateMatch;
      return dateMatch &&
          booking.status.toLowerCase() == _selectedFilter.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ServiceCubit>().fetchMyBookings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        actions: [_buildFilterButton()],
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetMyBookingsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMyBookingsFailedState) {
            return Center(
              child: Text(
                state.failure.msg,
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          }

          var cubit = ServiceCubit.get(context);
          final filteredBookings = _getFilteredBookings(cubit.myBooking);

          return Column(
            children: [
              DateSelectorWidget(
                onDateSelected: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
                initialSelectedDate: _selectedDate,
              ),

              _buildStatsOverview(cubit.myBooking),

              Expanded(
                child: filteredBookings.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: filteredBookings.length,
                  separatorBuilder: (_, __) => Gap(16.h),
                  itemBuilder: (_, index) {
                    BookingModel bookingModel = filteredBookings[index];
                    return _buildBookingCard(
                      Booking(
                        schedule: bookingModel.schedule,
                        id: bookingModel.id,
                        serviceName: bookingModel.service.name,
                        serviceType: bookingModel.service.serviceType,
                        clientName:
                        "${bookingModel.user.profile.firstName} ${bookingModel.user.profile.lastName}",
                        clientImage: bookingModel.user.profile.avatar ??
                            "https://www.freepik.com/free-vector/blue-circle-with-white-user_145857007.htm#fromView=keyword&page=1&position=0&uuid=44698d99-7990-4bc6-b044-b070b4af0344&query=No+Profile",
                        rating: 0.0,
                        reviews: 0,
                        address: "${bookingModel.address!.city} / ${bookingModel.address!.state} / ${bookingModel.address!.street}",
                        startTime: bookingModel.schedule!.startDate.toString(),
                        endTime: bookingModel.schedule!.endDate.toString(),
                        status: bookingModel.status ,
                        paymentStatus: PaymentStatus.pending,
                        amount: bookingModel.price,

                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterButton() {
    return PopupMenuButton<String>(
      onSelected: (value) => setState(() => _selectedFilter = value),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'All', child: Text('All Bookings')),
        const PopupMenuItem(value: 'Upcoming', child: Text('Upcoming')),
        const PopupMenuItem(value: 'InProgress', child: Text('In Progress')),
        const PopupMenuItem(value: 'Completed', child: Text('Completed')),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Text(_selectedFilter, style: TextStyle(fontSize: 14.sp)),
            Gap(4.w),
            const Icon(Icons.filter_alt_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsOverview(List<BookingModel> bookings) {
    final stats = {
      'Upcoming':
      bookings.where((b) => b.status.toLowerCase() == 'upcoming').length,
      'Today': bookings
          .where((b) => b.createdAt.isSameDate(DateTime.now()))
          .length,
      'Completed':
      bookings.where((b) => b.status.toLowerCase() == 'completed').length,
    };

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.entries
            .map((entry) => _buildStatItem(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  Widget _buildStatItem(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: _getStatusColor(label),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingCard(Booking booking) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToBookingDetails(booking),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getServiceIcon(booking.serviceType),
                      color: _getStatusColor(booking.status),
                      size: 20.w,
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.serviceName,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        Gap(4.h),
                        Text(
                          booking.serviceType,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      booking.status.capitalize(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _getStatusColor(booking.status),
                      ),
                    ),
                  ),
                ],
              ),

              Gap(16.h),

              // Client info
              Row(
                children: [
                  booking.clientImage.isEmpty || booking.clientImage.contains('freepik')
                      ? CircleAvatar(
                    radius: 20.w,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, color: Colors.grey.shade600),
                  )
                      : CircleAvatar(
                    radius: 20.w,
                    backgroundImage: NetworkImage(booking.clientImage),
                  ),
                  Gap(12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.clientName,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      Gap(2.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Gap(4.w),
                          Text(
                            '${booking.rating} (${booking.reviews})',
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Gap(16.h),

              // Details
              Row(
                children: [
                  _buildDetailChip(
                    icon: Icons.access_time,
                    text: '${booking.startTime} - ${booking.endTime}',
                  ),
                  Gap(8.w),
                  _buildDetailChip(
                    icon: Icons.location_on_outlined,
                    text: booking.address.split(',').take(2).join(','),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDetailChip({required IconData icon, required String text}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14.sp, color: Colors.grey.shade600),
            Gap(4.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 12.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note_outlined, size: 60.sp, color: Colors.grey.shade300),
          Gap(16.h),
          Text(
            'No bookings found',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          Gap(8.h),
          Text(
            'No bookings on ${DateFormat('MMM d, yyyy').format(_selectedDate)}',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // Navigation to BookingDetailsScreen
  void _navigateToBookingDetails(Booking booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => booking_details.BookingDetailsScreen(
          booking: booking_details.Booking(
            serviceName: booking.serviceName,
            clientName: booking.clientName,
            rating: booking.rating,
            reviews: booking.reviews,
            address: booking.address,
            date: booking.schedule!.startDate,
            status: _formatStatus(booking.status),
            paymentStatus: _formatPaymentStatus(booking.paymentStatus.name),
            amount: booking.amount, id: booking.id,
          ),
        ),
      ),
    );
  }

  // Helpers
  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return 'Upcoming';
      case 'inprogress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status.toUpperCase();
    }
  }

  String _formatPaymentStatus(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'paid':
        return 'Paid';
      case 'failed':
        return 'Failed';
      default:
        return paymentStatus;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return Colors.blue;
      case 'inprogress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getServiceIcon(String serviceType) {
    if (serviceType.contains('recurring')) return Icons.cleaning_services;
    if (serviceType.contains('one-time')) return Icons.cleaning_services;
    return Icons.home_repair_service;
  }
}

// ---------------------------- MODELS & EXTENSIONS ----------------------------

enum BookingStatus { upcoming, inProgress, completed, cancelled }
enum PaymentStatus { pending, paid, failed }

class Booking {
  final String id;
  final String serviceName;
  final String serviceType;
  final String clientName;
  final String clientImage;
  final double rating;
  final Schedule? schedule;
  final int reviews;
  final String address;
  final String startTime;
  final String endTime;
  final String status;
  final PaymentStatus paymentStatus;
  final double amount;

  Booking({
    required this.id,
    required this.serviceName,
    required this.serviceType,
    required this.clientName,
    required this.clientImage,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.paymentStatus,
    required this.amount,
    this.schedule
  });
}

extension DateUtils on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// ---------------------------- DATE SELECTOR ----------------------------

class DateSelectorWidget extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final DateTime? initialSelectedDate;

  const DateSelectorWidget({
    super.key,
    this.onDateSelected,
    this.initialSelectedDate,
  });

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  DateTime? selectedDate;
  late List<DateTime> availableDates;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialSelectedDate;
    _generateAvailableDates();
  }

  void _generateAvailableDates() {
    availableDates = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      availableDates.add(today.add(Duration(days: i)));
    }
  }

  String _getDayName(DateTime date) {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return days[date.weekday % 7];
  }

  String _getMonthName(DateTime date) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[date.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableDates.length,
        itemBuilder: (context, index) {
          final date = availableDates[index];
          final isSelected = selectedDate != null &&
              selectedDate!.day == date.day &&
              selectedDate!.month == date.month;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              widget.onDateSelected?.call(date);
            },
            child: Container(
              width: 70,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4DD0E1) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: const Color(0xFF4DD0E1), width: 2)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(date),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    _getMonthName(date),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';

class ServiceProviderJobsScreen extends StatefulWidget {
  const ServiceProviderJobsScreen({super.key});

  @override
  State<ServiceProviderJobsScreen> createState() =>
      _ServiceProviderBookingsScreenState();
}

class _ServiceProviderBookingsScreenState
    extends State<ServiceProviderJobsScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'All';
  final List<Booking> _allBookings = [
    Booking(
      id: '1',
      serviceName: 'Deep Cleaning',
      clientName: 'Sophia Carter',
      clientImage: 'https://randomuser.me/api/portraits/women/43.jpg',
      rating: 4.8,
      reviews: 123,
      address: '123 Elm Street, Apt 4B, New York, NY 10001',
      date: DateTime.now().add(const Duration(days: 1)),
      startTime: '09:00 AM',
      endTime: '11:00 AM',
      status: BookingStatus.upcoming,
      paymentStatus: PaymentStatus.paid,
      amount: 150.00,
      serviceType: 'Home Cleaning',
    ),
    Booking(
      id: '2',
      serviceName: 'AC Repair',
      clientName: 'John Smith',
      clientImage: 'https://randomuser.me/api/portraits/men/32.jpg',
      rating: 4.5,
      reviews: 87,
      address: '456 Oak Avenue, Suite 200, Brooklyn, NY 11201',
      date: DateTime.now(),
      startTime: '02:00 PM',
      endTime: '04:00 PM',
      status: BookingStatus.inProgress,
      paymentStatus: PaymentStatus.paid,
      amount: 200.00,
      serviceType: 'Appliance Repair',
    ),
    Booking(
      id: '3',
      serviceName: 'Plumbing',
      clientName: 'Michael Brown',
      clientImage: 'https://randomuser.me/api/portraits/men/65.jpg',
      rating: 4.9,
      reviews: 215,
      address: '789 Pine Road, Floor 3, Queens, NY 11354',
      date: DateTime.now().subtract(const Duration(days: 1)),
      startTime: '10:00 AM',
      endTime: '12:00 PM',
      status: BookingStatus.completed,
      paymentStatus: PaymentStatus.paid,
      amount: 120.00,
      serviceType: 'Plumbing',
    ),
  ];

  List<Booking> get _filteredBookings {
    return _allBookings.where((booking) {
      final dateMatch = booking.date.isSameDate(_selectedDate);
      if (_selectedFilter == 'All') return dateMatch;
      return dateMatch && booking.status.name == _selectedFilter.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ServicekCubit>().fetchMyBookings();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        actions: [_buildFilterButton()],
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GetMyBookingsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetMyBookingsFailedState) {
            return Center(
              child: Text(
                state.failure.msg,
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          }
          var cubit = ServiceCubit.get(context);
          List<BookingModel> myBookings = cubit.myBooking;
          return Column(
            children: [
              // Date selector
              // _buildDateSelector(),

              // Stats overview
              // _buildStatsOverview(),

              // Bookings list
              Expanded(
                child: _filteredBookings.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: myBookings.length,
                        separatorBuilder: (_, __) => Gap(16.h),
                        itemBuilder: (_, index) {
                          BookingModel bookingModel = myBookings[index];

                          return _buildBookingCard(
                            Booking(
                              id: bookingModel.id,
                              serviceName: bookingModel.service.name,
                              serviceType: bookingModel.service.serviceType,
                              clientName:
                                  " ${bookingModel.user.profile.firstName}  ${bookingModel.user.profile.lastName}",
                              clientImage: bookingModel.user.profile.avatar ??
                                  "https://img.freepik.com/premium-psd/3d-avatar-illustration-pro-gamer-isolated-transparent-background_846458-28.jpg?semt=ais_hybrid&w=740&q=80",
                              rating: 0.0,
                              reviews: 0,
                              address: 'N/A',
                              date: bookingModel.createdAt,
                              startTime:
                                  bookingModel.schedule!.startDate.toString(),
                              endTime:
                                  bookingModel.schedule!.endDate.toString(),
                              status: BookingStatus.upcoming,
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

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeDate(-1),
          ),
          GestureDetector(
            onTap: _showDatePicker,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  Gap(8.w),
                  Text(
                    DateFormat('EEE, MMM d').format(_selectedDate),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeDate(1),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final stats = {
      'Upcoming':
          _allBookings.where((b) => b.status == BookingStatus.upcoming).length,
      'Today':
          _allBookings.where((b) => b.date.isSameDate(DateTime.now())).length,
      'Completed':
          _allBookings.where((b) => b.status == BookingStatus.completed).length,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToBookingDetails(booking),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  // Service icon
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(booking.status.name).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getServiceIcon(booking.serviceType),
                      color: _getStatusColor(booking.status.name),
                      size: 20.w,
                    ),
                  ),
                  Gap(12.w),

                  // Service info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.serviceName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          booking.serviceType,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status badge
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color:
                          _getStatusColor(booking.status.name).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      booking.status.name.capitalize(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _getStatusColor(booking.status.name),
                      ),
                    ),
                  ),
                ],
              ),

              Gap(16.h),

              // Client info row
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.w,
                    backgroundImage: NetworkImage(booking.clientImage),
                  ),
                  Gap(12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.clientName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(2.h),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Gap(4.w),
                          Text(
                            '${booking.rating} (${booking.reviews})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Gap(16.h),

              // Details row
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

              Gap(16.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.message, size: 16.sp),
                      label: const Text('Message'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: const BorderSide(color: Colors.blue),
                      ),
                      onPressed: () => _contactClient(booking),
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getStatusColor(booking.status.name),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () => _handlePrimaryAction(booking),
                      child: Text(
                        _getActionButtonText(booking.status),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
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
          Icon(
            Icons.event_note_outlined,
            size: 60.sp,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            'No bookings found',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(8.h),
          Text(
            _selectedFilter == 'All'
                ? 'You have no bookings for ${DateFormat('MMM d').format(_selectedDate)}'
                : 'You have no $_selectedFilter bookings',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
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

  String _getActionButtonText(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return 'Start Job';
      case BookingStatus.inProgress:
        return 'Complete';
      case BookingStatus.completed:
        return 'View Details';
      case BookingStatus.cancelled:
        return 'Reschedule';
    }
  }

  IconData _getServiceIcon(String serviceType) {
    if (serviceType.contains('recurring')) return Icons.cleaning_services;
    if (serviceType.contains('one-time')) return Icons.cleaning_services;
    return Icons.home_repair_service;
  }

  // Action handlers
  void _navigateToBookingDetails(Booking booking) {
    // Navigator.push(context, MaterialPageRoute(builder: (_) => BookingDetailsScreen(booking: booking)));
  }

  void _contactClient(Booking booking) {
    // Implement contact logic
  }

  void _handlePrimaryAction(Booking booking) {
    switch (booking.status) {
      case BookingStatus.upcoming:
        // Start job logic
        break;
      case BookingStatus.inProgress:
        // Complete job logic
        break;
      case BookingStatus.completed:
        _navigateToBookingDetails(booking);
        break;
      case BookingStatus.cancelled:
        // Reschedule logic
        break;
    }
  }

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  Future<void> _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }
}

// Data models
enum BookingStatus { upcoming, inProgress, completed, cancelled }

enum PaymentStatus { pending, paid, failed }

class Booking {
  final String id;
  final String serviceName;
  final String serviceType;
  final String clientName;
  final String clientImage;
  final double rating;
  final int reviews;
  final String address;
  final DateTime date;
  final String startTime;
  final String endTime;
  final BookingStatus status;
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
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.paymentStatus,
    required this.amount,
  });
}

// Extensions
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/booking_details_screen.dart'
    as booking_details;

class ServiceProviderBookingsScreen extends StatefulWidget {
  const ServiceProviderBookingsScreen({super.key});

  @override
  State<ServiceProviderBookingsScreen> createState() =>
      _ServiceProviderBookingsScreenState();
}

class _ServiceProviderBookingsScreenState
    extends State<ServiceProviderBookingsScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<Booking> _bookings = [
    Booking(
      serviceName: 'Deep Cleaning',
      clientName: 'Sophia Carter',
      rating: 4.8,
      reviews: 123,
      address: '123 Elm Street',
      date: DateTime.now().add(const Duration(days: 4)),
      status: 'Upcoming',
      paymentStatus: 'Paid',
      amount: 150.00,
    ),
    Booking(
      serviceName: 'AC Repair',
      clientName: 'John Smith',
      rating: 4.5,
      reviews: 87,
      address: '456 Oak Avenue',
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Completed',
      paymentStatus: 'Paid',
      amount: 200.00,
    ),
    Booking(
      serviceName: 'Plumbing',
      clientName: 'Michael Brown',
      rating: 4.9,
      reviews: 215,
      address: '789 Pine Road',
      date: DateTime.now().add(const Duration(days: 3)),
      status: 'Upcoming',
      paymentStatus: 'Pending',
      amount: 120.00,
    ),
  ];

  List<Booking> _selectedDayBookings = [];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _updateSelectedDayBookings(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
        centerTitle: false,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
                _updateSelectedDayBookings(_selectedDate);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All Bookings')),
              const PopupMenuItem(value: 'Upcoming', child: Text('Upcoming')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
            ],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    _selectedFilter,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Gap(4.w),
                  const Icon(Icons.filter_list),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          // if (state is GetMyBookingsLoadingState) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if (state is GetMyBookingsFailedState ) {
          //   return Center(
          //     child: Text(
          //       'Error: {state.error}',
          //       style: TextStyle(fontSize: 16.sp, color: Colors.red),
          //     ),
          //   );
          // }
          return Column(
            children: [
              // Calendar Section
              _buildCalendarHeader(),
              _buildCalendar(),

              // Filter and Stats Bar
              _buildStatsBar(),

              // Booking Details Section
              Expanded(
                child: _selectedDayBookings.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.all(AppConst.appPadding.w),
                        itemCount: _selectedDayBookings.length,
                        itemBuilder: (context, index) => _buildBookingCard(
                            context, _selectedDayBookings[index]),
                      )
                    : _buildNoBookingsUI(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsBar() {
    final upcomingCount = _bookings.where((b) => b.status == 'Upcoming').length;
    final completedCount =
        _bookings.where((b) => b.status == 'Completed').length;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Upcoming', upcomingCount, AppColors.blue),
          _buildStatItem('Completed', completedCount, Colors.green),
          _buildStatItem('Total', _bookings.length, Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: color,
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

  Widget _buildNoBookingsUI() {
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
            _selectedFilter == 'All'
                ? "No bookings for this day"
                : "No $_selectedFilter bookings",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(8.h),
          Text(
            "You have no scheduled services for ${DateFormat('MMM d, yyyy').format(_selectedDate)}",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Booking booking) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
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
                  date: booking.date,
                  status: booking.status,
                  paymentStatus: booking.paymentStatus,
                  amount: booking.amount,
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getServiceIcon(booking.serviceName),
                      color: _getStatusColor(booking.status),
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              booking.serviceName,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gap(8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: _getStatusColor(booking.status)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                booking.status,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: _getStatusColor(booking.status),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(4.h),
                        Text(
                          "with ${booking.clientName}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      Gap(4.w),
                      Text(
                        booking.rating.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(16.h),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
                  Gap(8.w),
                  Text(
                    DateFormat('h:mm a').format(booking.date),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Gap(16.w),
                  Icon(Icons.location_on_outlined,
                      size: 16.sp, color: Colors.grey),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      booking.address,
                      style: TextStyle(fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: const BorderSide(color: AppColors.blue),
                      ),
                      onPressed: () {
                        // Handle message
                      },
                      child: const Text(
                        "Message",
                        style: TextStyle(color: AppColors.blue),
                      ),
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        backgroundColor: _getActionButtonColor(booking.status),
                      ),
                      onPressed: () {
                        if (booking.status == 'Completed') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  booking_details.BookingDetailsScreen(
                                booking: booking_details.Booking(
                                  serviceName: booking.serviceName,
                                  clientName: booking.clientName,
                                  rating: booking.rating,
                                  reviews: booking.reviews,
                                  address: booking.address,
                                  date: booking.date,
                                  status: booking.status,
                                  paymentStatus: booking.paymentStatus,
                                  amount: booking.amount,
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Handle start job
                        }
                      },
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

  Widget _buildCalendarHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppConst.appPadding.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('MMMM yyyy').format(_selectedDate),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _changeMonth(-1),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime.now();
                    _updateSelectedDayBookings(_selectedDate);
                  });
                },
                child: Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blue,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final firstDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startingWeekday = firstDayOfMonth.weekday;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildWeekdayHeaders(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final dayOffset = index - startingWeekday + 1;
              final day =
                  dayOffset > 0 && dayOffset <= daysInMonth ? dayOffset : null;
              final date = day != null
                  ? DateTime(_selectedDate.year, _selectedDate.month, day)
                  : null;

              final isToday = date?.isSameDate(DateTime.now()) ?? false;
              final isSelected = date?.isSameDate(_selectedDate) ?? false;
              final hasBooking = date != null &&
                  _bookings.any((booking) => booking.date.isSameDate(date));

              return GestureDetector(
                onTap: () {
                  if (day != null) {
                    setState(() {
                      _selectedDate = DateTime(
                          _selectedDate.year, _selectedDate.month, day);
                      _updateSelectedDayBookings(_selectedDate);
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.blue : null,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day?.toString() ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: day == null
                              ? Colors.transparent
                              : isSelected
                                  ? Colors.white
                                  : isToday
                                      ? AppColors.blue
                                      : Colors.black,
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (hasBooking)
                        Container(
                          width: 4.w,
                          height: 4.w,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : AppColors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      children: weekdays
          .map(
            (day) => Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return AppColors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getActionButtonColor(String status) {
    switch (status) {
      case 'Upcoming':
        return AppColors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.grey;
      default:
        return AppColors.blue;
    }
  }

  String _getActionButtonText(String status) {
    switch (status) {
      case 'Upcoming':
        return 'Start Job';
      case 'Completed':
        return 'View Details';
      case 'Cancelled':
        return 'Reschedule';
      default:
        return 'Start Job';
    }
  }

  IconData _getServiceIcon(String serviceName) {
    if (serviceName.contains('Cleaning')) return Icons.cleaning_services;
    if (serviceName.contains('AC')) return Icons.ac_unit;
    if (serviceName.contains('Plumbing')) return Icons.plumbing;
    return Icons.home_repair_service;
  }

  void _updateSelectedDayBookings(DateTime date) {
    setState(() {
      _selectedDayBookings = _bookings.where((b) {
        final dateMatch = b.date.isSameDate(date);
        if (_selectedFilter == 'All') return dateMatch;
        return dateMatch && b.status == _selectedFilter;
      }).toList();
    });
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + delta, 1);
      _updateSelectedDayBookings(_selectedDate);
    });
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
    required this.status,
    required this.paymentStatus,
    required this.amount,
  });
}

extension DateExtensions on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

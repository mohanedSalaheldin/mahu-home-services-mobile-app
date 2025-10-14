import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/views/screens/booking_details_screen.dart'
    as booking_details;
import 'package:mahu_home_services_app/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceProviderBookingsScreen extends StatefulWidget {
  const ServiceProviderBookingsScreen({super.key});

  @override
  State<ServiceProviderBookingsScreen> createState() =>
      _ServiceProviderBookingsScreenState();
}

class _ServiceProviderBookingsScreenState
    extends State<ServiceProviderBookingsScreen> {
  DateTime _selectedDate = DateTime.now();
  List<BookingModel> _bookings = [];
  List<BookingModel> _selectedDayBookings = [];
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    context.read<ServiceCubit>().fetchMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).serviceProviderBookingsScreenTitle),
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
              PopupMenuItem(value: 'All', child: Text(S.of(context).serviceProviderBookingsScreenFilterAll)),
              PopupMenuItem(value: 'pending', child: Text(S.of(context).serviceProviderBookingsScreenFilterPending)),
              PopupMenuItem(value: 'confirmed', child: Text(S.of(context).serviceProviderBookingsScreenFilterConfirmed)),
              PopupMenuItem(value: 'in-progress', child: Text(S.of(context).serviceProviderBookingsScreenFilterInProgress)),
              PopupMenuItem(value: 'completed', child: Text(S.of(context).serviceProviderBookingsScreenFilterCompleted)),
              PopupMenuItem(value: 'cancelled', child: Text(S.of(context).serviceProviderBookingsScreenFilterCancelled)),
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
        listener: (BuildContext context, ServiceState state) {
          if (state is GetMyBookingSuccessState) {
            setState(() {
              _bookings = context.read<ServiceCubit>().myBooking;
              _updateSelectedDayBookings(_selectedDate);
            });
          }
        },
        builder: (context, state) {
          if (state is GetMyBookingsLoadingState) {
            return Center(
                child: CircularProgressIndicator(color: Colors.blue));
          }
          if (state is GetMyBookingsFailedState) {
            return Center(child: Text(S.of(context).serviceProviderBookingsScreenError(state.failure.msg)));
          }

          return Column(
            children: [
              _buildCalendarHeader(),
              _buildCalendar(),
              _buildStatsBar(),
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
    final pendingCount = _bookings.where((b) => b.status == 'pending').length;
    final confirmedCount =
        _bookings.where((b) => b.status == 'confirmed').length;
    final completedCount =
        _bookings.where((b) => b.status == 'completed').length;
    final cancelledCount =
        _bookings.where((b) => b.status == 'cancelled').length;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(S.of(context).serviceProviderBookingsScreenStatsCompleted, completedCount, Colors.green),
              _buildStatItem(S.of(context).serviceProviderBookingsScreenStatsConfirmed, confirmedCount, AppColors.blue),
              _buildStatItem(S.of(context).serviceProviderBookingsScreenStatsTotal, _bookings.length, Colors.grey.shade600),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      throw Exception(S.of(context).serviceProviderBookingsScreenCallError(phoneNumber));
    }
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
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
            size: 60,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            _selectedFilter == 'All'
                ? S.of(context).serviceProviderBookingsScreenNoBookingsDay
                : S.of(context).serviceProviderBookingsScreenNoBookingsFilter(_selectedFilter),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(8.h),
          Text(
            S.of(context).serviceProviderBookingsScreenNoBookingsSubtitle(DateFormat('MMM d, yyyy').format(_selectedDate)),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, BookingModel booking) {
    DateTime bookingDate = booking.schedule?.startDate ?? booking.createdAt;
    String clientName =
        "${booking.user.profile.firstName} ${booking.user.profile.lastName}";

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
                booking: BookingModel(
                  id: booking.id,
                  service: booking.service,
                  user: booking.user,
                  provider: booking.provider,
                  serviceType: booking.serviceType,
                  schedule: booking.schedule,
                  price: booking.price,
                  bookingDate: booking.bookingDate,
                  dayOfWeek: booking.dayOfWeek,
                  createdAt: booking.createdAt,
                  updatedAt: booking.updatedAt,
                  option: booking.option,
                  duration: booking.duration,
                  address: booking.address,
                  status: _formatStatus(booking.status),
                  paymentStatus: booking.paymentStatus,
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
                      _getServiceIcon(booking.service.name),
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
                            Expanded(
                              child: Text(
                                booking.service.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                                _formatStatus(booking.status),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _getStatusColor(booking.status),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(4.h),
                        Text(
                          S.of(context).serviceProviderBookingsScreenWithClient(clientName),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                  Gap(8.w),
                  Text(
                    booking.schedule!.startTime ?? '',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Gap(16.w),
                  Icon(Icons.phone, size: 16, color: Colors.grey),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      booking.user.phone,
                      style: TextStyle(fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (booking.details != null) ...[
                Gap(8.h),
                Row(
                  children: [
                    Icon(Icons.description, size: 16, color: Colors.grey),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        booking.details!,
                        style: TextStyle(fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
              Gap(16.h),
              Row(
                children: [
                  Text(
                    "\$${booking.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    S.of(context).serviceProviderBookingsScreenPaymentStatus(_formatPaymentStatus(booking.paymentStatus)),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getPaymentStatusColor(booking.paymentStatus),
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
                        _showContactOptions(context, booking);
                      },
                      child: Text(
                        S.of(context).serviceProviderBookingsScreenContactButton,
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
                      onPressed: () => _handleStatusAction(context, booking),
                      child: Text(
                        _getActionButtonText(booking.status, context),
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

  void _showContactOptions(BuildContext context, BookingModel booking) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(S.of(context).serviceProviderBookingsScreenCallClient(booking.user.profile.firstName)),
              subtitle: Text(booking.user.phone),
              onTap: () {
                _makePhoneCall(booking.user.phone);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleStatusAction(BuildContext context, BookingModel booking) {
    switch (booking.status) {
      case 'pending':
        _showStatusChangeDialog(
            context, booking, 'confirmed', S.of(context).serviceProviderBookingsScreenConfirmDialog);
        break;
      case 'confirmed':
        _showStatusChangeDialog(
            context, booking, 'in-progress', S.of(context).serviceProviderBookingsScreenStartJobDialog);
        break;
      case 'in-progress':
        _showStatusChangeDialog(
            context, booking, 'completed', S.of(context).serviceProviderBookingsScreenCompleteDialog);
        break;
      case 'completed':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => booking_details.BookingDetailsScreen(
              booking: BookingModel(
                id: booking.id,
                service: booking.service,
                user: booking.user,
                provider: booking.provider,
                serviceType: booking.serviceType,
                schedule: booking.schedule,
                price: booking.price,
                bookingDate: booking.bookingDate,
                dayOfWeek: booking.dayOfWeek,
                createdAt: booking.createdAt,
                updatedAt: booking.updatedAt,
                option: booking.option,
                duration: booking.duration,
                address: booking.address,
                status: _formatStatus(booking.status),
                paymentStatus: booking.paymentStatus,
              ),
            ),
          ),
        );
        break;
    }
  }

  void _showStatusChangeDialog(BuildContext context, BookingModel booking,
      String newStatus, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).serviceProviderBookingsScreenConfirmActionTitle),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).serviceProviderBookingsScreenCancelButton),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<ServiceCubit>()
                  .changeBookingStatus(booking.id, newStatus);
            },
            child: Text(S.of(context).serviceProviderBookingsScreenConfirmButton),
          ),
        ],
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
              fontSize: 18,
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
                  S.of(context).serviceProviderBookingsScreenTodayButton,
                  style: TextStyle(
                    fontSize: 14,
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
                  _bookings.any((booking) =>
                      (booking.schedule?.startDate ?? booking.createdAt)
                          .isSameDate(date));

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
                          fontSize: 14,
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
    return Row(
      children: [
        S.of(context).serviceProviderBookingsScreenWeekdaySunday,
        S.of(context).serviceProviderBookingsScreenWeekdayMonday,
        S.of(context).serviceProviderBookingsScreenWeekdayTuesday,
        S.of(context).serviceProviderBookingsScreenWeekdayWednesday,
        S.of(context).serviceProviderBookingsScreenWeekdayThursday,
        S.of(context).serviceProviderBookingsScreenWeekdayFriday,
        S.of(context).serviceProviderBookingsScreenWeekdaySaturday,
      ].asMap().entries.map((entry) => Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            )).toList(),
    );
  }

  String _formatStatus(String status) {
    switch (status) {
      case 'pending':
        return S.of(context).serviceProviderBookingsScreenStatusPending;
      case 'confirmed':
        return S.of(context).serviceProviderBookingsScreenStatusConfirmed;
      case 'in-progress':
        return S.of(context).serviceProviderBookingsScreenStatusInProgress;
      case 'completed':
        return S.of(context).serviceProviderBookingsScreenStatusCompleted;
      case 'cancelled':
        return S.of(context).serviceProviderBookingsScreenStatusCancelled;
      default:
        return status.toUpperCase();
    }
  }

  String _formatPaymentStatus(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case 'paid':
        return S.of(context).serviceProviderBookingsScreenPaymentStatusPaid;
      case 'pending':
        return S.of(context).serviceProviderBookingsScreenPaymentStatusPending;
      case 'failed':
        return S.of(context).serviceProviderBookingsScreenPaymentStatusFailed;
      default:
        return paymentStatus;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
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
    switch (status) {
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

  String _getActionButtonText(String status, BuildContext context) {
    switch (status) {
      case 'pending':
        return S.of(context).serviceProviderBookingsScreenActionConfirm;
      case 'confirmed':
        return S.of(context).serviceProviderBookingsScreenActionStartJob;
      case 'in-progress':
        return S.of(context).serviceProviderBookingsScreenActionComplete;
      case 'completed':
        return S.of(context).serviceProviderBookingsScreenActionViewDetails;
      case 'cancelled':
        return S.of(context).serviceProviderBookingsScreenActionReschedule;
      default:
        return S.of(context).serviceProviderBookingsScreenActionDefault;
    }
  }

  IconData _getServiceIcon(String serviceName) {
    if (serviceName.toLowerCase().contains('cleaning'))
      return Icons.cleaning_services;
    if (serviceName.toLowerCase().contains('ac') ||
        serviceName.toLowerCase().contains('air')) return Icons.ac_unit;
    if (serviceName.toLowerCase().contains('plumb')) return Icons.plumbing;
    if (serviceName.toLowerCase().contains('electric'))
      return Icons.electrical_services;
    if (serviceName.toLowerCase().contains('garden') ||
        serviceName.toLowerCase().contains('lawn')) return Icons.grass;
    if (serviceName.toLowerCase().contains('paint')) return Icons.format_paint;
    return Icons.home_repair_service;
  }

  void _updateSelectedDayBookings(DateTime date) {
    setState(() {
      _selectedDayBookings = _bookings.where((b) {
        final bookingDate = b.schedule?.startDate ?? b.createdAt;
        final dateMatch = bookingDate.isSameDate(date);
        if (_selectedFilter == 'All') return dateMatch;
        return dateMatch && b.status == _selectedFilter.toLowerCase();
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

extension DateExtensions on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
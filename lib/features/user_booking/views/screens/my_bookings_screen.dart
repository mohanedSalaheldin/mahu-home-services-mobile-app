import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/new_booking_model.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/services/review_services.dart';
import 'package:mahu_home_services_app/features/user_booking/services/user_booking_services.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabTitles = ['Upcoming', 'Previous'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    // Load bookings when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBookingCubit>().getMyBookings();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
            ),
          ),
        ),
      ),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          if (state is UserGetMyBookingsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserGetMyBookingsLoadingState) {
            return _buildLoadingState();
          }

          if (state is UserGetMyBookingsSuccessState) {
            final bookings = state.bookings;
            final upcomingBookings =
                bookings.where((b) => _isUpcomingBooking(b)).toList();
            final previousBookings =
                bookings.where((b) => !_isUpcomingBooking(b)).toList();

            return TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(upcomingBookings.cast<BookingNewModel>(),
                    isEmptyMessage: 'No upcoming bookings'),
                _buildBookingsList(previousBookings.cast<BookingNewModel>(),
                    isEmptyMessage: 'No previous bookings'),
              ],
            );
          }

          return _buildErrorState();
        },
      ),
    );
  }

  bool _isUpcomingBooking(BookingNewModel booking) {
    final now = DateTime.now();

    // If booking is completed or cancelled => it's Previous
    if (booking.status?.toLowerCase() == 'completed' ||
        booking.status?.toLowerCase() == 'cancelled') {
      return false;
    }

    final bookingDate = booking.schedule?.startDate;
    return bookingDate != null &&
        (bookingDate.isAfter(now) || bookingDate.isAtSameMomentAs(now));
  }

  Widget _buildBookingsList(List<BookingNewModel> bookings,
      {required String isEmptyMessage}) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64.w,
              color: Colors.grey.shade300,
            ),
            Gap(16.h),
            Text(
              isEmptyMessage,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBookingCubit>().getMyBookings();
      },
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: bookings.length,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) {
          return BookingCard(booking: bookings[index]);
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  height: 16.h,
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.only(bottom: 8.h),
                ),
                Container(
                  width: 80.w,
                  height: 12.h,
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.only(bottom: 12.h),
                ),
                Container(
                  width: double.infinity,
                  height: 14.h,
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.only(bottom: 8.h),
                ),
                Container(
                  width: 100.w,
                  height: 14.h,
                  color: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.w,
            color: Colors.grey.shade400,
          ),
          Gap(16.h),
          Text(
            'Failed to load bookings',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Gap(8.h),
          ElevatedButton(
            onPressed: () {
              context.read<UserBookingCubit>().getMyBookings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final BookingNewModel booking;
  final ReviewServices _reviewServices = ReviewServices();

  BookingCard({super.key, required this.booking});

  Future<void> _cancelBooking(
      BuildContext context, BookingNewModel booking) async {
    // Store snackbar reference to ensure we can hide it
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

    try {
      // Show loading indicator
      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
              SizedBox(width: 16.w),
              Text('Cancelling booking...'),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 10), // Reduced to 10 seconds for safety
        ),
      );

      // Get token from cache
      final token = CacheHelper.getString('token');
      if (token == null || token.isEmpty) {
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            content: Text('User not authenticated'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Call the cancel booking service
      final result =
          await UserBookingServices().cancelBooking(booking.id, token);

      // Always hide the loading snackbar first
      messenger.hideCurrentSnackBar();

      result.fold(
        (failure) {
          // Handle failure

          messenger.showSnackBar(
            const SnackBar(
              content: Text('Failed to cancel booking please try later'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        },
        (success) {
          if (success) {
            // Handle success - booking was cancelled
            print('Booking cancelled successfully');
            messenger.showSnackBar(
              SnackBar(
                content: Text('Booking cancelled successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            // Refresh the bookings list
            context.read<UserBookingCubit>().getMyBookings();
          } else {
            // Handle case where API returned success: false
            print('API returned success: false');
            messenger.showSnackBar(
              const SnackBar(
                content: Text('Booking cancellation failed. Please try again.'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Ensure loading snackbar is hidden in case of error
      messenger.hideCurrentSnackBar();
      if (kDebugMode) {
        print('Error cancelling booking: $e');
      }
      
    }
  }

  Future<void> _addReview(BuildContext context, BookingNewModel booking) async {
    final token = CacheHelper.getString('token');
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login to add a review')),
      );
      return;
    }

    // Check if user already reviewed this service
    final result = await _reviewServices.getMyReviewForService(
      booking.service.id,
      token,
    );

    result.fold(
      (failure) {
        // Proceed to add review if check fails
        _showReviewDialog(context, booking, token);
      },
      (reviewData) {
        if (reviewData != null && reviewData['hasReviewed'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You have already reviewed this service')),
          );
        } else {
          _showReviewDialog(context, booking, token);
        }
      },
    );
  }


  void _showReviewDialog(
    BuildContext context, BookingNewModel booking, String token) {
  int selectedRating = 0;
  TextEditingController feedbackController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Text(
              'Add Review',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Title in blue
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'How would you rate ${booking.service.name}?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue, // Text in blue
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(16.h),
                  // Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          size: 32.w,
                          color: Colors.amber,
                        ),
                      );
                    }),
                  ),
                  Gap(16.h),
                  // Feedback
                  TextField(
                    controller: feedbackController,
                    decoration: InputDecoration(
                      labelText: 'Your feedback (optional)',
                      labelStyle: TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      contentPadding: EdgeInsets.all(12.w),
                    ),
                    maxLines: 3,
                    maxLength: 500,
                  ),
                ],
              ),
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                ),
                onPressed: selectedRating > 0
                    ? () async {
                        Navigator.pop(context);
                        await _submitReview(
                          context,
                          booking.service.id,
                          selectedRating,
                          feedbackController.text,
                          token,
                        );
                      }
                    : null,
                child: Text(
                  'Submit Review',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

  Future<void> _submitReview(
    BuildContext context,
    String serviceId,
    int rating,
    String feedback,
    String token,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
            SizedBox(width: 16.w),
            Text('Submitting review...'),
          ],
        ),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 10),
      ),
    );

    final result = await _reviewServices.addReview(
      serviceId: serviceId,
      rating: rating,
      feedback: feedback,
      token: token,
    );

    messenger.hideCurrentSnackBar();

    result.fold(
      (failure) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Failed to submit review: ${failure.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (success) {
        if (success) {
          messenger.showSnackBar(
            SnackBar(
              content: Text('Review submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          messenger.showSnackBar(
            SnackBar(
              content: Text('Failed to submit review'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceName = booking.service.name ?? 'Unknown Service';
    final date = booking.schedule!.startDate;
    final status = booking.status?.toLowerCase() ?? 'pending';
    final price = booking.price ?? 0.0;
    final time = DateFormat('HH:mm').format(date);
    final dayName = DateFormat('EEEE').format(date);
    final formattedDate = DateFormat('MMM dd, yyyy').format(date);

    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'confirmed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'in-progress':
        statusColor = Colors.blue;
        statusIcon = Icons.timer;
        break;
      case 'completed':
        statusColor = Colors.grey;
        statusIcon = Icons.done_all;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default: // pending
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with service name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    serviceName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gap(8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 14.w,
                        color: statusColor,
                      ),
                      Gap(4.w),
                      Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),

            // Date and time information
            Row(
              children: [
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  text: formattedDate,
                ),
                Gap(16.w),
                _buildInfoItem(
                  icon: Icons.access_time,
                  text: time,
                ),
              ],
            ),
            Gap(8.h),

            // Day name
            Text(
              dayName,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
            Gap(12.h),

            // Divider
            Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            Gap(12.h),

            // Footer with price and actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                Row(
                  children: [
                    if (status == 'completed')
                      ElevatedButton(
                        onPressed: () => _addReview(context, booking),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                        child: Text(
                          'Add Review',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (status == 'completed') Gap(8.w),
                    if (status == 'pending' || status == 'confirmed')
                      OutlinedButton(
                        onPressed: () {
                          _showCancelDialog(context, booking);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    if (status == 'pending' || status == 'confirmed') Gap(8.w),
                    ElevatedButton(
                      onPressed: () {
                        _showBookingDetails(context, booking);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                      ),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.w,
          color: Colors.grey.shade500,
        ),
        Gap(4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _showCancelDialog(BuildContext context, BookingNewModel booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cancel Booking?',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to cancel your booking for ${booking.service?.name}?',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Keep Booking',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _cancelBooking(context, booking);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Cancel Booking',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDetails(BuildContext context, BookingNewModel booking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BookingDetailsSheet(booking: booking),
    );
  }
}

class BookingDetailsSheet extends StatefulWidget {
  final BookingNewModel booking;

  const BookingDetailsSheet({super.key, required this.booking});

  @override
  State<BookingDetailsSheet> createState() => _BookingDetailsSheetState();
}

class _BookingDetailsSheetState extends State<BookingDetailsSheet> {
  final ReviewServices _reviewServices = ReviewServices();
  List<dynamic> _reviews = [];
  bool _isLoadingReviews = false;
  double _averageRating = 0;
  int _totalReviews = 0;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    if (mounted) {
      setState(() {
        _isLoadingReviews = true;
      });
    }

    final result = await _reviewServices.getServiceReviews(widget.booking.service.id);

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _isLoadingReviews = false;
          });
        }
      },
      (reviewsData) {
        if (mounted) {
          setState(() {
            _isLoadingReviews = false;
            _reviews = reviewsData['reviews'] ?? [];
            _averageRating = (reviewsData['averageRating'] ?? 0).toDouble();
            _totalReviews = reviewsData['totalReviews'] ?? 0;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Gap(20.h),
          Text(
            'Booking Details',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(16.h),
          
          // Booking Details
          _buildDetailRow('Service', widget.booking.service.name),
          _buildDetailRow('Status', widget.booking.status.toUpperCase()),
          _buildDetailRow('Date',
              DateFormat('MMM dd, yyyy').format(widget.booking.schedule.startDate)),
          _buildDetailRow(
            'Start Time',
            widget.booking.schedule.startTime,
          ),
          _buildDetailRow(
            'End Time',
            widget.booking.schedule.endTime,
          ),
          _buildDetailRow('Duration', '${widget.booking.duration / 60} hours'),
          _buildDetailRow('Total', '\$${widget.booking.price.toStringAsFixed(2)}'),
          
          if (widget.booking.address.street.isNotEmpty) ...[
            Gap(12.h),
            Text(
              'Address',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Gap(8.h),
            Text(
              '${widget.booking.address.street}, ${widget.booking.address.city}, ${widget.booking.address.state}',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
          ],
          
          Gap(24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _buildReviewItem(dynamic review) {
    final userName = review['userName'] ?? 'Anonymous';
    final rating = (review['rating'] ?? 0).toDouble();
    final feedback = review['feedback'] ?? '';
    final createdAt = review['createdAt'] != null 
        ? DateFormat('MMM dd, yyyy').format(DateTime.parse(review['createdAt']))
        : '';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User and Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildStarRating(rating, size: 16),
            ],
          ),
          
          Gap(8.h),
          
          // Feedback
          if (feedback.isNotEmpty)
            Text(
              feedback,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade700,
              ),
            ),
          
          Gap(8.h),
          
          // Date
          if (createdAt.isNotEmpty)
            Text(
              createdAt,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          size: size.w,
          color: Colors.amber,
        );
      }),
    );
  }

  void _showAllReviewsDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(20.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          constraints: BoxConstraints(maxHeight: 500.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Reviews ($_totalReviews)',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(16.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewItem(_reviews[index]);
                  },
                ),
              ),
              Gap(16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
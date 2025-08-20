// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
// import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
// // import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_state.dart';
// import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
// import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
// import 'package:intl/intl.dart';

// class MyBookingsScreen extends StatelessWidget {
//   const MyBookingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'My Bookings',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primary,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: BlocConsumer<UserBookingCubit, UserBookingState>(
//         listener: (context, state) {
//           if (state is UserGetMyBookingsErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.failure.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is UserGetMyBookingsLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is UserGetMyBookingsSuccessState) {
//             final bookings = state;

//             if (bookings.isEmpty == null) {
//               return Center(child: Text("No bookings yet"));
//             }

//             return ListView.builder(
//               itemCount: bookings.bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = bookings.bookings[index];
//                 return _BookingCard(booking: booking);
//               },
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }

// extension on UserGetMyBookingsSuccessState {
//   bool? get isEmpty => null;
// }

// class _BookingCard extends StatelessWidget {
//   final dynamic booking; // Replace with actual Booking model

//   const _BookingCard({required this.booking});

//   @override
//   Widget build(BuildContext context) {
//     final serviceName = booking.service?.name ?? 'Unknown Service';
//     final date = booking.startDate ?? DateTime.now();
//     final status = booking.status ?? 'Pending';
//     final price = booking.service?.price ?? 0.0;

//     return Card(
//       margin: EdgeInsets.only(bottom: 16.h),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // service + status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   serviceName,
//                   style:
//                       TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//                 ),
//                 Chip(
//                   label: Text(
//                     status,
//                     style: TextStyle(fontSize: 12.sp, color: Colors.white),
//                   ),
//                   backgroundColor: status.toLowerCase() == 'confirmed'
//                       ? Colors.green
//                       : status.toLowerCase() == 'pending'
//                           ? Colors.orange
//                           : Colors.red,
//                 ),
//               ],
//             ),
//             Gap(8.h),

//             // booking date
//             Row(
//               children: [
//                 Icon(Icons.calendar_today,
//                     size: 16.sp, color: Colors.grey.shade600),
//                 Gap(8.w),
//                 Text(
//                   DateFormat('MMM dd, yyyy').format(date),
//                   style:
//                       TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//             Gap(8.h),

//             // price
//             Text(
//               '\$${price.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
//             ),

//             Gap(12.h),

//             // actions
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             ServiceDetailsScreen(service: booking.service),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'View Details',
//                     style: TextStyle(fontSize: 14.sp, color: AppColors.primary),
//                   ),
//                 ),
//                 Gap(8.w),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement rebook logic
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Rebooking $serviceName...')),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r)),
//                   ),
//                   child: Text(
//                     'Rebook',
//                     style: TextStyle(fontSize: 14.sp, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings', style: TextStyle(fontSize: 20.sp)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated construction icon
            Icon(
              Icons.construction_rounded,
              size: 80.w,
              color: Colors.blue,
            ),
            Gap(24.h),

            // Main title
            Text(
              'Under Development',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(16.h),

            // Subtitle
            Text(
              'We\'re working hard to bring you\nan amazing booking experience!',
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(32.h),

            // Coming soon text
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

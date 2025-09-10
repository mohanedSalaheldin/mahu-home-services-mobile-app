// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/app_const.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
// import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
// import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
// import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';
// import 'package:mahu_home_services_app/features/services/models/service_model.dart';
// import 'package:mahu_home_services_app/features/user_booking/views/widgets/dashed_line.dart';
// import 'package:mahu_home_services_app/features/user_booking/views/widgets/service_summary_card.dart';
// import 'package:intl/intl.dart';

// class ReviewBookingSummaryScreen extends StatelessWidget {
//   final UserBookingModel booking;
//   final ServiceModel service;
//   final String providerName;

//   const ReviewBookingSummaryScreen({
//     super.key,
//     required this.booking,
//     required this.service,
//     required this.providerName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final totalAmount = booking.price;
//     final taxAmount = totalAmount * 0.05; // 5% tax
//     final finalAmount = totalAmount + taxAmount;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         title: const Text('Booking Summary'),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16.w),
//               child: Column(
//                 children: [
//                   // Success Header
//                   _buildSuccessHeader(),
//                   Gap(24.h),

//                   // Booking Summary Card
//                   _buildBookingSummaryCard(totalAmount, taxAmount, finalAmount),
//                   Gap(24.h),

//                   // Service Details
//                   _buildServiceDetails(),
//                   Gap(16.h),

//                   // Schedule Details
//                   _buildScheduleDetails(),
//                   Gap(16.h),

//                   // Address Details
//                   _buildAddressDetails(),
//                   Gap(16.h),

//                   // Payment Method
//                   _buildPaymentMethod(),
//                   Gap(24.h),
//                 ],
//               ),
//             ),
//           ),

//           // Action Buttons
//           _buildActionButtons(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuccessHeader() {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(
//             Icons.check_circle,
//             size: 64.w,
//             color: Colors.green,
//           ),
//           Gap(16.h),
//           Text(
//             'Booking Created Successfully!',
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.green.shade800,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           Gap(8.h),
//           Text(
//             'Your service has been scheduled successfully. You can track the status in your bookings.',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.grey.shade600,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookingSummaryCard(double totalAmount, double taxAmount, double finalAmount) {
//     return DottedBorder(
//       color: AppColors.primary.withOpacity(0.5),
//       strokeWidth: 2,
//       dashPattern: const [6, 4],
//       borderType: BorderType.RRect,
//       radius: Radius.circular(16.r),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             children: [
//               // Booking ID
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Booking ID:',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   Text(
//                     "3562773",
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(20.h),

//               // Amount Breakdown
//               _buildAmountRow('Service Amount', '\$${totalAmount.toStringAsFixed(2)}'),
//               Gap(12.h),
//               _buildAmountRow('Tax (5%)', '\$${taxAmount.toStringAsFixed(2)}'),
//               Gap(16.h),
//               const DashedLine(
//                 color: Colors.grey,
//                 dashWidth: 4,
//                 dashGap: 4,
//                 height: 1,
//               ),
//               Gap(16.h),
//               _buildAmountRow(
//                 'Total Amount',
//                 '\$${finalAmount.toStringAsFixed(2)}',
//                 isTotal: true,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceDetails() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Service Details',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           Gap(16.h),
//           _buildDetailRow('Service Name', service.name),
//           Gap(12.h),
//           _buildDetailRow('Category', _capitalizeFirstLetter(service.category)),
//           Gap(12.h),
//           _buildDetailRow('Service Type', _capitalizeFirstLetter(service.serviceType)),
//           Gap(12.h),
//           _buildDetailRow('Provider', providerName),
//           Gap(12.h),
//           _buildDetailRow('Duration', '${booking.duration} hours'),
//           if (booking.) ...[
//             Gap(12.h),
//             _buildDetailRow('Tools', 'Customer will provide tools'),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildScheduleDetails() {
//     final schedule = booking.schedule;
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Schedule Details',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           Gap(16.h),
//           _buildDetailRow('Day', _capitalizeFirstLetter(schedule.dayOfWeek)),
//           Gap(12.h),
//           _buildDetailRow('Start Time', schedule.startTime),
//           Gap(12.h),
//           if (schedule.recurrence != null)
//             _buildDetailRow('Recurrence', _capitalizeFirstLetter(schedule.recurrence!)),
//           if (schedule.recurrenceEndDate != null) ...[
//             Gap(12.h),
//             _buildDetailRow('End Date', schedule.recurrenceEndDate!),
//           ],
//           Gap(12.h),
//           _buildDetailRow('Timezone', schedule.timezone ?? 'Africa/Cairo'),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddressDetails() {
//     final address = booking.address;
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Address Details',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           Gap(16.h),
//           _buildDetailRow('Street', address.street),
//           Gap(12.h),
//           _buildDetailRow('City', address.city),
//           Gap(12.h),
//           _buildDetailRow('State', address.state),
//           if (address.zipCode != null) ...[
//             Gap(12.h),
//             _buildDetailRow('Zip Code', address.zipCode!),
//           ],
//           Gap(12.h),
//           _buildDetailRow(
//             'Coordinates',
//             '${address.latitude.toStringAsFixed(6)}, ${address.longitude.toStringAsFixed(6)}',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentMethod() {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Payment Information',
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey.shade800,
//             ),
//           ),
//           Gap(16.h),
//           _buildDetailRow('Payment Method', 'Cash on Delivery'),
//           Gap(12.h),
//           _buildDetailRow('Payment Status', 'Pending'),
//           Gap(12.h),
//           _buildDetailRow('Booking Status', 'Confirmed'),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Colors.grey.shade200)),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: OutlinedButton(
//               onPressed: () {
//                 // Navigate to home or bookings list
//                 Navigator.popUntil(context, (route) => route.isFirst);
//               },
//               style: OutlinedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 side: BorderSide(color: AppColors.primary),
//               ),
//               child: Text(
//                 'Back to Home',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: AppColors.primary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//           Gap(12.w),
//           Expanded(
//             child: AppFilledButton(
//               onPressed: () {
//                 // View booking details or track status
//                 // navigateTo(context, BookingDetailsScreen(booking: booking));
//               },
//               fontSize: 16,
//               text: "View Booking",
//               // backgroundColor: AppColors.primary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAmountRow(String label, String value, {bool isTotal = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 16.sp : 14.sp,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
//             color: isTotal ? Colors.grey.shade800 : Colors.grey.shade600,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 18.sp : 14.sp,
//             fontWeight: FontWeight.bold,
//             color: isTotal ? AppColors.primary : Colors.grey.shade800,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Text(
//             '$label:',
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ),
//         Gap(8.w),
//         Expanded(
//           flex: 3,
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey.shade800,
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }

//   String _capitalizeFirstLetter(String text) {
//     if (text.isEmpty) return text;
//     return text[0].toUpperCase() + text.substring(1);
//   }
// }

// // Update your booking creation flow to navigate to this screen:
// void _navigateToBookingSummary(BuildContext context, {
//   required UserBookingModel booking,
//   required ServiceModel service,
//   required String providerName,
// }) {
//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ReviewBookingSummaryScreen(
//         booking: booking,
//         service: service,
//         providerName: providerName,
//       ),
//     ),
//   );
// }

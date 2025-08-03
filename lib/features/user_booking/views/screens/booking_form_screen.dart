// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/app_const.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
// import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
// import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
// import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
// import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
// import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/phone_text_field.dart';
// import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
// import 'package:mahu_home_services_app/features/user_booking/views/screens/select_rooms_screen.dart';
// import 'package:mahu_home_services_app/features/user_booking/views/widgets/date_and_time_form_filed_widget.dart';

// class BookingFormScreen extends StatelessWidget {
//   const BookingFormScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Booking Form'),
//         centerTitle: true,
//         leading: const BackButton(
//           style: ButtonStyle(),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Padding(
//                   padding: EdgeInsets.all(AppConst.appPadding.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomTextField(
//                         label: 'Name',
//                         hint: 'Enter Name',
//                         keyboardType: TextInputType.name,
//                         controller: TextEditingController(),
//                         validator: FormValidationMethod.validateEmail,
//                       ),
//                       Gap(10.h),
//                       CustomTextField(
//                         label: 'Email',
//                         hint: 'Enter Email Address',
//                         keyboardType: TextInputType.emailAddress,
//                         controller: TextEditingController(),
//                         validator: FormValidationMethod.validateEmail,
//                       ),
//                       Gap(10.h),
//                       DateAndTimeFormFiledWidget(isDateNotTime: true),
//                       Gap(10.h),
//                       DateAndTimeFormFiledWidget(isDateNotTime: false),
//                       Gap(10.h),
//                       const AppFieledLabelText(label: 'Additional Notes'),
//                       TextFormField(
//                         controller: TextEditingController(),
//                         keyboardType: TextInputType.name,
//                         maxLines: 5,
//                         decoration: InputDecoration(
//                           hintText: 'Add Note',
//                           hintStyle: TextStyle(
//                             height: 4,
//                             color: Colors.black.withOpacity(.5),
//                             fontWeight: FontWeight.w400,
//                             fontSize: 13.sp,
//                           ),
//                           filled: true,
//                           fillColor: AppColors.greyBack,
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: 24.w,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 const BorderSide(color: Colors.red, width: 1),
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       AppFilledButton(
//                         onPressed: () {
//                           navigateTo(context, const SelectRoomsScreen());
//                         },
//                         fontSize: 15,
//                         text: "Continue",
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dp;
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key, required this.serviceID});
  final String serviceID;
  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  String? selectedService;
  String? selectedRecurrence;

  @override
  Widget build(BuildContext context) {
    var cubit = UserBookingCubit.get(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Create Booking')),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is CreateUserBookingSuccess) {
            showCustomSnackBar(
              context: context,
              message: 'Success',
              type: SnackBarType.success,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CreateUserBookingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CreateUserBookingError) {
            return const Center(
              child: Text('Error loading services'),
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _label(''),
                // const AppFieledLabelText(label: 'Select Service'),
                // DropdownButtonFormField<String>(
                //   decoration: _inputDecoration(),
                //   value: selectedService,
                //   items: const [
                //     DropdownMenuItem(
                //         value: '6870366c9ee099357428ac64',
                //         child: Text('Monthly Maintenance')),
                //     DropdownMenuItem(
                //         value: '6870404f257cf42010849c95',
                //         child: Text('Deep Cleaning')),
                //   ],
                //   onChanged: (val) => setState(() => selectedService = val),
                // ),
                // Gap(16.h),
                // _label('Start Date'),
                GestureDetector(
                  onTap: () => _pickDateTime(startDateController),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      label: 'Start Date',
                      hint: 'Select start date',
                      controller: startDateController,
                      validator: (_) => null,
                    ),
                  ),
                ),
                Gap(16.h),
                // _label('End Date (Optional)'),
                GestureDetector(
                  onTap: () => _pickDateTime(endDateController),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      label: 'End Date (Optional)',
                      hint: 'Select end date',
                      controller: endDateController,
                      validator: (_) => null,
                    ),
                  ),
                ),
                Gap(16.h),
                const AppFieledLabelText(label: 'Recurrence'),
                // _label('Recurrence'),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration(),
                  value: selectedRecurrence,
                  items: const [
                    DropdownMenuItem(value: 'once', child: Text('One Time')),
                    DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                    DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                  ],
                  onChanged: (val) => setState(() => selectedRecurrence = val),
                ),
                Gap(16.h),
                // _label('Street'),
                CustomTextField(
                  label: 'Address',
                  hint: 'Street Address',
                  controller: streetController,
                  validator: (_) => null,
                ),
                Gap(12.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '',
                        hasLabel: false,
                        hint: 'City',
                        controller: cityController,
                        validator: (_) => null,
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: CustomTextField(
                        label: '',
                        hasLabel: false,
                        hint: 'State',
                        controller: stateController,
                        validator: (_) => null,
                      ),
                    ),
                  ],
                ),
                Gap(12.h),
                CustomTextField(
                  label: '',
                  hasLabel: false,
                  hint: 'Zip Code (optional)',
                  controller: zipCodeController,
                  validator: (_) => null,
                ),
                Gap(16.h),
                _label('Additional Details'),
                CustomTextField(
                  label: '',
                  hint: 'E.g. deep cleaning for 3 bedrooms...',
                  controller: detailsController,
                  validator: (_) => null,
                  lines: 3,
                ),
                Gap(32.h),
                AppFilledButton(
                  onPressed: () {
                    UserBookingModel model = UserBookingModel(
                      service: widget.serviceID,
                      schedule: ScheduleModel(
                        startDate: startDateController.text,
                        endDate: endDateController.text,
                        recurrence: selectedRecurrence,
                      ),
                      address: AddressModel(
                        street: streetController.text,
                        city: cityController.text,
                        state: stateController.text,
                      ),
                      details: detailsController.text,
                    );
                    cubit.createBooking(model);
                  },
                  fontSize: 15,
                  text: "Confirm",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _pickDateTime(TextEditingController controller) {
    dp.DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        controller.text = date.toIso8601String();
      },
    );
  }

  Widget _label(String text) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      );

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.greyBack,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:intl/intl.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({
    super.key,
    required this.serviceID,
    required this.service,
  });

  final String serviceID;
  final ServiceModel service;

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  String? _selectedRecurrence;
  String? _selectedDayOfWeek;
  String? _selectedTimeSlot;
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set default recurrence based on service type
    _selectedRecurrence =
        widget.service.serviceType.toLowerCase() == 'recurring'
            ? 'weekly'
            : 'once';
  }

  @override
  Widget build(BuildContext context) {
    var cubit = UserBookingCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Booking'),
        centerTitle: true,
      ),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          if (state is CreateUserBookingSuccess) {
            showCustomSnackBar(
              context: context,
              message: 'Booking created successfully!',
              type: SnackBarType.success,
            );
            Navigator.pop(context);
          }
          if (state is CreateUserBookingError) {
            showCustomSnackBar(
              context: context,
              message: state.failure.message,
              type: SnackBarType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is CreateUserBookingLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Info
                _buildServiceInfo(),
                Gap(24.h),

                // Schedule Section
                Text(
                  'Schedule Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(16.h),

                // Day of Week (only available days)
                const AppFieledLabelText(label: 'Select Day'),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration(),
                  value: _selectedDayOfWeek,
                  items: widget.service.availableDays.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(
                        _capitalizeFirstLetter(day),
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedDayOfWeek = val;
                      _selectedTimeSlot = null;
                      _startTimeController.clear();
                      _endTimeController.clear();
                    });
                  },
                ),
                Gap(12.h),

                // Time Slot Selection (only if day is selected)
                if (_selectedDayOfWeek != null) ...[
                  const AppFieledLabelText(label: 'Select Time Slot'),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    value: _selectedTimeSlot,
                    items: widget.service.availableSlots.map((slot) {
                      final slotText = '${slot.startTime} - ${slot.endTime}';
                      return DropdownMenuItem(
                        value: slotText,
                        child: Text(slotText),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedTimeSlot = val;
                        if (val != null) {
                          final times = val.split(' - ');
                          _startTimeController.text = times[0];
                          _endTimeController.text = times[1];
                        }
                      });
                    },
                  ),
                  Gap(12.h),
                ],

                // Recurrence Type (only for recurring services)
                if (widget.service.serviceType.toLowerCase() ==
                    'recurring') ...[
                  const AppFieledLabelText(label: 'Recurrence Type'),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    value: _selectedRecurrence,
                    items: const [
                      DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                      DropdownMenuItem(
                          value: 'monthly', child: Text('Monthly')),
                    ],
                    onChanged: (val) =>
                        setState(() => _selectedRecurrence = val),
                  ),
                  Gap(12.h),

                  // Start Date for recurrence
                  GestureDetector(
                    onTap: () => _pickDate(_startDateController, 'Start Date'),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        label: 'Start Date',
                        hint: 'Select start date for recurrence',
                        controller: _startDateController,
                        validator: (_) => null,
                      ),
                    ),
                  ),
                  Gap(12.h),

                  // End Date for recurrence
                  GestureDetector(
                    onTap: () => _pickDate(_endDateController, 'End Date'),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        label: 'End Date',
                        hint: 'Select end date for recurrence',
                        controller: _endDateController,
                        validator: (_) => null,
                      ),
                    ),
                  ),
                  Gap(12.h),
                ],

                // Address Section
                Text(
                  'Address Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(16.h),

                CustomTextField(
                  label: 'Street Address',
                  hint: 'Enter street address',
                  controller: _streetController,
                  validator: (_) => null,
                ),
                Gap(12.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'City',
                        hint: 'Enter city',
                        controller: _cityController,
                        validator: (_) => null,
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: CustomTextField(
                        label: 'State',
                        hint: 'Enter state',
                        controller: _stateController,
                        validator: (_) => null,
                      ),
                    ),
                  ],
                ),
                Gap(12.h),

                CustomTextField(
                  label: 'Zip Code',
                  hint: 'Enter zip code',
                  controller: _zipCodeController,
                  validator: (_) => null,
                  keyboardType: TextInputType.number,
                ),
                Gap(12.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Latitude',
                        hint: 'Optional',
                        controller: _latitudeController,
                        validator: (_) => null,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: CustomTextField(
                        label: 'Longitude',
                        hint: 'Optional',
                        controller: _longitudeController,
                        validator: (_) => null,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Gap(16.h),

                // Additional Details
                Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(16.h),

                CustomTextField(
                  label: 'Service Details',
                  hint: 'Describe any specific requirements...',
                  controller: _detailsController,
                  validator: (_) => null,
                  lines: 4,
                ),
                Gap(32.h),

                // Price Display
                _buildPriceDisplay(),
                Gap(16.h),

                // Submit Button
                AppFilledButton(
                  onPressed: _validateAndSubmit,
                  fontSize: 16,
                  text: "Create Booking",
                ),
                Gap(24.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.service.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          Gap(8.h),
          Text(
            'Category: ${_capitalizeFirstLetter(widget.service.category)}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          Gap(4.h),
          Text(
            'Type: ${_capitalizeFirstLetter(widget.service.serviceType)}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          Gap(4.h),
          Text(
            'Duration: ${widget.service.duration} hours',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          Gap(4.h),
          Text(
            'Available Days: ${widget.service.availableDays.map(_capitalizeFirstLetter).join(', ')}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          Text(
            '\$${widget.service.basePrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
        ],
      ),
    );
  }

  void _pickDate(TextEditingController controller, String title) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((date) {
      if (date != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(date);
      }
    });
  }

  void _validateAndSubmit() {
    final cubit = UserBookingCubit.get(context);

    // Validation
    if (_selectedDayOfWeek == null) {
      showCustomSnackBar(
        context: context,
        message: 'Please select a day',
        type: SnackBarType.failure,
      );
      return;
    }

    if (_selectedTimeSlot == null) {
      showCustomSnackBar(
        context: context,
        message: 'Please select a time slot',
        type: SnackBarType.failure,
      );
      return;
    }

    if (_streetController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _stateController.text.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: 'Please fill in all address fields',
        type: SnackBarType.failure,
      );
      return;
    }

    // For recurring services, validate recurrence dates
    if (widget.service.serviceType.toLowerCase() == 'recurring') {
      if (_startDateController.text.isEmpty) {
        showCustomSnackBar(
          context: context,
          message: 'Please select a start date for recurrence',
          type: SnackBarType.failure,
        );
        return;
      }
      if (_endDateController.text.isEmpty) {
        showCustomSnackBar(
          context: context,
          message: 'Please select an end date for recurrence',
          type: SnackBarType.failure,
        );
        return;
      }
    }

    // Prepare address data
    final address = AddressModel(
      street: _streetController.text,
      city: _cityController.text,
      state: _stateController.text,
      zipCode:
          _zipCodeController.text.isNotEmpty ? _zipCodeController.text : null,
      latitude: _latitudeController.text.isNotEmpty
          ? double.tryParse(_latitudeController.text)
          : null,
      longitude: _longitudeController.text.isNotEmpty
          ? double.tryParse(_longitudeController.text)
          : null,
    );

    // Prepare schedule data
    final schedule = ScheduleModel(
      dayOfWeek: _selectedDayOfWeek!,
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      recurrence: _selectedRecurrence,
      recurrenceEndDate:
          _endDateController.text.isNotEmpty ? _endDateController.text : null,
      details:
          _detailsController.text.isNotEmpty ? _detailsController.text : null,
    );

    final bookingModel = UserBookingModel(
      service: widget.serviceID,
      schedule: schedule,
      address: address,
      details: _detailsController.text,
      price: widget.service.basePrice, // Include price from service
    );

    print(bookingModel);

    cubit.createBooking(bookingModel);
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/models/booking_model.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/services/location_service.dart';

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
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  bool _hasTools = false;
  String? _selectedRecurrence;
  String? _selectedDayOfWeek;
  String? _selectedTimeSlot;
  String? _selectedTimezone;

  Position? _currentPosition;
  bool _isLoadingLocation = false;
  bool _locationError = false;
  bool _showMap = false;

  int _selectedDuration = 1;
  double _totalPrice = 0.0;
  TimeOfDay _selectedStartTime =
      TimeOfDay(hour: 8, minute: 0); // Default start time

  // Store the selected slot's start and end times
  TimeOfDay? _slotStartTime;
  TimeOfDay? _slotEndTime;

  // Map controller
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _selectedRecurrence =
        widget.service.serviceType.toLowerCase() == 'recurring'
            ? 'weekly'
            : null;
    _selectedDuration = widget.service.duration.toInt();
    _selectedTimezone = 'Africa/Cairo';
    _calculateTotalPrice();
    _getCurrentLocation();
  }

  void _calculateTotalPrice() {
    setState(() {
      if (widget.service.pricingModel == 'hourly') {
        _totalPrice = widget.service.basePrice * _selectedDuration;
      } else {
        _totalPrice = widget.service.basePrice;
      }
    });
  }

  // Parse time string (HH:mm) to TimeOfDay
  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  // Format TimeOfDay to HH:mm string
  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  // Check if a time is within the selected slot
  bool _isTimeWithinSlot(TimeOfDay time) {
    if (_slotStartTime == null || _slotEndTime == null) return false;

    final totalMinutes = time.hour * 60 + time.minute;
    final slotStartMinutes = _slotStartTime!.hour * 60 + _slotStartTime!.minute;
    final slotEndMinutes = _slotEndTime!.hour * 60 + _slotEndTime!.minute;

    return totalMinutes >= slotStartMinutes && totalMinutes <= slotEndMinutes;
  }

  // Get available time steps within the slot (30-minute intervals)
  List<TimeOfDay> _getAvailableTimeSteps() {
    if (_slotStartTime == null || _slotEndTime == null) return [];

    final steps = <TimeOfDay>[];
    var currentTime = _slotStartTime!;
    final slotStartMinutes = _slotStartTime!.hour * 60 + _slotStartTime!.minute;
    final slotEndMinutes = _slotEndTime!.hour * 60 + _slotEndTime!.minute;

    while (true) {
      final currentMinutes = currentTime.hour * 60 + currentTime.minute;
      if (currentMinutes > slotEndMinutes) break;

      steps.add(currentTime);

      // Add 30 minutes
      var newMinutes = currentTime.minute + 30;
      var newHour = currentTime.hour;
      if (newMinutes >= 60) {
        newHour++;
        newMinutes -= 60;
      }
      currentTime = TimeOfDay(hour: newHour, minute: newMinutes);
    }

    return steps;
  }

  // Get current time step index
  int _getCurrentTimeStepIndex() {
    final steps = _getAvailableTimeSteps();
    for (int i = 0; i < steps.length; i++) {
      if (steps[i].hour == _selectedStartTime.hour &&
          steps[i].minute == _selectedStartTime.minute) {
        return i;
      }
    }
    return 0;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _locationError = false;
      _showMap = false; // hide map until location is fetched
    });

    try {
      final position = await LocationService.getCurrentLocation();

      if (position != null) {
        _currentPosition = position;

        // Small delay to ensure FlutterMap has been built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapController.move(
            LatLng(position.latitude, position.longitude),
            15.0,
          );
          setState(() {
            _showMap = true; // show map after centering
          });
        });
      } else {
        _locationError = true;
      }
    } catch (e) {
      _locationError = true;
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
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
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Info
                _buildServiceInfo(),
                Gap(24.h),

                // Location Section with Map Toggle
                _buildLocationSection(),
                Gap(16.h),

                // Map View (conditionally shown)
                if (_showMap && _currentPosition != null) ...[
                  _buildMapView(),
                  Gap(16.h),
                ],

                // Duration Selection with Stepper (only for hourly pricing)
                if (widget.service.pricingModel == 'hourly') ...[
                  _buildDurationSelector(),
                  Gap(24.h),
                ],

                // Timezone Selection
                const AppFieledLabelText(label: 'Timezone'),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration(),
                  value: _selectedTimezone,
                  items: const [
                    DropdownMenuItem(
                        value: 'Africa/Cairo', child: Text('Egypt (Cairo)')),
                    DropdownMenuItem(
                        value: 'Asia/Dubai', child: Text('UAE (Dubai)')),
                  ],
                  onChanged: (val) => setState(() => _selectedTimezone = val),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a timezone';
                    }
                    return null;
                  },
                ),
                Gap(12.h),

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

                // Day of Week
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
                      _slotStartTime = null;
                      _slotEndTime = null;
                      _selectedStartTime = TimeOfDay(hour: 8, minute: 0);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a day';
                    }
                    return null;
                  },
                ),
                Gap(12.h),

                // Time Slot Selection
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
                        // Parse the selected slot times
                        if (val != null) {
                          final times = val.split(' - ');
                          _slotStartTime = _parseTime(times[0]);
                          _slotEndTime = _parseTime(times[1]);
                          // Set initial start time to the slot's start time
                          _selectedStartTime = _slotStartTime!;
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a time slot';
                      }
                      return null;
                    },
                  ),
                  Gap(12.h),
                ],

                // Start Time Selection (only show when time slot is selected)
                if (_selectedTimeSlot != null) ...[
                  const AppFieledLabelText(label: 'Start Time'),
                  _buildStartTimeSelector(),
                  Gap(12.h),
                ],

                // Recurrence for recurring services
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
                    validator: (value) {
                      if (value == null) {
                        return 'Please select recurrence type';
                      }
                      return null;
                    },
                  ),
                  Gap(12.h),

                  // Start and End Dates for recurrence
                  GestureDetector(
                    onTap: () => _pickDate(_startDateController, 'Start Date'),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        label: 'Start Date',
                        hint: 'Select start date for recurrence',
                        controller: _startDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Start date is required';
                          }
                          return null;
                        },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Street address is required';
                    }
                    return null;
                  },
                ),
                Gap(12.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'City',
                        hint: 'Enter city',
                        controller: _cityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: CustomTextField(
                        label: 'State',
                        hint: 'Enter state',
                        controller: _stateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'State is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Gap(12.h),

                CustomTextField(
                  label: 'Zip Code (Optional)',
                  hint: 'Enter zip code',
                  controller: _zipCodeController,
                  validator: (_) => null,
                  keyboardType: TextInputType.number,
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

                const AppFieledLabelText(
                    label: 'Do you have tools for this service?'),
                SwitchListTile(
                  value: _hasTools,
                  activeColor: AppColors.primary,
                  activeTrackColor: AppColors.primary.withOpacity(0.5),
                  onChanged: (val) {
                    setState(() {
                      _hasTools = val;
                    });
                  },
                  title: const Text('I have the required tools'),
                  subtitle:
                      const Text('If not, the provider will bring their own'),
                ),
                Gap(16.h),

                CustomTextField(
                  label: 'Service Details (Optional)',
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
                  // isLoading: state is CreateUserBookingLoading,
                ),
                Gap(24.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapView() {
    if (_currentPosition == null) return SizedBox.shrink();

    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15.0,
            interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            onMapReady: () {
              // Ensure map is centered after ready
              _mapController.move(
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                15.0,
              );
            },
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.mahu_home_services_app',
            ),
            CurrentLocationLayer(),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  width: 40.w,
                  height: 40.h,
                  child: Icon(
                    Icons.location_pin,
                    color: AppColors.primary,
                    size: 40.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartTimeSelector() {
    final timeSteps = _getAvailableTimeSteps();
    final currentIndex = _getCurrentTimeStepIndex();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Start Time:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _formatTime(_selectedStartTime),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Gap(16.h),
          if (timeSteps.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous Time Button
                _buildTimeButton(
                  icon: Icons.arrow_back,
                  onPressed: currentIndex > 0
                      ? () {
                          setState(() {
                            _selectedStartTime = timeSteps[currentIndex - 1];
                          });
                        }
                      : null,
                ),

                // Time Display
                Container(
                  width: 100.w,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Text(
                    _formatTime(_selectedStartTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                // Next Time Button
                _buildTimeButton(
                  icon: Icons.arrow_forward,
                  onPressed: currentIndex < timeSteps.length - 1
                      ? () {
                          setState(() {
                            _selectedStartTime = timeSteps[currentIndex + 1];
                          });
                        }
                      : null,
                ),
              ],
            ),
            Gap(8.h),
            Text(
              'Available time slot: ${_formatTime(_slotStartTime!)} - ${_formatTime(_slotEndTime!)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              '30-minute intervals',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ] else if (_selectedTimeSlot != null) ...[
            Text(
              'No available time steps in this slot',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeButton({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: onPressed != null ? AppColors.primary : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        splashRadius: 24.w,
      ),
    );
  }

  Widget _buildDurationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieledLabelText(label: 'Duration (hours)'),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Duration:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$_selectedDuration hours',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Decrement Button
                  _buildDurationButton(
                    icon: Icons.remove,
                    onPressed: _selectedDuration > widget.service.duration
                        ? () {
                            setState(() {
                              _selectedDuration--;
                              _calculateTotalPrice();
                            });
                          }
                        : null,
                  ),

                  // Duration Display
                  Container(
                    width: 60.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      '$_selectedDuration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  // Increment Button
                  _buildDurationButton(
                    icon: Icons.add,
                    onPressed: () {
                      setState(() {
                        _selectedDuration++;
                        _calculateTotalPrice();
                      });
                    },
                  ),
                ],
              ),
              Gap(8.h),
              Text(
                'Minimum: ${widget.service.duration} hours',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDurationButton(
      {required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: onPressed != null ? AppColors.primary : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        splashRadius: 24.w,
      ),
    );
  }

  Widget _buildLocationSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _locationError ? Colors.red.shade50 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _locationError ? Icons.error_outline : Icons.location_on,
                color: _locationError ? Colors.red : Colors.blue,
              ),
              Gap(8.w),
              Text(
                'Your Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _locationError ? Colors.red : Colors.blue.shade800,
                ),
              ),
              Spacer(),
              if (_isLoadingLocation)
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              if (!_isLoadingLocation && _locationError)
                IconButton(
                  icon: Icon(Icons.refresh, size: 20),
                  onPressed: _getCurrentLocation,
                ),
              if (!_isLoadingLocation && !_locationError)
                IconButton(
                  icon: Icon(
                    _showMap ? Icons.map_outlined : Icons.map,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _showMap = !_showMap;
                    });
                  },
                ),
            ],
          ),
          Gap(8.h),
          if (_isLoadingLocation)
            Text('Getting your location...', style: TextStyle(fontSize: 14)),
          if (!_isLoadingLocation && _currentPosition != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latitude: ${_currentPosition!.latitude.toStringAsFixed(6)}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Longitude: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Accuracy: ±${_currentPosition!.accuracy.toStringAsFixed(2)} meters',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                if (!_showMap)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showMap = true;
                      });
                    },
                    child: Text(
                      'Show on map',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
              ],
            ),
          if (!_isLoadingLocation && _locationError)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unable to get your location. Please enable location services.',
                  style: TextStyle(fontSize: 14, color: Colors.red.shade700),
                ),
                Gap(8.h),
                Text(
                  'Location is required for service booking.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildServiceInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
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
              color: Colors.green.shade800,
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
            'Pricing: \$${widget.service.basePrice.toStringAsFixed(2)}/${widget.service.pricingModel == 'hourly' ? 'hour' : 'service'}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          Gap(4.h),
          Text(
            'Minimum Duration: ${widget.service.duration} hours',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          if (widget.service.pricingModel == 'fixed') ...[
            Gap(4.h),
            Text(
              '⚠️ Fixed price - duration cannot be changed',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceDisplay() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pricing Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade800,
            ),
          ),
          Gap(12.h),
          if (widget.service.pricingModel == 'hourly') ...[
            _buildPriceRow('Hourly Rate:',
                '\$${widget.service.basePrice.toStringAsFixed(2)}/hour'),
            _buildPriceRow('Duration:', '$_selectedDuration hours'),
            Divider(height: 16.h, color: Colors.orange.shade300),
          ],
          _buildPriceRow(
            'Total Price:',
            '\$${_totalPrice.toStringAsFixed(2)}',
            isTotal: true,
          ),
          if (widget.service.pricingModel == 'fixed') ...[
            Gap(8.h),
            Text(
              '* Fixed price for the entire service',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? Colors.orange.shade800 : Colors.grey.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              color: isTotal ? Colors.orange.shade800 : Colors.grey.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
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
        setState(() {
          controller.text = date.toIso8601String().split('T')[0];
        });
      }
    });
  }

  void _validateAndSubmit() {
    final cubit = UserBookingCubit.get(context);

    // Validate location
    if (_currentPosition == null) {
      showCustomSnackBar(
        context: context,
        message: 'Please enable location services to continue',
        type: SnackBarType.failure,
      );
      return;
    }

    // Validate duration (only for hourly pricing)
    if (widget.service.pricingModel == 'hourly' &&
        _selectedDuration < widget.service.duration) {
      showCustomSnackBar(
        context: context,
        message: 'Duration must be at least ${widget.service.duration} hours',
        type: SnackBarType.failure,
      );
      return;
    }

    // Validate time slot selection
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

    // Validate start time is within selected slot
    if (!_isTimeWithinSlot(_selectedStartTime)) {
      showCustomSnackBar(
        context: context,
        message: 'Selected start time must be within the chosen time slot',
        type: SnackBarType.failure,
      );
      return;
    }

    // Validate address fields
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

    // For recurring services - validate recurrence fields
    if (widget.service.serviceType.toLowerCase() == 'recurring') {
      if (_selectedRecurrence == null) {
        showCustomSnackBar(
          context: context,
          message: 'Please select recurrence type',
          type: SnackBarType.failure,
        );
        return;
      }
    }

    // Create booking request according to server expectations
    final bookingRequest = {
      "service": widget.serviceID,
      "provider": widget.service.provider,
      "serviceType": widget.service.serviceType,
      "duration": _selectedDuration,
      "options": {
        "hasTools": _hasTools,
      },
      "schedule": {
        "dayOfWeek": _selectedDayOfWeek!.toLowerCase(),
        "startTime": _formatTime(_selectedStartTime),
        "timezone": _selectedTimezone ?? 'Africa/Cairo',
      },
      "address": {
        "street": _streetController.text,
        "city": _cityController.text,
        "state": _stateController.text,
        if (_zipCodeController.text.isNotEmpty)
          "zipCode": _zipCodeController.text,
        "latitude": _currentPosition!.latitude,
        "longitude": _currentPosition!.longitude,
      },
      if (_detailsController.text.isNotEmpty)
        "details": _detailsController.text,
    };

    // Add recurrence fields for recurring services
    if (widget.service.serviceType.toLowerCase() == 'recurring') {
      (bookingRequest['schedule'] as Map<String, dynamic>)['recurrence'] =
          _selectedRecurrence;
      // (bookingRequest['schedule'] as Map<String, dynamic>)['recurrenceEndDate'] = _endDateController.text;
    }

    print('Final booking request: $bookingRequest');

    cubit.createBooking(bookingRequest);
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

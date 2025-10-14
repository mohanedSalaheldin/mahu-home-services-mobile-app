import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
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
import 'package:mahu_home_services_app/generated/l10n.dart';

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

  final bool _hasTools = false;
  String? _selectedRecurrence;
  String? _selectedDayOfWeek;
  String? _selectedTimeSlot;
  String? _selectedTimezone;

  Position? _currentPosition;
  bool _isLoadingLocation = false;
  bool _locationError = false;
  bool _showMap = false;
  String _locationAddress = '';
  String? _country; // New field for country
  final List<String> selectedOptions = [];

  int _selectedDuration = 1;
  double _totalPrice = 0.0;
  TimeOfDay _selectedStartTime = const TimeOfDay(hour: 8, minute: 0);

  TimeOfDay? _slotStartTime;
  TimeOfDay? _slotEndTime;

  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _selectedRecurrence =
        widget.service.serviceType.toLowerCase() == 'recurring'
            ? widget.service.subType
            : null;
    _selectedDuration = widget.service.duration.toInt();
    _selectedTimezone = 'Africa/Cairo';
    _selectedDayOfWeek = getNextAvailableDay(widget.service.availableDays);
    if (widget.service.availableSlots.isNotEmpty) {
      final firstSlot = widget.service.availableSlots.first;
      _selectedTimeSlot = '0-${firstSlot.startTime} - ${firstSlot.endTime}';
      _slotStartTime = _parseTime(firstSlot.startTime);
      _slotEndTime = _parseTime(firstSlot.endTime);
      _selectedStartTime = _slotStartTime!;
    }
    _calculateTotalPrice();
    _getCurrentLocation();
  }

  String? getNextAvailableDay(List<String> availableDays) {
    if (availableDays.isEmpty) return null;

    DateTime now = DateTime.now();
    int currentDayIndex = now.weekday;

    List<String> weekDays = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];

    List<String> availableDaysLower =
        availableDays.map((day) => day.toLowerCase()).toList();

    for (int i = 1; i <= 7; i++) {
      int targetDayIndex = ((currentDayIndex - 1 + i) % 7);
      String targetDay = weekDays[targetDayIndex];

      if (availableDaysLower.contains(targetDay)) {
        int originalIndex = availableDaysLower.indexOf(targetDay);
        return availableDays[originalIndex];
      }
    }

    return null;
  }

  void _calculateTotalPrice() {
    setState(() {
      double optionsTotal = 0.0;
      for (var optionId in selectedOptions) {
        final option = widget.service.options.firstWhere(
          (opt) => opt.id == optionId,
          orElse: () =>
              ServiceOption(id: '', name: '', description: '', price: 0.0),
        );
        optionsTotal += option.price;
      }
      if (widget.service.pricingModel == 'hourly') {
        _totalPrice =
            (widget.service.basePrice * _selectedDuration) + optionsTotal;
      } else {
        _totalPrice = widget.service.basePrice + optionsTotal;
      }
    });
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  bool _isTimeWithinSlot(TimeOfDay time) {
    if (_slotStartTime == null || _slotEndTime == null) return false;

    final totalMinutes = time.hour * 60 + time.minute;
    final slotStartMinutes = _slotStartTime!.hour * 60 + _slotStartTime!.minute;
    final slotEndMinutes = _slotEndTime!.hour * 60 + _slotEndTime!.minute;

    return totalMinutes >= slotStartMinutes && totalMinutes <= slotEndMinutes;
  }

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

  List<dynamic> _getUniqueTimeSlots() {
    final seen = <String>{};
    final uniqueSlots = <dynamic>[];
    for (var slot in widget.service.availableSlots) {
      final slotText = '${slot.startTime} - ${slot.endTime}';
      if (seen.add(slotText)) {
        uniqueSlots.add(slot);
      }
    }
    return uniqueSlots;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _locationError = false;
      _showMap = false;
      _locationAddress = '';
    });

    try {
      final position = await LocationService.getCurrentLocation();

      if (position != null) {
        _currentPosition = position;

        List<Placemark> place = await LocationService.getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );

        final address = place.isNotEmpty
            ? '${place.first.street}, ${place.first.locality}, ${place.first.country}'
            : S.of(context).bookingFormScreenUnknownLocation;
        setState(() {
          _locationAddress =
              address ?? S.of(context).bookingFormScreenCurrentLocation;
          _streetController.text =
              place.isNotEmpty ? place.first.street ?? '' : '';
          _cityController.text =
              place.isNotEmpty ? place.first.locality ?? '' : '';
          _stateController.text =
              place.isNotEmpty ? place.first.administrativeArea ?? '' : '';
          _zipCodeController.text =
              place.isNotEmpty ? place.first.postalCode ?? '' : '';
          _country = place.isNotEmpty
              ? place.first.country?.toLowerCase() ?? 'egypt'
              : 'egypt';
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mapController.move(
            LatLng(position.latitude, position.longitude),
            15.0,
          );
          setState(() {
            _showMap = true;
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
        title: Text(S.of(context).bookingFormScreenTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          if (state is CreateUserBookingSuccess) {
            showCustomSnackBar(
              context: context,
              message: S.of(context).bookingFormScreenSuccessMessage,
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
                _buildServiceInfo(),
                Gap(24.h),
                _buildLocationSection(),
                Gap(16.h),
                if (_showMap && _currentPosition != null) ...[
                  _buildMapView(),
                  Gap(16.h),
                ],
                if (widget.service.pricingModel == 'hourly') ...[
                  _buildDurationSelector(),
                  Gap(24.h),
                ],
                AppFieledLabelText(
                    label: S.of(context).bookingFormScreenTimezoneLabel),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration(),
                  value: _selectedTimezone,
                  items: [
                    DropdownMenuItem(
                      value: 'Africa/Cairo',
                      child: Text(S.of(context).bookingFormScreenTimezoneEgypt),
                    ),
                    DropdownMenuItem(
                      value: 'Asia/Dubai',
                      child: Text(S.of(context).bookingFormScreenTimezoneUae),
                    ),
                  ],
                  onChanged: (val) => setState(() => _selectedTimezone = val),
                  validator: (value) {
                    if (value == null) {
                      return S.of(context).bookingFormScreenTimezoneError;
                    }
                    return null;
                  },
                ),
                Gap(16.h),
                Text(
                  S.of(context).bookingFormScreenScheduleSection,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(16.h),
                AppFieledLabelText(
                    label: S.of(context).bookingFormScreenDayLabel),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration(),
                  value: _selectedDayOfWeek,
                  items: widget.service.availableDays.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(
                        _capitalizeFirstLetter(day),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedDayOfWeek = val;
                      _selectedTimeSlot = null;
                      _slotStartTime = null;
                      _slotEndTime = null;
                      _selectedStartTime = const TimeOfDay(hour: 8, minute: 0);
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return S.of(context).bookingFormScreenDayError;
                    }
                    return null;
                  },
                ),
                Gap(12.h),
                if (_selectedDayOfWeek != null) ...[
                  AppFieledLabelText(
                      label: S.of(context).bookingFormScreenTimeSlotLabel),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    value: _selectedTimeSlot,
                    items: widget.service.availableSlots
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      var slot = entry.value;
                      final slotText = '${slot.startTime} - ${slot.endTime}';
                      return DropdownMenuItem(
                        value: '$index-$slotText',
                        child: Text(slotText),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedTimeSlot = val;
                        if (val != null) {
                          final index = int.parse(val.split('-')[0]);
                          final slot = widget.service.availableSlots[index];
                          _slotStartTime = _parseTime(slot.startTime);
                          _slotEndTime = _parseTime(slot.endTime);
                          _selectedStartTime = _slotStartTime!;
                        }
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).bookingFormScreenTimeSlotError;
                      }
                      return null;
                    },
                  ),
                  Gap(12.h),
                ],
                if (_selectedTimeSlot != null) ...[
                  AppFieledLabelText(
                      label: S.of(context).bookingFormScreenStartTimeLabel),
                  _buildStartTimeSelector(),
                  Gap(12.h),
                ],
                if (widget.service.serviceType.toLowerCase() ==
                    'recurring') ...[
                  AppFieledLabelText(
                      label: S.of(context).bookingFormScreenRecurrenceLabel),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.repeat,
                            color: AppColors.primary, size: 20.w),
                        Gap(8.w),
                        Expanded(
                          child: Text(
                            _capitalizeFirstLetter(_selectedRecurrence ?? ''),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Icon(Icons.lock,
                            color: Colors.grey.shade400, size: 18.w),
                      ],
                    ),
                  ),
                  Gap(12.h),
                  GestureDetector(
                    onTap: () => _pickDate(_startDateController,
                        S.of(context).bookingFormScreenStartDateLabel),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        label: S.of(context).bookingFormScreenStartDateLabel,
                        hint: widget.service.serviceType.toLowerCase() ==
                                'recurring'
                            ? S
                                .of(context)
                                .bookingFormScreenStartDateRecurringHint
                            : S.of(context).bookingFormScreenStartDateHint,
                        controller: _startDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S
                                .of(context)
                                .bookingFormScreenStartDateError;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Gap(12.h),
                ],
                Text(
                  S.of(context).bookingFormScreenAddressSection,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(16.h),
                CustomTextField(
                  label: S.of(context).bookingFormScreenStreetLabel,
                  hint: S.of(context).bookingFormScreenStreetHint,
                  controller: _streetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).bookingFormScreenStreetError;
                    }
                    return null;
                  },
                ),
                Gap(12.h),
                CustomTextField(
                  label: S.of(context).bookingFormScreenCityLabel,
                  hint: S.of(context).bookingFormScreenCityHint,
                  controller: _cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).bookingFormScreenCityError;
                    }
                    return null;
                  },
                ),
                Gap(12.w),
                CustomTextField(
                  label: S.of(context).bookingFormScreenStateLabel,
                  hint: S.of(context).bookingFormScreenStateHint,
                  controller: _stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).bookingFormScreenStateError;
                    }
                    return null;
                  },
                ),
                Gap(12.h),
                CustomTextField(
                  label: S.of(context).bookingFormScreenZipCodeLabel,
                  hint: S.of(context).bookingFormScreenZipCodeHint,
                  controller: _zipCodeController,
                  validator: (_) => null,
                  keyboardType: TextInputType.number,
                ),
                Gap(16.h),
                Text(
                  S.of(context).bookingFormScreenAdditionalInfoSection,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(16.h),
                AppFieledLabelText(
                    label: S.of(context).bookingFormScreenToolsLabel),
                ListView(
                  shrinkWrap: true,
                  children: widget.service.options.map((option) {
                    final isSelected = selectedOptions.contains(option.id);
                    return SwitchListTile(
                      value: isSelected,
                      activeColor: AppColors.primary,
                      activeTrackColor: AppColors.primary.withOpacity(0.5),
                      onChanged: (val) {
                        setState(() {
                          if (val) {
                            selectedOptions.add(option.id);
                          } else {
                            selectedOptions.remove(option.id);
                          }
                          _calculateTotalPrice();
                        });
                      },
                      title: Text(
                          '${option.name} (+${option.price.toStringAsFixed(2)})'),
                      subtitle: Text(option.description),
                    );
                  }).toList(),
                ),
                Gap(16.h),
                CustomTextField(
                  label: S.of(context).bookingFormScreenDetailsLabel,
                  hint: S.of(context).bookingFormScreenDetailsHint,
                  controller: _detailsController,
                  validator: (_) => null,
                  lines: 4,
                ),
                Gap(32.h),
                _buildPriceDisplay(),
                Gap(16.h),
                AppFilledButton(
                  onPressed: _validateAndSubmit,
                  fontSize: 16,
                  text: S.of(context).bookingFormScreenSubmitButton,
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
    if (_currentPosition == null) return const SizedBox.shrink();

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
                S.of(context).bookingFormScreenStartTimeSelectorLabel,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _formatTime(_selectedStartTime),
                style: TextStyle(
                  fontSize: 18.sp,
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
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
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
              S.of(context).bookingFormScreenTimeSlotInfo(
                  _formatTime(_slotStartTime!), _formatTime(_slotEndTime!)),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
            Text(
              S.of(context).bookingFormScreenTimeIntervalInfo,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
          ] else if (_selectedTimeSlot != null) ...[
            Text(
              S.of(context).bookingFormScreenNoTimeSteps,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
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
        icon: Icon(icon, color: Colors.white, size: 20.w),
        onPressed: onPressed,
        splashRadius: 24.w,
      ),
    );
  }

  Widget _buildDurationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFieledLabelText(label: S.of(context).bookingFormScreenDurationLabel),
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
                    S.of(context).bookingFormScreenDurationSelectorLabel,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    S
                        .of(context)
                        .bookingFormScreenDurationValue(_selectedDuration),
                    style: TextStyle(
                      fontSize: 18.sp,
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
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
                S
                    .of(context)
                    .bookingFormScreenDurationMinimum(widget.service.duration),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
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
        icon: Icon(icon, color: Colors.white, size: 20.w),
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
        border: Border.all(
          color: _locationError ? Colors.red.shade300 : Colors.blue.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _locationError ? Icons.error_outline : Icons.location_on,
                color: _locationError ? Colors.red : AppColors.primary,
                size: 24.w,
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  S.of(context).bookingFormScreenLocationLabel,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: _locationError ? Colors.red : Colors.blue.shade800,
                  ),
                ),
              ),
              if (_isLoadingLocation)
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              if (!_isLoadingLocation && _locationError)
                IconButton(
                  icon: Icon(Icons.refresh, size: 20.w),
                  onPressed: _getCurrentLocation,
                  color: Colors.red,
                ),
              if (!_isLoadingLocation && !_locationError)
                IconButton(
                  icon: Icon(
                    _showMap ? Icons.map_outlined : Icons.map,
                    color: AppColors.primary,
                    size: 20.w,
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
            Text(S.of(context).bookingFormScreenLoadingLocation,
                style: TextStyle(fontSize: 14.sp)),
          if (!_isLoadingLocation && _currentPosition != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_locationAddress.isNotEmpty) ...[
                  Text(
                    _locationAddress,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Gap(4.h),
                ],
                Text(
                  S.of(context).bookingFormScreenLocationAccuracy(
                      _currentPosition!.accuracy.toStringAsFixed(2)),
                  style:
                      TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
                if (!_showMap)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showMap = true;
                      });
                    },
                    child: Text(
                      S.of(context).bookingFormScreenShowMap,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            ),
          if (!_isLoadingLocation && _locationError)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).bookingFormScreenLocationError,
                  style: TextStyle(fontSize: 14.sp, color: Colors.red.shade700),
                ),
                Gap(8.h),
                Text(
                  S.of(context).bookingFormScreenLocationRequired,
                  style:
                      TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
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
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.construction,
                  color: Colors.green.shade700, size: 24.w),
              Gap(8.w),
              Expanded(
                child: Text(
                  widget.service.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          _buildServiceDetailRow(
            S.of(context).bookingFormScreenCategoryLabel,
            _capitalizeFirstLetter(widget.service.category),
          ),
          _buildServiceDetailRow(
            S.of(context).bookingFormScreenTypeLabel,
            _capitalizeFirstLetter(widget.service.serviceType),
          ),
          _buildServiceDetailRow(
            S.of(context).bookingFormScreenPricingLabel,
            S.of(context).bookingFormScreenPricingValue(
                  widget.service.basePrice.toStringAsFixed(2),
                  widget.service.pricingModel == 'hourly' ? 'hour' : 'service',
                ),
          ),
          _buildServiceDetailRow(
            S.of(context).bookingFormScreenMinDurationLabel,
            S
                .of(context)
                .bookingFormScreenDurationValue(widget.service.duration),
          ),
          if (widget.service.pricingModel == 'fixed') ...[
            Gap(8.h),
            Row(
              children: [
                Icon(Icons.info, size: 16.w, color: Colors.orange.shade700),
                Gap(4.w),
                Expanded(
                  child: Text(
                    S.of(context).bookingFormScreenFixedPriceNote,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildServiceDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay() {
    double optionsTotal = 0.0;
    List<Map<String, dynamic>> selectedOptionDetails = [];
    for (var optionId in selectedOptions) {
      final option = widget.service.options.firstWhere(
        (opt) => opt.id == optionId,
        orElse: () =>
            ServiceOption(id: '', name: '', description: '', price: 0.0),
      );
      optionsTotal += option.price;
      selectedOptionDetails.add({
        'name': option.name,
        'price': option.price,
      });
    }

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
          Row(
            children: [
              Icon(Icons.attach_money,
                  color: Colors.orange.shade700, size: 24.w),
              Gap(8.w),
              Text(
                S.of(context).bookingFormScreenPricingDetailsLabel,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ),
          Gap(12.h),
          if (widget.service.pricingModel == 'hourly') ...[
            _buildPriceRow(
              S.of(context).bookingFormScreenHourlyRateLabel,
              S.of(context).bookingFormScreenHourlyRateValue(
                  widget.service.basePrice.toStringAsFixed(2)),
            ),
            _buildPriceRow(
              S.of(context).bookingFormScreenDurationLabel,
              S.of(context).bookingFormScreenDurationValue(_selectedDuration),
            ),
          ],
          if (selectedOptionDetails.isNotEmpty) ...[
            Gap(8.h),
            Text(
              S.of(context).bookingFormScreenExtraFeesLabel,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            ...selectedOptionDetails.map((option) => _buildPriceRow(
                  option['name'],
                  S.of(context).bookingFormScreenTotalPriceValue(
                      option['price'].toStringAsFixed(2)),
                )),
            _buildPriceRow(
              S.of(context).bookingFormScreenExtraFeesTotalLabel,
              S.of(context).bookingFormScreenTotalPriceValue(
                  optionsTotal.toStringAsFixed(2)),
              isTotal: true,
            ),
          ],
          Divider(height: 16.h, color: Colors.orange.shade300),
          _buildPriceRow(
            S.of(context).bookingFormScreenTotalPriceLabel,
            S.of(context).bookingFormScreenTotalPriceValue(
                _totalPrice.toStringAsFixed(2)),
            isTotal: true,
          ),
          if (widget.service.pricingModel == 'fixed') ...[
            Gap(8.h),
            Text(
              S.of(context).bookingFormScreenFixedPriceNote,
              style: TextStyle(
                fontSize: 12.sp,
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
              fontSize: isTotal ? 16.sp : 14.sp,
              color: isTotal ? Colors.orange.shade800 : Colors.grey.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18.sp : 14.sp,
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
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: title,
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

    if (_currentPosition == null) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).bookingFormScreenLocationRequiredError,
        type: SnackBarType.failure,
      );
      return;
    }

    if (widget.service.pricingModel == 'hourly' &&
        _selectedDuration < widget.service.duration) {
      showCustomSnackBar(
        context: context,
        message: S
            .of(context)
            .bookingFormScreenDurationError(widget.service.duration),
        type: SnackBarType.failure,
      );
      return;
    }

    if (_selectedDayOfWeek == null) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).bookingFormScreenDayError,
        type: SnackBarType.failure,
      );
      return;
    }

    if (_selectedTimeSlot == null) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).bookingFormScreenTimeSlotError,
        type: SnackBarType.failure,
      );
      return;
    }

    if (!_isTimeWithinSlot(_selectedStartTime)) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).bookingFormScreenStartTimeError,
        type: SnackBarType.failure,
      );
      return;
    }

    if (_streetController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _stateController.text.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).bookingFormScreenAddressError,
        type: SnackBarType.failure,
      );
      return;
    }

    if (widget.service.serviceType.toLowerCase() == 'recurring' &&
        _selectedRecurrence == null) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).bookingFormScreenRecurrenceError,
        type: SnackBarType.failure,
      );
      return;
    }

    // Calculate endTime based on startTime + duration
    final startTimeMinutes =
        _selectedStartTime.hour * 60 + _selectedStartTime.minute;
    final durationMinutes =
        _selectedDuration * 60; // Convert hours to minutes for calculation
    final endTimeMinutes = startTimeMinutes + durationMinutes;
    final endTimeHour = (endTimeMinutes ~/ 60) % 24;
    final endTimeMinute = endTimeMinutes % 60;
    final endTime = TimeOfDay(hour: endTimeHour, minute: endTimeMinute);

    // Validate that endTime is after startTime
    if (endTimeMinutes <= startTimeMinutes) {
      showCustomSnackBar(
        context: context,
        message: 'End time must be after start time',
        type: SnackBarType.failure,
      );
      return;
    }

    final bookingRequest = {
      "service": widget.serviceID,
      "provider": widget.service.provider,
      "duration": _selectedDuration, // In hours
      "country": _country ?? "egypt",
      "schedule": {
        "dayOfWeek": _selectedDayOfWeek!.toLowerCase(),
        "startTime": _formatTime(_selectedStartTime),
        "endTime": _formatTime(endTime), // Add endTime
        "timezone": _selectedTimezone ?? "Africa/Cairo",
        if (widget.service.serviceType.toLowerCase() == 'recurring')
          "recurrence": _selectedRecurrence,
      },
      "address": {
        "street": _streetController.text,
        "city": _cityController.text.toLowerCase(),
        "state": _stateController.text.toLowerCase(),
        if (_zipCodeController.text.isNotEmpty)
          "zipCode": _zipCodeController.text,
        "latitude": _currentPosition!.latitude,
        "longitude": _currentPosition!.longitude,
      },
      if (selectedOptions.isNotEmpty) "selectedOptionIds": selectedOptions,
      if (_detailsController.text.isNotEmpty)
        "details": _detailsController.text,
    };

    print('Final booking request: $bookingRequest');
    try {
      cubit.createBooking(bookingRequest);
    } catch (e) {
      print('Error details: $e');
      if (e is DioException && e.response != null) {
        print('Server response status: ${e.response?.statusCode}');
        print('Server response data: ${e.response?.data}');
        showCustomSnackBar(
          context: context,
          message:
              'Booking failed: ${e.response?.data['message'] ?? e.message}',
          type: SnackBarType.failure,
        );
      } else {
        showCustomSnackBar(
          context: context,
          message: 'Booking failed: $e',
          type: SnackBarType.failure,
        );
      }
    }
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

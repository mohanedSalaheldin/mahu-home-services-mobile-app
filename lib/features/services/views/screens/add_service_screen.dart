import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/custom_dropdown.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/image_picker_container.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/toggle_button_group.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _basePriceController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  bool _isServiceTypeRecurring = false;
  String _serviceSubType = 'normal';
  int _duration = 2; // Default duration in hours
  int _durationMinutes = 0; // Additional minutes

  final List<String> _selectedDays = [];
  final List<Map<String, String>> _timeSlots = [];

  // Time slot values with AM/PM
  int _startTimeHour = 9;
  int _startTimeMinute = 0;
  bool _startTimeAmPm = true; // true = AM, false = PM

  int _endTimeHour = 5;
  int _endTimeMinute = 0;
  bool _endTimeAmPm = false; // true = AM, false = PM

  // Explanations for service types
  final Map<String, String> _serviceTypeExplanations = {
    'one-time':
        'One-time service is performed once and completed. Ideal for specific Service needs like move-in/move-out Service.',
    'recurring':
        'Recurring service repeats at regular intervals. Perfect for regular maintenance like weekly or monthly Service.',
  };

  final Map<String, String> _subTypeExplanations = {
    'normal':
        'Standard Service covering basic tasks like dusting, vacuuming, and surface wiping.',
    'deep':
        'Thorough Service including hard-to-reach areas, grout Service, and detailed attention to all surfaces.',
    'weekly':
        'Regular weekly maintenance Service to keep your space consistently clean.',
    'monthly':
        'Comprehensive monthly Service with deeper attention to detail than weekly service.',
  };

  final Map<String, String> _pricingModelExamples = {
    'fixed': 'Example: \$150 for a complete deep Service service',
    'hourly': 'Example: \$40/hour (typically 2-4 hours depending on home size)',
    'weekly': 'Example: \$120 per week for regular maintenance',
    'monthly': 'Example: \$400 per month for comprehensive service',
  };

  @override
  void initState() {
    super.initState();
    // Initialize with all days selected for recurring service
    if (_isServiceTypeRecurring) {
      _selectedDays.addAll([
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ]);
    }
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  void _addTimeSlot() {
    final startTime =
        _formatTime(_startTimeHour, _startTimeMinute, _startTimeAmPm);
    final endTime = _formatTime(_endTimeHour, _endTimeMinute, _endTimeAmPm);

    setState(() {
      _timeSlots.add({'startTime': startTime, 'endTime': endTime});
    });
  }

  String _formatTime(int hour, int minute, bool isAm) {
    final displayHour = isAm ? hour : (hour == 12 ? 12 : hour + 12);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String _getDisplayTime(int hour, int minute, bool isAm) {
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${isAm ? 'AM' : 'PM'}';
  }

  void _removeTimeSlot(int index) {
    setState(() {
      _timeSlots.removeAt(index);
    });
  }

  void _toggleDaySelection(String day) {
    setState(() {
      if (_selectedDays.contains(day)) {
        _selectedDays.remove(day);
      } else {
        _selectedDays.add(day);
      }
    });
  }

  void _updateServiceType(bool isRecurring) {
    setState(() {
      _isServiceTypeRecurring = isRecurring;

      // Reset service subtype based on service type
      if (isRecurring) {
        _serviceSubType = 'weekly';
        // Select all days for recurring service
        _selectedDays.clear();
        _selectedDays.addAll([
          'monday',
          'tuesday',
          'wednesday',
          'thursday',
          'friday',
          'saturday',
          'sunday'
        ]);
      } else {
        _serviceSubType = 'normal';
        // Clear selected days for one-time service
        _selectedDays.clear();
      }
    });
  }

  // Get pricing model based on service type
  String get _pricingModel {
    if (_isServiceTypeRecurring) {
      return _serviceSubType; // 'weekly' or 'monthly'
    } else {
      return 'fixed'; // One-time services are always fixed price
    }
  }

  // Get pricing label based on service type
  String get _pricingLabel {
    if (_isServiceTypeRecurring) {
      return _serviceSubType == 'weekly'
          ? 'Weekly Price (\$)'
          : 'Monthly Price (\$)';
    } else {
      return 'Fixed Price (\$)';
    }
  }

  // Get pricing example based on service type
  String get _pricingExample {
    if (_isServiceTypeRecurring) {
      return _pricingModelExamples[_serviceSubType]!;
    } else {
      return _pricingModelExamples['fixed']!;
    }
  }

  // Update time with 30-minute increments
  void _updateStartTime(int hour, int minute, bool amPm) {
    setState(() {
      _startTimeHour = hour;
      _startTimeMinute = minute;
      _startTimeAmPm = amPm;
    });
  }

  void _updateEndTime(int hour, int minute, bool amPm) {
    setState(() {
      _endTimeHour = hour;
      _endTimeMinute = minute;
      _endTimeAmPm = amPm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Add a Service"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceCreationSuccessState) {
            showCustomSnackBar(
              context: context,
              message: 'Added Successfully',
              type: SnackBarType.success,
            );
            Future.delayed(const Duration(milliseconds: 300), () {
              navigateToAndKill(context, ProviderLayoutScreen());
            });
          }
        },
        builder: (context, state) {
          if (state is ServiceCreationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }
          return Padding(
            padding: EdgeInsets.all(AppConst.appPadding.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Image
                    ImagePickerContainer(
                      onTap: _pickImage,
                      selectedImage: _selectedImage,
                    ),
                    Gap(16.h),

                    // Service Name
                    CustomTextField(
                      label: 'Service Name',
                      hint: 'e.g., Deep Service, Weekly Maintenance',
                      controller: _serviceNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a service name';
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),

                    // Description
                    const AppFieledLabelText(label: 'Description'),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Describe your service in detail...',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: AppColors.greyBack,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(16.w),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.length < 30) {
                          return 'Description should be at least 30 characters';
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),

                    // Service Type Section
                    _buildSectionHeader('Service Type'),
                    ToggleButtonGroup(
                      leftLabel: "Recurring",
                      rightLabel: "One Time",
                      isLeftSelected: _isServiceTypeRecurring,
                      onChanged: _updateServiceType,
                    ),
                    _buildInfoText(_serviceTypeExplanations[
                        _isServiceTypeRecurring ? 'recurring' : 'one-time']!),
                    Gap(16.h),

                    // Service Sub-Type
                    CustomDropdown<String>(
                      label: "Service Type",
                      items: (_isServiceTypeRecurring
                              ? ['weekly', 'monthly']
                              : ['normal', 'deep'])
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  (() {
                                    switch (item) {
                                      case 'normal':
                                        return 'Standard Service';
                                      case 'deep':
                                        return 'Deep Service';
                                      case 'weekly':
                                        return 'Weekly Service';
                                      case 'monthly':
                                        return 'Monthly Service';
                                      default:
                                        return item;
                                    }
                                  })(),
                                ),
                              ))
                          .toList(),
                      value: _serviceSubType,
                      onChanged: (val) => setState(
                          () => _serviceSubType = val ?? _serviceSubType),
                    ),
                    _buildInfoText(_subTypeExplanations[_serviceSubType]!),
                    Gap(16.h),

                    // Pricing Section
                    _buildSectionHeader('Pricing'),
                    _buildInfoText(_pricingExample),
                    Gap(8.h),

                    // Price Input
                    CustomTextField(
                      label: _pricingLabel,
                      hint: _pricingLabel,
                      controller: _basePriceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),

                    // Duration Section (for both service types)
                    _buildSectionHeader('Service Duration'),
                    _buildDurationStepper(),
                    Gap(16.h),

                    // Availability Section
                    _buildSectionHeader('Availability'),

                    // Available Days
                    const AppFieledLabelText(label: 'Available Days'),
                    _isServiceTypeRecurring
                        ? _buildRecurringDaysInfo()
                        : WeekdaySelector(
                            selectedDays: _selectedDays,
                            onToggle: _toggleDaySelection,
                          ),
                    Gap(16.h),

                    // Time Slots
                    const AppFieledLabelText(label: 'Available Time Slots'),
                    _buildTimeSlotStepper(),
                    if (_timeSlots.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          'Please add at least one time slot',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    Gap(24.h),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedDays.isEmpty &&
                                !_isServiceTypeRecurring) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please select at least one available day')),
                              );
                              return;
                            }
                            if (_timeSlots.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please add at least one time slot')),
                              );
                              return;
                            }

                            // Calculate total duration in minutes
                            final totalDuration =
                                (_duration * 60) + _durationMinutes;

                            // Create service model
                            final service = ServiceModel(
                                id: '',
                                name: _serviceNameController.text,
                                description: _descriptionController.text,
                                category: CacheHelper.getString(
                                        "serviceProviderCategory") ??
                                    " ",
                                serviceType: _isServiceTypeRecurring
                                    ? 'recurring'
                                    : 'one-time',
                                subType: _serviceSubType,
                                basePrice:
                                    double.parse(_basePriceController.text),
                                pricingModel: _pricingModel,
                                duration: totalDuration,
                                image: _selectedImage?.path ?? '',
                                active: true,
                                provider:
                                    CacheHelper.getString("providerId") ?? "",
                                isApproved: true,
                                createdAt: DateTime.now(),
                                availableDays: _selectedDays,
                                availableSlots: _timeSlots
                                    .map(
                                      (slot) => TimeSlot(
                                        id: '1',
                                        startTime: slot['startTime']!,
                                        endTime: slot['endTime']!,
                                      ),
                                    )
                                    .toList(),
                                v: 1,
                                businessName: '',
                                firstName: '',
                                lastName: '',
                                avatar: '',
                                totalReviews: 0,
                                averageRating: 0.0,
                                reviews: []);

                            // Call cubit to create service
                            ServiceCubit.get(context).createService(service);
                          }
                        },
                        child: Text(
                          'Publish Service',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildRecurringDaysInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.primary, size: 20.w),
          Gap(8.w),
          Expanded(
            child: Text(
              'Recurring services are available all days of the week',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationStepper() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estimated Service Duration',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Gap(12.h),
          Row(
            children: [
              Expanded(
                child: _buildDurationStepperItem(
                  'Hours',
                  _duration,
                  (value) => setState(() => _duration = value),
                  1,
                  24,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: _buildDurationStepperItem(
                  'Minutes',
                  _durationMinutes,
                  (value) => setState(() => _durationMinutes = value),
                  0,
                  30,
                  30,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            'Total Duration: ${_duration}h ${_durationMinutes > 0 ? '${_durationMinutes}m' : ''}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationStepperItem(
      String label, int value, Function(int) onChanged, int min, int max,
      [int step = 1]) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.remove, size: 20),
                onPressed: value > min ? () => onChanged(value - step) : null,
                style: IconButton.styleFrom(
                  backgroundColor: value > min
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.grey[200],
                ),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, size: 20),
                onPressed: value < max ? () => onChanged(value + step) : null,
                style: IconButton.styleFrom(
                  backgroundColor: value < max
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotStepper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.greyBack,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Start Time
              _buildTimeStepper('Start Time', _startTimeHour, _startTimeMinute,
                  _startTimeAmPm, _updateStartTime),
              Gap(20.h),
              // End Time
              _buildTimeStepper('End Time', _endTimeHour, _endTimeMinute,
                  _endTimeAmPm, _updateEndTime),
              Gap(16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addTimeSlot,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.add, size: 20),
                  label: Text('Add Time Slot',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
        Gap(16.h),

        // Existing time slots
        if (_timeSlots.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Added Time Slots:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              Gap(12.h),
              ..._timeSlots.asMap().entries.map((entry) {
                final index = entry.key;
                final slot = entry.value;
                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 18, color: AppColors.primary),
                          Gap(8.w),
                          Text(
                            '${slot['startTime']} - ${slot['endTime']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline,
                            color: Colors.red, size: 20),
                        onPressed: () => _removeTimeSlot(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
      ],
    );
  }

  Widget _buildTimeStepper(
    String label,
    int hour,
    int minute,
    bool isAm,
    Function(int, int, bool) onUpdate,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان (Start Time / End Time)
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          Gap(16.h),

          // 👇 Hour + Minute في نفس الصف
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildTimeUnitStepper(
                      'Hour',
                      hour,
                      (value) => onUpdate(value, minute, isAm),
                      1,
                      12,
                    ),
                    Gap(6.h),
                    Text('Hour',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              Gap(20.w),
              Expanded(
                child: Column(
                  children: [
                    _buildTimeUnitStepper(
                      'Minute',
                      minute,
                      (value) => onUpdate(hour, value, isAm),
                      0,
                      30,
                      30,
                    ),
                    Gap(6.h),
                    Text('Minute',
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),

          Gap(20.h),

          // 👇 AM / PM تحتهم
          Container(
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => onUpdate(hour, minute, true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isAm ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'AM',
                        style: TextStyle(
                          color: isAm ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => onUpdate(hour, minute, false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isAm ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'PM',
                        style: TextStyle(
                          color: !isAm ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Gap(12.h),

          // الوقت المختار Preview
          Center(
            child: Text(
              'Selected: ${_getDisplayTime(hour, minute, isAm)}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnitStepper(
      String label, int value, Function(int) onChanged, int min, int max,
      [int step = 1]) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.remove, size: 16),
            onPressed: value > min ? () => onChanged(value - step) : null,
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(4),
              backgroundColor: value > min
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.grey[200],
            ),
          ),
          Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, size: 16),
            onPressed: value < max ? () => onChanged(value + step) : null,
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(4),
              backgroundColor: value < max
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }
}

class WeekdaySelector extends StatelessWidget {
  final List<String> selectedDays;
  final void Function(String day) onToggle;

  const WeekdaySelector({
    super.key,
    required this.selectedDays,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: days
              .map(
                (day) => FilterChip(
                  label: Text(
                    day[0].toUpperCase() + day.substring(1),
                    style: TextStyle(
                      fontSize: 13,
                      color: selectedDays.contains(day)
                          ? Colors.white
                          : Colors.grey[700],
                    ),
                  ),
                  selected: selectedDays.contains(day),
                  onSelected: (_) => onToggle(day),
                  selectedColor: AppColors.primary,
                  checkmarkColor: Colors.white,
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
              .toList(),
        ),
        if (selectedDays.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              'Please select at least one day',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

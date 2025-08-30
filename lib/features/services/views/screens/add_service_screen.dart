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
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/bool_radio_group.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/custom_dropdown.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/image_picker_container.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/time_slot_selector.dart';
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
  final TextEditingController _durationController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  bool _isPricingModelHourly = false;
  bool _isServiceTypeRecurring = false;
  String _serviceSubType = 'normal';
  bool _isActiveImmediately = true;

  final List<String> _selectedDays = [];
  final List<Map<String, String>> _timeSlots = [];

  // Explanations for service types and pricing models
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
    'fixed': 'Example: \$150 for a complete deep Service service (3-4 hours)',
    'hourly': 'Example: \$40/hour (typically 2-4 hours depending on home size)',
  };

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  void _addTimeSlot(String startTime, String endTime) {
    setState(() {
      _timeSlots.add({'startTime': startTime, 'endTime': endTime});
    });
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
                      // : 'Service Image (Recommended: 800x600px)',
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
                      // focusNode: ,
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
                      onChanged: (value) =>
                          setState(() => _isServiceTypeRecurring = value),
                    ),
                    _buildInfoText(_serviceTypeExplanations[
                        _isServiceTypeRecurring ? 'recurring' : 'one-time']!),
                    Gap(16.h),

                    // Service Sub-Type
                    CustomDropdown<String>(
                      label: "Service Type",
                      items: (_isServiceTypeRecurring
                              ? ['normal', 'deep', 'weekly', 'monthly']
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

                    // Pricing Model
                    _buildSectionHeader('Pricing Model'),
                    ToggleButtonGroup(
                      leftLabel: "Hourly",
                      rightLabel: "Fixed",
                      isLeftSelected: _isPricingModelHourly,
                      onChanged: (value) =>
                          setState(() => _isPricingModelHourly = value),
                    ),
                    _buildInfoText(_pricingModelExamples[
                        _isPricingModelHourly ? 'hourly' : 'fixed']!),
                    Gap(16.h),

                    // Price Input
                    CustomTextField(
                      label: 'Pricing Rate',
                      hint: _isPricingModelHourly
                          ? 'Hourly Rate (\$/hour)'
                          : 'Fixed Price (\$)',
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

                    CustomTextField(
                      label: 'Minimum Duration',
                      hint: 'e.g., 2 hours',
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter duration';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),

                    Gap(16.h),

                    // Availability Section
                    _buildSectionHeader('Availability'),

                    // Available Days
                    const AppFieledLabelText(label: 'Available Days'),
                    WeekdaySelector(
                        selectedDays: _selectedDays,
                        onToggle: _toggleDaySelection),
                    Gap(16.h),

                    // Time Slots
                    const AppFieledLabelText(label: 'Available Time Slots'),
                    TimeSlotSelector(
                      onAddSlot: _addTimeSlot,
                      existingSlots: _timeSlots,
                      onRemoveSlot: _removeTimeSlot,
                    ),
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
                    Gap(16.h),

                    // Active Immediately
                    BoolRadioGroup(
                      label: 'Activate Immediately',
                      value: _isActiveImmediately,
                      onChanged: (val) =>
                          setState(() => _isActiveImmediately = val),
                    ),
                    _buildInfoText(
                        'If disabled, the service will need admin approval before becoming visible to clients.'),
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
                            if (_selectedDays.isEmpty) {
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
                                pricingModel:
                                    _isPricingModelHourly ? 'hourly' : 'fixed',
                                duration: int.parse(_durationController.text),
                                image: _selectedImage?.path ?? '',
                                active: _isActiveImmediately,
                                provider:
                                    CacheHelper.getString("providerId") ?? "",
                                // Replace with actual ProviderData object
                                isApproved: _isActiveImmediately,
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
          children: days
              .map(
                (day) => FilterChip(
                  label: Text(
                    day[0].toUpperCase() + day.substring(1),
                    style: TextStyle(
                      color: selectedDays.contains(day)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  selected: selectedDays.contains(day),
                  onSelected: (_) => onToggle(day),
                  selectedColor: AppColors.primary,
                  checkmarkColor: Colors.white,
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

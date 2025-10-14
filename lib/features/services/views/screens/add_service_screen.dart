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
import 'package:mahu_home_services_app/generated/l10n.dart';

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
  final List<Map<String, dynamic>> _options = [];
  final TextEditingController _optionNameController = TextEditingController();
  final TextEditingController _optionPriceController = TextEditingController();
  final TextEditingController _optionDescriptionController =
      TextEditingController();

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

  @override
  void initState() {
    super.initState();
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

  void _addOption() {
    final name = _optionNameController.text.trim();
    final price = _optionPriceController.text.trim();
    final description = _optionDescriptionController.text.trim();

    if (name.isNotEmpty && price.isNotEmpty) {
      setState(() {
        _options.add({
          'name': name,
          'price': double.parse(price),
          'description': description,
          'pricingModel': 'fixed',
          'appliesTo': 'one-time',
          'active': true,
        });
      });

      _optionNameController.clear();
      _optionPriceController.clear();
      _optionDescriptionController.clear();
    }
  }

  String _formatTime(int hour, int minute, bool isAm) {
    final displayHour = isAm ? hour : (hour == 12 ? 12 : hour + 12);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String _getDisplayTime(int hour, int minute, bool isAm) {
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${isAm ? S.of(context).addServiceScreenAmLabel : S.of(context).addServiceScreenPmLabel}';
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

      if (isRecurring) {
        _serviceSubType = 'weekly';
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
        _selectedDays.clear();
      }
    });
  }

  String get _pricingModel {
    if (_isServiceTypeRecurring) {
      return _serviceSubType;
    } else {
      return 'fixed';
    }
  }

  String get _pricingLabel {
    if (_isServiceTypeRecurring) {
      return _serviceSubType == 'weekly'
          ? S.of(context).addServiceScreenWeeklyPriceLabel
          : S.of(context).addServiceScreenMonthlyPriceLabel;
    } else {
      return S.of(context).addServiceScreenFixedPriceLabel;
    }
  }

  String get _pricingExample {
    if (_isServiceTypeRecurring) {
      return _serviceSubType == 'weekly'
          ? S.of(context).addServiceScreenPricingWeeklyExample
          : S.of(context).addServiceScreenPricingMonthlyExample;
    } else {
      return S.of(context).addServiceScreenPricingFixedExample;
    }
  }

  String get _serviceTypeExplanation {
    return _isServiceTypeRecurring
        ? S.of(context).addServiceScreenServiceTypeRecurringExplanation
        : S.of(context).addServiceScreenServiceTypeOneTimeExplanation;
  }

  String get _subTypeExplanation {
    switch (_serviceSubType) {
      case 'normal':
        return S.of(context).addServiceScreenSubTypeNormalExplanation;
      case 'deep':
        return S.of(context).addServiceScreenSubTypeDeepExplanation;
      case 'weekly':
        return S.of(context).addServiceScreenSubTypeWeeklyExplanation;
      case 'monthly':
        return S.of(context).addServiceScreenSubTypeMonthlyExplanation;
      default:
        return '';
    }
  }

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
        title: Text(S.of(context).addServiceScreenTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceCreationSuccessState) {
            showCustomSnackBar(
              context: context,
              message: S.of(context).addServiceScreenSuccessMessage,
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
                    ImagePickerContainer(
                      onTap: _pickImage,
                      selectedImage: _selectedImage,
                    ),
                    Gap(16.h),
                    CustomTextField(
                      label: S.of(context).addServiceScreenServiceNameLabel,
                      hint: S.of(context).addServiceScreenServiceNameHint,
                      controller: _serviceNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).addServiceScreenServiceNameError;
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),
                    AppFieledLabelText(
                        label: S.of(context).addServiceScreenDescriptionLabel),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: S.of(context).addServiceScreenDescriptionHint,
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
                          return S
                              .of(context)
                              .addServiceScreenDescriptionEmptyError;
                        }
                        if (value.length < 30) {
                          return S
                              .of(context)
                              .addServiceScreenDescriptionLengthError;
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),
                    _buildSectionHeader(
                        S.of(context).addServiceScreenServiceTypeSection),
                    ToggleButtonGroup(
                      leftLabel:
                          S.of(context).addServiceScreenServiceTypeRecurring,
                      rightLabel:
                          S.of(context).addServiceScreenServiceTypeOneTime,
                      isLeftSelected: _isServiceTypeRecurring,
                      onChanged: _updateServiceType,
                    ),
                    _buildInfoText(_serviceTypeExplanation),
                    Gap(16.h),
                    CustomDropdown<String>(
                      label: S.of(context).addServiceScreenServiceTypeLabel,
                      items: (_isServiceTypeRecurring
                              ? ['weekly', 'monthly']
                              : ['normal', 'deep'])
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  (() {
                                    switch (item) {
                                      case 'normal':
                                        return S
                                            .of(context)
                                            .addServiceScreenSubTypeNormal;
                                      case 'deep':
                                        return S
                                            .of(context)
                                            .addServiceScreenSubTypeDeep;
                                      case 'weekly':
                                        return S
                                            .of(context)
                                            .addServiceScreenSubTypeWeekly;
                                      case 'monthly':
                                        return S
                                            .of(context)
                                            .addServiceScreenSubTypeMonthly;
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
                    _buildInfoText(_subTypeExplanation),
                    Gap(16.h),
                    _buildSectionHeader(
                        S.of(context).addServiceScreenPricingSection),
                    _buildInfoText(_pricingExample),
                    Gap(8.h),
                    CustomTextField(
                      label: _pricingLabel,
                      hint: _pricingLabel,
                      controller: _basePriceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).addServiceScreenPriceEmptyError;
                        }
                        if (double.tryParse(value) == null) {
                          return S
                              .of(context)
                              .addServiceScreenPriceInvalidError;
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),
                    _buildSectionHeader(
                        S.of(context).addServiceScreenDurationSection),
                    _buildDurationStepper(),
                    Gap(16.h),
                    _buildSectionHeader(
                        S.of(context).addServiceScreenAvailabilitySection),
                    AppFieledLabelText(
                        label:
                            S.of(context).addServiceScreenAvailableDaysLabel),
                    _isServiceTypeRecurring
                        ? _buildRecurringDaysInfo()
                        : WeekdaySelector(
                            selectedDays: _selectedDays,
                            onToggle: _toggleDaySelection,
                          ),
                    Gap(16.h),
                    AppFieledLabelText(
                        label: S.of(context).addServiceScreenTimeSlotsLabel),
                    _buildTimeSlotStepper(),
                    if (_timeSlots.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          S.of(context).addServiceScreenTimeSlotsError,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    Gap(24.h),
                    Gap(16.h),
                    _buildSectionHeader(S.of(context).serviceOptions),
                    _buildServiceOptionItem(context),
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
                                SnackBar(
                                    content: Text(S
                                        .of(context)
                                        .addServiceScreenAvailableDaysError)),
                              );
                              return;
                            }
                            if (_timeSlots.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(S
                                        .of(context)
                                        .addServiceScreenTimeSlotsError)),
                              );
                              return;
                            }

                            final totalDuration =
                                (_duration * 60) + _durationMinutes;

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
                                options: _options
                                    .map((o) => ServiceOption(
                                          name: o['name'],
                                          price: o['price'],
                                          description: o['description'],
                                        ))
                                    .toList(),
                                v: 1,
                                businessName: '',
                                firstName: '',
                                lastName: '',
                                avatar: '',
                                totalReviews: 0,
                                averageRating: 0.0,
                                reviews: []);

                            ServiceCubit.get(context).createService(service);
                          }
                        },
                        child: Text(
                          S.of(context).addServiceScreenPublishButton,
                          style: const TextStyle(
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

  Column _buildServiceOptionItem(BuildContext context) {
    final s = S.of(context); // لتسهيل الوصول للترجمات

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== بطاقة الإدخال =====
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // ===== صف الاسم والسعر =====
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _optionNameController,
                      decoration: InputDecoration(
                        hintText: s.optionName, // ✅ الترجمة
                        filled: true,
                        fillColor: AppColors.greyBack,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _optionPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: s.extraPrice, // ✅ الترجمة
                        filled: true,
                        fillColor: AppColors.greyBack,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              // ===== حقل الوصف =====
              TextField(
                controller: _optionDescriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: s.optionDescriptionOptional, // ✅ الترجمة
                  filled: true,
                  fillColor: AppColors.greyBack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 14.h),

              // ===== زر الإضافة =====
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _addOption,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.white),
                  label: Text(
                    s.addOption, // ✅ الترجمة
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Gap(20.h),

        // ===== عرض الخيارات =====
        if (_options.isNotEmpty)
          Column(
            children: _options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              return Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== الاسم والسعر =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${option['name']} (+${option['price']})",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              setState(() => _options.removeAt(index)),
                        ),
                      ],
                    ),
                    // ===== الوصف =====
                    if (option['description'] != null &&
                        option['description'].toString().trim().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          option['description'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: const TextStyle(
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
              S.of(context).addServiceScreenRecurringDaysInfo,
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
            S.of(context).addServiceScreenEstimatedDurationLabel,
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
                  S.of(context).addServiceScreenHoursLabel,
                  _duration,
                  (value) => setState(() => _duration = value),
                  1,
                  24,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: _buildDurationStepperItem(
                  S.of(context).addServiceScreenMinutesLabel,
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
            S.of(context).addServiceScreenTotalDuration(
                _duration, _durationMinutes > 0 ? '${_durationMinutes}m' : ''),
            style: const TextStyle(
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
          style: const TextStyle(
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
                icon: const Icon(Icons.remove, size: 20),
                onPressed: value > min ? () => onChanged(value - step) : null,
                style: IconButton.styleFrom(
                  backgroundColor: value > min
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.grey[200],
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
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
              _buildTimeStepper(
                  S.of(context).addServiceScreenStartTimeLabel,
                  _startTimeHour,
                  _startTimeMinute,
                  _startTimeAmPm,
                  _updateStartTime),
              Gap(20.h),
              _buildTimeStepper(S.of(context).addServiceScreenEndTimeLabel,
                  _endTimeHour, _endTimeMinute, _endTimeAmPm, _updateEndTime),
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
                  icon: const Icon(Icons.add, size: 20),
                  label: Text(S.of(context).addServiceScreenAddTimeSlotButton,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
        Gap(16.h),
        if (_timeSlots.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).addServiceScreenAddedTimeSlotsLabel,
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
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 18, color: AppColors.primary),
                          Gap(8.w),
                          Text(
                            '${slot['startTime']} - ${slot['endTime']}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 20),
                        onPressed: () => _removeTimeSlot(index),
                      ),
                    ],
                  ),
                );
              }),
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
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildTimeUnitStepper(
                      S.of(context).addServiceScreenHourLabel,
                      hour,
                      (value) => onUpdate(value, minute, isAm),
                      1,
                      12,
                    ),
                    Gap(6.h),
                    Text(S.of(context).addServiceScreenHourLabel,
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
                      S.of(context).addServiceScreenMinuteLabel,
                      minute,
                      (value) => onUpdate(hour, value, isAm),
                      0,
                      30,
                      30,
                    ),
                    Gap(6.h),
                    Text(S.of(context).addServiceScreenMinuteLabel,
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          Gap(20.h),
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
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).addServiceScreenAmLabel,
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
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).addServiceScreenPmLabel,
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
          Center(
            child: Text(
              S.of(context).addServiceScreenSelectedTime(
                  _getDisplayTime(hour, minute, isAm)),
              style: const TextStyle(
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
            icon: const Icon(Icons.remove, size: 16),
            onPressed: value > min ? () => onChanged(value - step) : null,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(4),
              backgroundColor: value > min
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.grey[200],
            ),
          ),
          Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: value < max ? () => onChanged(value + step) : null,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(4),
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

  String _getDayName(BuildContext context, String day) {
    switch (day) {
      case 'monday':
        return S.of(context).addServiceScreenDayMonday;
      case 'tuesday':
        return S.of(context).addServiceScreenDayTuesday;
      case 'wednesday':
        return S.of(context).addServiceScreenDayWednesday;
      case 'thursday':
        return S.of(context).addServiceScreenDayThursday;
      case 'friday':
        return S.of(context).addServiceScreenDayFriday;
      case 'saturday':
        return S.of(context).addServiceScreenDaySaturday;
      case 'sunday':
        return S.of(context).addServiceScreenDaySunday;
      default:
        return day;
    }
  }

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
                    _getDayName(context, day),
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
              S.of(context).addServiceScreenAvailableDaysError,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

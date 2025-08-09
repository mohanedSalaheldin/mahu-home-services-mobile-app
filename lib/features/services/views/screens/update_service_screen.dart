import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/time_slot_selector.dart';

class UpdateServiceScreen extends StatefulWidget {
  const UpdateServiceScreen({
    super.key,
    required this.service,
  });
  final ServiceModel service;

  @override
  _UpdateServiceScreenState createState() => _UpdateServiceScreenState();
}

class _UpdateServiceScreenState extends State<UpdateServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _basePriceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // final bool _isPricingModelHourly = false;
  // final bool _isServiceTypeRecurring = false;
  final String _serviceSubType = 'normal';
  final bool _isActiveImmediately = true;

  List<String> _selectedDays = [];
  List<Map<String, String>> _timeSlots = [];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceModel service = widget.service;
    _selectedDays = service.availableDays;
    _timeSlots = service.availableSlots
        .map((slot) => {
              'startTime': slot.startTime,
              'endTime': slot.endTime,
            })
        .toList();
    _serviceNameController.text = service.name;
    _descriptionController.text = service.description;
    _basePriceController.text = service.basePrice.toString();
    _durationController.text = service.duration.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Edit Service"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceUpdateSuccessState) {
            showCustomSnackBar(
              context: context,
              message: 'Uodated Successfully',
              type: SnackBarType.success,
            );
            Future.delayed(const Duration(milliseconds: 300), () {
              navigateToAndKill(context, ProviderLayoutScreen());
            });
          }
        },
        builder: (context, state) {
          if (state is ServiceUpdateLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(AppConst.appPadding.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DottedBorder(
                      color: AppColors.blue,
                      strokeWidth: 2,
                      dashPattern: const [8],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      child: Container(
                        height: 168.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue[50],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: _selectedImage == null
                                  ? Image.network(
                                      widget.service.image,
                                      height: 168.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(_selectedImage!.path),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton.filled(
                                onPressed: _pickImage,
                                style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(AppColors.blue)),
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Gap(16.h),

                    // Service Name
                    CustomTextField(
                      label: 'Service Name',
                      hint: 'e.g., Deep Cleaning, Weekly Maintenance',
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
                        hintText: 'Describe your cleaning service in detail...',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14.sp,
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

                    CustomTextField(
                      label: 'Pricing Rate',
                      hint: 'Pricing Rate',
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
                      label: 'Min. Duration',
                      hint: 'e.g., 120 for 2 hours',
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

                    const AppFieledLabelText(label: 'Available Days'),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        'monday',
                        'tuesday',
                        'wednesday',
                        'thursday',
                        'friday',
                        'saturday',
                        'sunday'
                      ]
                          .map((day) => FilterChip(
                                label: Text(
                                  day.substring(0, 1).toUpperCase() +
                                      day.substring(1),
                                  style: TextStyle(
                                    color: _selectedDays.contains(day)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: _selectedDays.contains(day),
                                onSelected: (_) => _toggleDaySelection(day),
                                selectedColor: AppColors.primary,
                                checkmarkColor: Colors.white,
                              ))
                          .toList(),
                    ),
                    if (_selectedDays.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          'Please select at least one day',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
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
                            fontSize: 12.sp,
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
                            var service = widget.service;
                            final updatedService = ServiceModel(
                              id: service.id,
                              name: _serviceNameController.text,
                              description: _descriptionController.text,
                              category: service.category,
                              serviceType: service.serviceType,
                              subType: _serviceSubType,
                              basePrice:
                                  double.parse(_basePriceController.text),
                              pricingModel: service.pricingModel,
                              duration: int.parse(_durationController.text),
                              image: _selectedImage?.path ?? '',
                              active: _isActiveImmediately,
                              provider: service.provider,
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
                            );

                            // Call cubit to create service
                            ServiceCubit.get(context)
                                .updateService(updatedService);
                          }
                        },
                        child: Text(
                          'Publish Service',
                          style: TextStyle(
                            fontSize: 16.sp,
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
          fontSize: 18.sp,
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
          fontSize: 12.sp,
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

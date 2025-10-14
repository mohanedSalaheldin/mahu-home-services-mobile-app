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
import 'package:mahu_home_services_app/generated/l10n.dart';

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
  final TextEditingController _optionDescriptionController =
      TextEditingController();

  // controllers for option
  final TextEditingController _optionNameController = TextEditingController();
  final TextEditingController _optionDescController = TextEditingController();
  final TextEditingController _optionPriceController = TextEditingController();
  String _selectedPricingModel = 'fixed';
  String _selectedAppliesTo = 'one-time';
  bool _optionActive = true;

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final String _serviceSubType = 'normal';
  final bool _isActiveImmediately = true;

  List<String> _selectedDays = [];
  List<Map<String, String>> _timeSlots = [];
  List<ServiceOption> _options = [];

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  void _addOption() {
    final name = _optionNameController.text.trim();
    final price = _optionPriceController.text.trim();
    final description = _optionDescriptionController.text.trim();

    if (name.isNotEmpty && price.isNotEmpty) {
      setState(() {
        _options.add(ServiceOption(
          name: name,
          price: double.tryParse(price) ?? 0.0,
          description: description,
          pricingModel: _selectedPricingModel,
          appliesTo: _selectedAppliesTo,
          active: _optionActive,
        ));
      });

      _optionNameController.clear();
      _optionPriceController.clear();
      _optionDescriptionController.clear();
    }
  }

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index);
    });
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

  String _getDayName(BuildContext context, String day) {
    switch (day) {
      case 'monday':
        return S.of(context).updateServiceScreenDayMonday;
      case 'tuesday':
        return S.of(context).updateServiceScreenDayTuesday;
      case 'wednesday':
        return S.of(context).updateServiceScreenDayWednesday;
      case 'thursday':
        return S.of(context).updateServiceScreenDayThursday;
      case 'friday':
        return S.of(context).updateServiceScreenDayFriday;
      case 'saturday':
        return S.of(context).updateServiceScreenDaySaturday;
      case 'sunday':
        return S.of(context).updateServiceScreenDaySunday;
      default:
        return day;
    }
  }

  @override
  void initState() {
    super.initState();
    ServiceModel service = widget.service;
    _selectedDays = List.from(service.availableDays);
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
    _options = List.from(service.options);
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
                          "${option.name} (+${option.price.toStringAsFixed(2)})",
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
                    if (option.description != '' &&
                        option.description.toString().trim().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          option.description,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(S.of(context).updateServiceScreenTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceUpdateSuccessState) {
            showCustomSnackBar(
              context: context,
              message: S.of(context).updateServiceScreenSuccessMessage,
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
              child: CircularProgressIndicator(color: Colors.blue),
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
                    /// image picker
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

                    /// name
                    CustomTextField(
                      label: S.of(context).updateServiceScreenServiceNameLabel,
                      hint: S.of(context).updateServiceScreenServiceNameHint,
                      controller: _serviceNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S
                              .of(context)
                              .updateServiceScreenServiceNameError;
                        }
                        return null;
                      },
                    ),
                    Gap(16.h),

                    /// description
                    AppFieledLabelText(
                        label:
                            S.of(context).updateServiceScreenDescriptionLabel),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            S.of(context).updateServiceScreenDescriptionHint,
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
                    ),
                    Gap(16.h),

                    /// base price
                    CustomTextField(
                      label: S.of(context).updateServiceScreenPricingLabel,
                      hint: S.of(context).updateServiceScreenPricingHint,
                      controller: _basePriceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return S
                        //       .of(context)
                        //       .updateServiceScreenPricingError;
                        // }
                        // if (double.tryParse(value) == null) {
                        //   return S
                        //       .of(context)
                        //       .updateServiceScreenPricingInvalidError;
                        // }
                        return null;
                      },
                    ),
                    Gap(16.h),

                    /// duration
                    CustomTextField(
                      label: S.of(context).updateServiceScreenDurationLabel,
                      hint: S.of(context).updateServiceScreenDurationHint,
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return S
                        //       .of(context)
                        //       .updateServiceScreenDurationError;
                        // }
                        // if (int.tryParse(value) == null) {
                        //   return S
                        //       .of(context)
                        //       .updateServiceScreenDurationInvalidError;
                        // }
                        return null;
                      },
                    ),

                    Gap(16.h),

                    /// Options section
                    const AppFieledLabelText(label: "Service Options"),
                    Column(
                      children: [
                        // CustomTextField(
                        //   label: "Option Name",
                        //   controller: _optionNameController,
                        //   hint: "e.g. Extra Cleaning",
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "Please enter option name";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // Gap(8.h),
                        // CustomTextField(
                        //   label: "Description",
                        //   controller: _optionDescController,
                        //   hint: "e.g. Additional 30 minutes of cleaning",
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "Please enter option name";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // Gap(8.h),
                        // CustomTextField(
                        //   label: "Price",
                        //   controller: _optionPriceController,
                        //   keyboardType: TextInputType.number,
                        //   hint: "e.g. 20.00",
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "Please enter option name";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // Gap(8.h),
                        // DropdownButtonFormField<String>(
                        //   value: _selectedPricingModel,
                        //   items: ['fixed', 'hourly', 'weekly', 'monthly']
                        //       .map((e) =>
                        //           DropdownMenuItem(value: e, child: Text(e)))
                        //       .toList(),
                        //   onChanged: (val) =>
                        //       setState(() => _selectedPricingModel = val!),
                        //   decoration:
                        //       const InputDecoration(labelText: "Pricing Model"),
                        // ),
                        // Gap(8.h),
                        // DropdownButtonFormField<String>(
                        //   value: _selectedAppliesTo,
                        //   items: ['one-time', 'recurring']
                        //       .map((e) =>
                        //           DropdownMenuItem(value: e, child: Text(e)))
                        //       .toList(),
                        //   onChanged: (val) =>
                        //       setState(() => _selectedAppliesTo = val!),
                        //   decoration:
                        //       const InputDecoration(labelText: "Applies To"),
                        // ),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: _optionActive,
                        //       onChanged: (val) =>
                        //           setState(() => _optionActive = val!),
                        //     ),
                        //     const Text("Active"),
                        //   ],
                        // ),
                        _buildServiceOptionItem(context),
                        // ElevatedButton(
                        //   onPressed: _addOption,
                        //   child: const Text("Add Option"),
                        // ),
                      ],
                    ),
                    // Gap(12.h),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: _options.length,
                    //   itemBuilder: (context, index) {
                    //     final option = _options[index];
                    //     return ListTile(
                    //       title: Text(option.name),
                    //       subtitle: Text(
                    //           "${option.description} | ${option.price} | ${option.pricingModel} | ${option.appliesTo}"),
                    //       trailing: IconButton(
                    //         icon: const Icon(Icons.delete, color: Colors.red),
                    //         onPressed: () => _removeOption(index),
                    //       ),
                    //     );
                    //   },
                    // ),

                    Gap(24.h),

                    /// Submit button
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
                            var service = widget.service;
                            final updatedService = ServiceModel(
                              id: service.id,
                              averageRating: service.averageRating,
                              totalReviews: service.totalReviews,
                              name: _serviceNameController.text,
                              description: _descriptionController.text,
                              category: service.category,
                              serviceType: service.serviceType,
                              subType: _serviceSubType,
                              basePrice:
                                  double.parse(_basePriceController.text),
                              pricingModel: service.pricingModel,
                              duration: int.parse(_durationController.text),
                              image: _selectedImage?.path ?? service.image,
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
                              options: _options,
                              v: 1,
                              businessName: '',
                              firstName: '',
                              lastName: '',
                              avatar: '',
                              reviews: service.reviews,
                            );

                            ServiceCubit.get(context)
                                .updateService(updatedService);
                          }
                        },
                        child: Text(
                          S.of(context).updateServiceScreenPublishButton,
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
}

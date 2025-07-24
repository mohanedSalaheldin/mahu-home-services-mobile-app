import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/models/service_type.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/bool_radio_group.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/custom_dropdown.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/image_picker_container.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/short_form_field.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/toggle_button_group.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController durationHoursController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController basePriceController = TextEditingController();
  TextEditingController recurrencePatternController = TextEditingController();
  TextEditingController recurrenceIntervalController = TextEditingController();

  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  bool isPricingModelHourly = true;
  bool isServiceTypeRecurring = true;
  ServiceSubType serviceSubType = ServiceSubType.normal;

  RecurrencePattern? recurrencePattern;

  bool isActiveImmediately = true;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Add Service"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceCreationSuccessState) {
            navigateTo(context, const ServiceProviderDashboardScreen());
            // Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(AppConst.appPadding.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImagePickerContainer(
                      onTap: _pickImage,
                      selectedImage: _selectedImage,
                    ),
                    Gap(16.h),
                    CustomTextField(
                      label: 'Service Name',
                      hint: 'Service Name',
                      keyboardType: TextInputType.emailAddress,
                      controller: serviceNameController,
                      validator: FormValidationMethod.validateEmailAndPhoneNum,
                    ),
                    //  'Description',
                    const AppFieledLabelText(label: 'Description'),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.name,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          height: 4,
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                        filled: true,
                        fillColor: AppColors.greyBack,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                    ),

                    Gap(16.h),
                    const AppFieledLabelText(
                      label: 'Service Type',
                    ),
                    ToggleButtonGroup(
                      leftLabel: "Recurring",
                      rightLabel: "One Time",
                      isLeftSelected: isServiceTypeRecurring,
                      onChanged: (value) =>
                          setState(() => isServiceTypeRecurring = value),
                    ),
                    Gap(16.h),
                    const AppFieledLabelText(label: 'Pricing Model'),
                    ToggleButtonGroup(
                      leftLabel: "Hourly",
                      rightLabel: "Fixed",
                      isLeftSelected: isPricingModelHourly,
                      onChanged: (value) =>
                          setState(() => isPricingModelHourly = value),
                    ),
                    Gap(16.h),
                    CustomDropdown<ServiceSubType>(
                      label: "Service Sub-Type",
                      description: "Choose how often the service is performed",
                      items: [ServiceSubType.normal, ServiceSubType.deep]
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text(e.displayName)))
                          .toList(),
                      value: serviceSubType,
                      onChanged: (val) {
                        setState(() {
                          serviceSubType = val ?? serviceSubType;
                        });
                      },
                    ),
                    Gap(16.h),
                    SizedBox(
                      height: 32.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppFieledLabelText(
                            label: isPricingModelHourly
                                ? 'Hourly Rate: '
                                : 'Base Price:  ',
                          ),
                          ShortFormField(controller: basePriceController),
                          if (isPricingModelHourly)
                            Text(
                              ' /Hour ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                color: AppColors.blue,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        const AppFieledLabelText(label: 'Duration: '),
                        ShortFormField(controller: durationHoursController),
                        const AppFieledLabelText(label: 'Hrs'),
                        Text(
                          ' / ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColors.blue,
                          ),
                        ),
                        ShortFormField(controller: durationMinutesController),
                        const AppFieledLabelText(label: 'Mins'),
                      ],
                    ),
                    Gap(16.h),
                    BoolRadioGroup(
                      label: 'Active Immediately',
                      value: isActiveImmediately,
                      onChanged: (val) =>
                          setState(() => isActiveImmediately = val),
                    ),

                    Gap(16.h),
                    if (isServiceTypeRecurring)
                      CustomDropdown<RecurrencePattern>(
                        label: "Recurrence Pattern",
                        description:
                            "Choose how often the service is performed",
                        items: [
                          RecurrencePattern.monthly,
                          RecurrencePattern.weekly
                        ]
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.displayName)))
                            .toList(),
                        value: recurrencePattern,
                        onChanged: (val) {
                          setState(() {
                            recurrencePattern = val ?? recurrencePattern;
                          });
                        },
                      ),
                    Gap(16.h),
                    AppFilledButton(
                      onPressed: () {
                        ServiceCubit.get(context).createService(
                          ServiceModel(
                            id: ' ',
                            name: serviceNameController.text,
                            description: descriptionController.text,
                            category: 'cleaning',
                            serviceType: isServiceTypeRecurring
                                ? ServiceType.recurring.displayName
                                : ServiceType.oneTime.displayName,
                            subType: serviceSubType.displayName,
                            basePrice: int.parse(basePriceController.text),
                            pricingModel: isPricingModelHourly
                                ? PricingModel.fixed.name
                                : PricingModel.photoBased.name,
                            duration: 60,
                            image:
                                'https://juanycleaningservice.com/wp-content/uploads/2024/10/deep-clean-checklist-hero-image-min.jpg',
                            active: isActiveImmediately,
                            provider: 'provider',
                            isApproved: true,
                            createdAt: DateTime.now(),
                            v: 1,
                          ),
                        );
                      },
                      fontSize: 15,
                      text: "Publish Now",
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

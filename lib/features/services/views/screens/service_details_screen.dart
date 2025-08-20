import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/update_service_screen.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/action_buttons.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/availability_section.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/detail_section.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/customer_home_screen.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import '../../models/service_model.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  Future<UserBaseProfileModel?> _getProviderProfile() async {
    if (service.provider.isNotEmpty) {
      final result = await ProfileServices().getProviderProfile(service.provider);
      return result.fold((failure) => null, (profile) => profile);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Service Details"),
        centerTitle: false,
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ServiceDeletionSuccessState) {
            showCustomSnackBar(
              context: context,
              message: 'Deleted Successfully',
              type: SnackBarType.success,
            );
            Future.delayed(const Duration(milliseconds: 300), () {
              navigateToAndKill(context, ProviderLayoutScreen());
            });
          }

          if (state is ServiceDeletionFailedState) {
            showCustomSnackBar(
              context: context,
              message: 'Service deletion failed',
              type: SnackBarType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is ServiceDeletionLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Provider Info
                FutureBuilder<UserBaseProfileModel?>(
                  future: _getProviderProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(height: 32, child: LinearProgressIndicator());
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      return Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.avatar,
                              height: 32,
                              width: 32,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Container(
                                height: 32,
                                width: 32,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Text(
                            snapshot.data!.businessName,
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Gap(16.h),

                // Service Image
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(service.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(24.h),

                // Service Name and Basic Info
                Text(
                  service.name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8.h),
                Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                Gap(24.h),

                DetailSection(service: service),
                Gap(24.h),
                ActionButtons(
                  onDelete: () => _showDeleteConfirmation(context),
                  onEdit: () => navigateTo(
                      context,
                      UpdateServiceScreen(
                        service: service,
                      )),
                ),
                Gap(32.h),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text(
            "Are you sure you want to delete this service? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ServiceCubit.get(context).deleteService(service.id);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    // TODO: Implement navigation to edit screen
  }
}

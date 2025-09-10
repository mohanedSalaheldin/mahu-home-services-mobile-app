import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/update_service_screen.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/action_buttons.dart';
import 'package:mahu_home_services_app/features/services/views/widgets/detail_section.dart';
import '../../models/service_model.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late ServiceModel _currentService;

  @override
  void initState() {
    super.initState();
    _currentService = widget.service;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: const Text("Service Details"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          _buildStatusIndicator(),
          Gap(8.w),
        ],
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {

          if (state is ServiceStatusUpdateSuccessState) {
            setState(() {
              _currentService =
                  _currentService.copyWith(active: !_currentService.active);
            });
            showCustomSnackBar(
              context: context,
              message: _currentService.active
                  ? 'Service activated successfully'
                  : 'Service deactivated successfully',
              type: SnackBarType.success,
            );
          }

          if (state is ServiceStatusUpdateFailedState) {
            showCustomSnackBar(
              context: context,
              message: 'Failed to update service status',
              type: SnackBarType.failure,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ServiceDeletionLoadingState ||
              state is ServiceStatusUpdateLoadingState;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image Section
                _buildHeroImage(),
                Gap(24.h),

                // Service Header Section
                _buildServiceHeader(),
                Gap(16.h),

                // Status Badge
                _buildStatusBadge(),
                Gap(24.h),

                // Details Section
                DetailSection(service: _currentService),
                Gap(24.h),

                // Action Buttons
                ActionButtons(
                  isActive: _currentService.active,
                  // onDelete: () => {},
                  onEdit: () => _navigateToEditScreen(context),
                  onToggleStatus: () => _toggleServiceStatus(context),
                ),
                Gap(32.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: 'service-image-${_currentService.id}',
      child: Container(
        height: 240.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: CachedNetworkImage(
            imageUrl: _currentService.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.surfaceVariant,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.surfaceVariant,
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _currentService.name,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
        Gap(8.h),
        Text(
          _currentService.description,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _currentService.active
            ? AppColors.success.withOpacity(0.1)
            : AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _currentService.active
              ? AppColors.success.withOpacity(0.3)
              : AppColors.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _currentService.active
                ? Icons.check_circle_rounded
                : Icons.pause_circle_rounded,
            size: 16.sp,
            color: _currentService.active ? AppColors.success : AppColors.error,
          ),
          Gap(6.w),
          Text(
            _currentService.active ? 'Active' : 'Inactive',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color:
                  _currentService.active ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: _currentService.active ? AppColors.success : AppColors.error,
        shape: BoxShape.circle,
      ),
    );
  }

  
  void _toggleServiceStatus(BuildContext context) {
    final cubit = ServiceCubit.get(context);
    final newStatus = !_currentService.active;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          newStatus ? "Activate Service" : "Deactivate Service",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          newStatus
              ? "Are you sure you want to activate this service? It will become visible to customers."
              : "Are you sure you want to deactivate this service? It will no longer be visible to customers.",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
            ),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.updateServiceStatus(_currentService.id, _currentService.active);
            },
            style: TextButton.styleFrom(
              foregroundColor: newStatus ? AppColors.success : AppColors.error,
            ),
            child: Text(newStatus ? "Activate" : "Deactivate"),
          ),
        ],
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    navigateTo(
      context,
      UpdateServiceScreen(service: _currentService),
    );
  }
}

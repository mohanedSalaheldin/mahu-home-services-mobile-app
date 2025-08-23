import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServiceCategoryScreen extends StatefulWidget {
  final String categoryName;
  final List<ServiceModel> services;

  const ServiceCategoryScreen({
    super.key,
    required this.categoryName,
    required this.services,
  });

  @override
  State<ServiceCategoryScreen> createState() => _ServiceCategoryScreenState();
}

class _ServiceCategoryScreenState extends State<ServiceCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // Filter services based on category
    final filteredServices = widget.services.where((service) {
      if (widget.categoryName == 'Deep Clean') {
        return service.subType == 'deep';
      } else if (widget.categoryName == 'Recurring') {
        return service.serviceType.toLowerCase() == 'recurring';
      } else if (widget.categoryName == 'One-Time') {
        return service.serviceType.toLowerCase() == 'one-time';
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryDescription(),
            Gap(24.h),

            // Services Count
            Text(
              '${filteredServices.length} Services Available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            Gap(16.h),

            // Services List
            if (filteredServices.isEmpty)
              _buildEmptyState()
            else
              Column(
                children: filteredServices
                    .map((service) => Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: _buildServiceCard(service),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDescription() {
    String description = '';
    String imageUrl = '';

    switch (widget.categoryName) {
      case 'Deep Clean':
        description =
            'Thorough cleaning of all areas including hard-to-reach spots. Perfect for deep sanitization and intensive cleaning needs.';
        imageUrl =
            'https://images.unsplash.com/photo-1600585152220-90363fe7e115';
        break;
      case 'Recurring':
        description =
            'Regular scheduled cleaning services to maintain your space. Set your preferred frequency and enjoy consistent cleanliness.';
        imageUrl =
            'https://images.unsplash.com/photo-1584622650111-993a426fbf0a';
        break;
      case 'One-Time':
        description =
            'Single cleaning sessions for specific needs. Ideal for special occasions, move-ins/move-outs, or when you need a one-time refresh.';
        imageUrl =
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750';
        break;
      default:
        description = 'Browse our cleaning services in this category.';
        imageUrl = 'https://images.unsplash.com/photo-1556911220-bff31c812dba';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              height: 150.h,
              width: double.infinity,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade200),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slide(begin: const Offset(0, 0.1));
  }

  Widget _buildServiceCard(ServiceModel service) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsScreen(service: service),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Service Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                width: 120.w,
                height: 140.h,
                imageUrl: service.image,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey.shade200),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            // Service Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            service.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: service.serviceType.toLowerCase() ==
                                    'recurring'
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            service.serviceType,
                            style: TextStyle(
                              fontSize: 10,
                              color: service.serviceType.toLowerCase() ==
                                      'recurring'
                                  ? Colors.blue
                                  : Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(8.h),

                    // Provider Info
                    _ServiceProviderInfo(
                      providerName:
                          "${service.firstName ?? ''} ${service.lastName ?? ''}".trim(),
                      businessName:
                          service.businessName ?? "Independent Provider",
                      logoUrl: service.avatar,
                    ),

                    Gap(12.h),

                    // Rating + Price
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        Gap(4.w),
                        Text(
                          '0 Reviews',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        const Spacer(),
                        Text(
                          '\$${service.basePrice}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slide(begin: const Offset(0, 0.1));
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Gap(40.h),
        Icon(
          Icons.cleaning_services,
          size: 60,
          color: Colors.grey.shade300,
        ),
        Gap(16.h),
        Text(
          'No services found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(8.h),
        Text(
          'We currently have no ${widget.categoryName.toLowerCase()} services available',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }
}

/// Compact Provider Info Widget for List Cards
class _ServiceProviderInfo extends StatelessWidget {
  final String providerName;
  final String businessName;
  final String? logoUrl;

  const _ServiceProviderInfo({
    super.key,
    required this.providerName,
    required this.businessName,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:
              (logoUrl != null && logoUrl!.isNotEmpty) ? NetworkImage(logoUrl!) : null,
          child: (logoUrl == null || logoUrl!.isEmpty)
              ? Icon(Icons.person, size: 16, color: Colors.grey)
              : null,
        ),
        Gap(8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                providerName.isNotEmpty ? providerName : "Unknown",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                businessName,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

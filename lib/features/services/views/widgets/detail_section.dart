import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class DetailSection extends StatelessWidget {
  final ServiceModel service;

  const DetailSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).detailSectionTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Gap(16.h),
        DetailRow(
          label: S.of(context).detailSectionCategoryLabel,
          value: service.category,
        ),
        DetailRow(
          label: S.of(context).detailSectionServiceTypeLabel,
          value: service.serviceType,
        ),
        DetailRow(
          label: S.of(context).detailSectionSubTypeLabel,
          value: service.subType,
        ),
        DetailRow(
          label: S.of(context).detailSectionPricingModelLabel,
          value: service.pricingModel,
        ),
    DetailRow(
      label: service.serviceType == "recurring"
        ? S.of(context).detailSectionPriceRecurringLabel
        : S.of(context).detailSectionPriceHourlyLabel,
      value: S
        .of(context)
              .detailSectionPriceValue('${service.currency} ${service.basePrice.toStringAsFixed(2)}'),
    ),
        DetailRow(
          label: S.of(context).detailSectionDurationLabel,
          value: S.of(context).detailSectionDurationValue(service.duration),
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

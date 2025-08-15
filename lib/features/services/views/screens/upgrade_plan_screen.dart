import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/services/models/plan_model.dart';
import 'package:mahu_home_services_app/features/services/services/plan_services.dart';

class UpgradePlanScreen extends StatefulWidget {
  final String userId;
  const UpgradePlanScreen({super.key, required this.userId});

  @override
  State<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends State<UpgradePlanScreen> {
  final PlanServices _planServices = PlanServices();
  List<Plan> _plans = [];
  bool _isProcessing = false;
  int? _selectedPlanIndex;

  // Hardcoded plans data
  final List<Map<String, dynamic>> _plansData = [
    {
      "_id": "68700a0108d6c25c2d721620",
      "name": "Basic",
      "description": "Perfect for new cleaning service providers",
      "price": 29.99,
      "duration": 1,
      "features": [
        "5 service listings",
        "20 monthly bookings",
        "Basic profile visibility",
        "Email support"
      ],
      "isActive": true,
      "maxServices": 5,
      "maxBookings": 20,
      "createdAt": "2025-07-10T18:44:17.196Z",
    },
    {
      "_id": "68700a1508d6c25c2d721624",
      "name": "Professional",
      "description": "For established cleaning businesses",
      "price": 79.99,
      "duration": 3,
      "features": [
        "15 service listings",
        "50 monthly bookings",
        "Enhanced profile visibility",
        "Priority support",
        "Performance analytics"
      ],
      "isActive": true,
      "maxServices": 15,
      "maxBookings": 50,
      "createdAt": "2025-07-10T18:44:37.638Z",
    },
    {
      "_id": "68700a2a08d6c25c2d721628",
      "name": "Enterprise",
      "description": "For large cleaning service operations",
      "price": 199.99,
      "duration": 6,
      "features": [
        "Unlimited service listings",
        "Unlimited bookings",
        "Premium profile placement",
        "24/7 dedicated support",
        "Advanced analytics",
        "Marketing tools"
      ],
      "isActive": true,
      "maxServices": 999,
      "maxBookings": 999,
      "createdAt": "2025-07-10T18:44:58.557Z",
    }
  ];

  @override
  void initState() {
    super.initState();
    _initializePlans();
  }

  void _initializePlans() {
    _plans = _plansData.map((plan) => Plan.fromJson(plan)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Your Plan'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header with description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Text(
              'Choose the plan that fits your business needs',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          // Plans list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: _plans.length,
              itemBuilder: (context, index) {
                final plan = _plans[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: _PlanCard(
                    plan: plan,
                    isSelected: _selectedPlanIndex == index,
                    onTap: () => _handlePlanSelection(index),
                  ),
                );
              },
            ),
          ),
          
          // Bottom action button
          if (_selectedPlanIndex != null)
            Padding(
              padding: EdgeInsets.all(24.w),
              child: _SubscribeButton(
                isLoading: _isProcessing,
                onPressed: _isProcessing ? null : () => _confirmSubscription(),
              ),
            ),
        ],
      ),
    );
  }

  void _handlePlanSelection(int index) {
    setState(() {
      _selectedPlanIndex = index;
    });
  }

  Future<void> _confirmSubscription() async {
    if (_selectedPlanIndex == null) return;

    final plan = _plans[_selectedPlanIndex!];
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SubscriptionConfirmationDialog(plan: plan),
    );

    if (confirmed == true) {
      await _subscribeToPlan(plan.id);
    }
  }

  Future<void> _subscribeToPlan(String planId) async {
    setState(() => _isProcessing = true);
    
    try {
      final result = await _planServices.subscribeToPlan(
        userId: widget.userId,
        planId: planId,
      );

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message),
              backgroundColor: Colors.red,
            ),
          );
        },
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Subscription successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }
}

class _PlanCard extends StatelessWidget {
  final Plan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isSelected ? 6 : 2,
      borderRadius: BorderRadius.circular(12),
      color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    plan.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Selected',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                plan.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                '\$${plan.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'per ${plan.duration} month${plan.duration > 1 ? 's' : ''}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.h),
              const Divider(),
              SizedBox(height: 16.h),
              Text(
                'Plan Features:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Column(
                children: plan.features.map((feature) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        size: 18.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscribeButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SubscribeButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Subscribe Now',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

class SubscriptionConfirmationDialog extends StatelessWidget {
  final Plan plan;

  const SubscriptionConfirmationDialog({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Subscription',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'You are about to subscribe to:',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              plan.name,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24.h),
            _buildDetailRow('Price', '\$${plan.price.toStringAsFixed(2)}'),
            _buildDetailRow('Duration', '${plan.duration} month(s)'),
            SizedBox(height: 24.h),
            const Text(
              'This subscription will automatically renew unless canceled.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
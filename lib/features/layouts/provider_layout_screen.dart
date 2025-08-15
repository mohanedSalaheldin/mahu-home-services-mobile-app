import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_calender.dart';
import 'package:mahu_home_services_app/features/services/views/screens/profile_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_jobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderLayoutScreen extends StatelessWidget {
  ProviderLayoutScreen({super.key});

  final List<Widget> screens = [
    const ServiceProviderDashboardScreen(),
    const ServiceProviderJobsScreen(),
    const ServiceProviderBookingsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProviderNavigationCubit(),
      child: BlocBuilder<ProviderNavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: _CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) =>
                  context.read<ProviderNavigationCubit>().changeTab(index),
            ),
          );
        },
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            icon: Icons.work_outline,
            activeIcon: Icons.work,
            label: 'Jobs',
            isActive: currentIndex == 1,
            onTap: () {
              onTap(1);
              context.read<ServiceCubit>().fetchMyBookings();
            },
          ),
          _NavBarItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today,
            label: 'Calendar',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            size: 24.sp,
            color: isActive ? Colors.blue.shade300 : Colors.grey.shade600,
          ),
          Gap(4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? Colors.blue.shade300 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// navigation_cubit.dart (same as before)
class ProviderNavigationCubit extends Cubit<int> {
  ProviderNavigationCubit() : super(0);
  static ProviderNavigationCubit get(context) => BlocProvider.of(context);

  void changeTab(int index) => emit(index);
}

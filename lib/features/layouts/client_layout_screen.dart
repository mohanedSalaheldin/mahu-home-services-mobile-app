import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
// C:\nodejs-projects\mahu-app-veersion2\mahu-home-services-mobile-app\lib\features\user_booking\views\screens\my_bookings_screen.dart
import 'package:mahu_home_services_app/features/user_booking/views/screens/my_bookings_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/customer_home_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/profile_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/my_favorite_services_screen.dart';
class ClientLayoutScreen extends StatelessWidget {
  ClientLayoutScreen({super.key});

  final List<Widget> screens = [
    const CustomerHomeScreen(),
    const MyBookingsScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientNavigationCubit(),
      child: BlocBuilder<ClientNavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) =>
                  context.read<ClientNavigationCubit>().changeTab(index),
            ),
          );
        },
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
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
            activeIcon: Icons.home_rounded,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            icon: Icons.calendar_today_outlined,
            activeIcon: Icons.calendar_today_rounded,
            label: 'Bookings',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavBarItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            label: 'Favorites',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person_rounded,
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
      child: SizedBox(
        width: 70.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive ? Colors.blue : Colors.grey.shade600,
              ),
            ),
            Gap(4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.blue : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClientNavigationCubit extends Cubit<int> {
  ClientNavigationCubit() : super(0);

  void changeTab(int index) => emit(index);
}
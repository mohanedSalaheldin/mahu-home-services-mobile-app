import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_dashboard_screen.dart';

class ProviderLayoutScreen extends StatelessWidget {
  ProviderLayoutScreen({super.key});
  final List<Widget> screens = [
    const ServiceProviderDashboardScreen(), // Home screen
    const Placeholder(), // Jobs screen
    const Placeholder(), // Calendar screen
    const Placeholder(), // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) =>
                  context.read<NavigationCubit>().changeTab(index),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.blue.shade300,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.work_outline),
                  label: 'Jobs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  label: 'Calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// navigation_cubit.dart

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void changeTab(int index) => emit(index);
}

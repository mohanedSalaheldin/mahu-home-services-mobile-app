// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
// import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'My Profile',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.bold,
//             color: AppColors.primary,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: BlocConsumer<UserProfileCubit, UserProfileState>(
//         listener: (context, state) {
//           if (state is UserProfileError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.redAccent,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is UserProfileLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final user = context.read<UserProfileCubit>().user;
//           return SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _ProfileHeader(user: user).animate().fadeIn(delay: 100.ms),
//                 Gap(24.h),
//                 _ProfileOption(
//                   icon: Icons.edit,
//                   title: 'Edit Profile',
//                   onTap: () {
//                     // Navigate to edit profile screen
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Edit Profile tapped')),
//                     );
//                   },
//                 ).animate().fadeIn(delay: 200.ms),
//                 Gap(16.h),
//                 _ProfileOption(
//                   icon: Icons.payment,
//                   title: 'Payment Methods',
//                   onTap: () {
//                     // Navigate to payment methods screen
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Payment Methods tapped')),
//                     );
//                   },
//                 ).animate().fadeIn(delay: 300.ms),
//                 Gap(16.h),
//                 _ProfileOption(
//                   icon: Icons.settings,
//                   title: 'Settings',
//                   onTap: () {
//                     // Navigate to settings screen
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Settings tapped')),
//                     );
//                   },
//                 ).animate().fadeIn(delay: 400.ms),
//                 Gap(16.h),
//                 _ProfileOption(
//                   icon: Icons.logout,
//                   title: 'Log Out',
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const RoleSelectionScreen(),
//                       ),
//                     );
//                   },
//                   color: Colors.red,
//                 ).animate().fadeIn(delay: 500.ms),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _ProfileHeader extends StatelessWidget {
//   final dynamic user; // Replace with actual User model

//   const _ProfileHeader({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     // Sample user data (replace with actual model)
//     final name = user?.name ?? 'John Doe';
//     final email = user?.email ?? 'john.doe@example.com';
//     final phone = user?.phone ?? '+1 123-456-7890';

//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40.r,
//               backgroundColor: AppColors.primary.withOpacity(0.2),
//               child: Text(
//                 name[0].toUpperCase(),
//                 style: TextStyle(fontSize: 32.sp, color: AppColors.primary),
//               ),
//             ),
//             Gap(16.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                   ),
//                   Gap(4.h),
//                   Text(
//                     email,
//                     style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//                   ),
//                   Gap(4.h),
//                   Text(
//                     phone,
//                     style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProfileOption extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//   final Color? color;

//   const _ProfileOption({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon, size: 24.sp, color: color ?? AppColors.primary),
//       title: Text(
//         title,
//         style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: color ?? Colors.black),
//       ),
//       trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey.shade600),
//       onTap: onTap,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
//       tileColor: Colors.grey.shade50,
//     );
//   }
// }

// // Sample UserProfileCubit (create this if not exists)
// class UserProfileCubit extends Cubit<UserProfileState> {
//   UserProfileCubit() : super(UserProfileInitial());

//   dynamic get user => {
//         'name': 'John Doe',
//         'email': 'john.doe@example.com',
//         'phone': '+1 123-456-7890',
//       }; // Replace with actual user fetch logic

//   void fetchUserProfile() {
//     // Implement actual fetch logic
//     emit(UserProfileLoaded());
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontSize: 20.sp)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated construction icon
            Icon(
              Icons.construction_rounded,
              size: 80.w,
              color: Colors.blue,
            ),
            Gap(24.h),
            
            // Main title
            Text(
              'Under Development',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(16.h),
            
            // Subtitle
            Text(
              'We\'re working hard to bring you\nan amazing profile experience!',
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(32.h),
            
            
            
            // Coming soon text
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

}


abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {}

class UserProfileError extends UserProfileState {
  final String message;
  UserProfileError(this.message);
}


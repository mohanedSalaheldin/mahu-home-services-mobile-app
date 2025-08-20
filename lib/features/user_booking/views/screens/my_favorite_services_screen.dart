import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites', style: TextStyle(fontSize: 20.sp)),
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
              'We\'re working hard to bring you\nan amazing favorites experience!',
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
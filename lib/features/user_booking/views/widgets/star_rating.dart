import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double size;
  final Color color;
  final bool allowEditing;
  final Function(int)? onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 24,
    this.color = Colors.amber,
    this.allowEditing = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: allowEditing ? () => onRatingChanged?.call(index + 1) : null,
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: size.w,
            color: color,
          ),
        );
      }),
    );
  }
}
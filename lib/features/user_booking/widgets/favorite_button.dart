import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool initialValue;
  final Function(bool)? onChanged;
  final double size;

  const FavoriteButton({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.size = 24.0,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialValue;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.onChanged?.call(isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleFavorite,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 1.0,
          end: isFavorite ? 1.1 : 1.0,
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                key: ValueKey<bool>(isFavorite),
                color: isFavorite ? Colors.red : Colors.black,
                size: widget.size,
              ),
            ),
          );
        },
      ),
    );
  }
}

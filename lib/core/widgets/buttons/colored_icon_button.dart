import 'package:flutter/material.dart';

class ColoredIconButton extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;
  final Function()? onTap;
  final double size;
  final double iconSize;

  const ColoredIconButton({
    super.key,
    required this.icon,
    required this.colors,
    this.onTap,
    this.size = 60,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGradient = colors.length > 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isGradient ? null : colors.first,
          gradient: isGradient
              ? LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

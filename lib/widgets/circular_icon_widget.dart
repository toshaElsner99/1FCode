import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';

class CircularIconWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final double size;
  final double iconSize;

  const CircularIconWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    this.size = 40,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: iconColor,
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}

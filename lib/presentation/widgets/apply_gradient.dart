import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:nao_controller/colors.dart' as colors;

class ApplyGradient extends StatelessWidget {

  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final List<Color> gradientColors;

  const ApplyGradient({
    super.key,
    this.width,
    this.height,
    required this.child,
    required this.gradientColors,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
          transform: const GradientRotation(math.pi * 2)
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: colors.dark.withOpacity(0.3),
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 60)
        )
      ),
      child: child
    );
  }
}
import 'package:flutter/material.dart';

import 'package:nao_controller/colors.dart' as colors;

class IconCard extends StatelessWidget {
  
  final Icon icon;
  final Color backgroundColor;
  final void Function() onClick;

  const IconCard({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      elevation: 6,
      shadowColor: colors.dark.withOpacity(0.5),
      color: backgroundColor,
      child: Center(
        child: IconButton(
          icon: icon,
          onPressed: onClick,
        ),
      ),
    );
  }
}
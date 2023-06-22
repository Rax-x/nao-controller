import 'package:flutter/material.dart';

import 'package:nao_controller/colors.dart' as colors;
import 'package:nao_controller/utils/utils.dart';

class ControllerWidget extends StatelessWidget {

  final void Function() onUpPressed;
  final void Function() onDownPressed;
  final void Function() onLeftPressed;
  final void Function() onRightPressed;
  final bool disabled;

  const ControllerWidget({
    super.key, 
    this.disabled = false,
    required this.onUpPressed,
    required this.onDownPressed,
    required this.onLeftPressed,
    required this.onRightPressed
  });

  List<Widget> _getArrowButtons(double circleRadius, double innerCircleRadius){

    double space = ((circleRadius * 2) - (innerCircleRadius * 2)) / 2;

    final iconSize = space * 0.9;
    double padding = space - iconSize;

    return [
      Positioned(
        top: padding,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: !disabled ? onUpPressed : null,
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
            size: iconSize,
          ),
        )
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: padding,
        child: GestureDetector(
          onTap: !disabled ? onDownPressed : null,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: iconSize,
          ),
        )
      ),
      Positioned(
        top: 0,
        left: padding,
        bottom: 0,
        child: GestureDetector(
          onTap: !disabled ? onLeftPressed : null,
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: iconSize,
          ),
        )
      ),
      Positioned(
        top: 0,
        right: padding,
        bottom: 0,
        child: GestureDetector(
          onTap: !disabled ? onRightPressed : null,
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: iconSize, 
          ),
        )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    final size = screenSizeOf(context);

    final circleDiameter = size.width * 0.5;
    
    final circleRadius = circleDiameter / 2;
    final innerCircleRadius = circleRadius / 2.5;

    return SizedBox(
      width: circleDiameter,
      height: circleDiameter,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: circleDiameter,
              height: circleDiameter,
              child: Center(
                child: CustomPaint(
                  painter: _CirclesPainter(
                    innerCircleRadius: innerCircleRadius,
                    radius: circleRadius,
                    circleColor: colors.dark,
                    innerCircleColor: colors.red
                  ),
                )
              )
            ),
            ..._getArrowButtons(circleRadius, innerCircleRadius)
          ],
        ),
      )
    );
  }
}

class _CirclesPainter extends CustomPainter {
  
  final double radius;
  final double innerCircleRadius;
  final Color circleColor;
  final Color innerCircleColor;

  _CirclesPainter({
    required this.innerCircleRadius,
    required this.radius,
    required this.circleColor,
    required this.innerCircleColor
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, radius, paint);
    
    paint.color = innerCircleColor;
    canvas.drawCircle(
      Offset.zero, 
      innerCircleRadius, 
      paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
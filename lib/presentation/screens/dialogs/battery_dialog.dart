import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/utils/utils.dart';

import 'package:nao_controller/colors.dart' as colors;

class BatteryDialog extends ConsumerWidget {

  const BatteryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final size = screenSizeOf(context);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: size.height * 0.2,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Batteria",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25
                    ),
                  ),
                  Icon(
                    Icons.battery_5_bar_rounded,
                    color: colors.green,
                    size: 50,
                  )
                ],
              ),
              Text(
                "90%",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
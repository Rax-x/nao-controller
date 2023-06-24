import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/providers/states/battery_dialog_provider.dart';
import 'package:nao_controller/utils/utils.dart';

import 'package:nao_controller/colors.dart' as colors;

class BatteryDialog extends ConsumerWidget {

  const BatteryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final size = screenSizeOf(context);
    final asyncState = ref.watch(batteryDialogProvider);

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
          child: asyncState.when(
            data: (state){
              final batteryLevel = state is BatteryDialogStateError 
                ? state.message 
                : (state as BatteryDialogStateSuccess).batteryLevel;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
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
                    batteryLevel,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 40
                    ),
                  )
                ]
              );
            }, 
            error: (err, _) => const Center(
              child: Text("An error occurred, check your internet connection!")
            ), 
            loading: () => const Center(
              child: CircularProgressIndicator(),
            )
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/entities/led_event.dart';
import 'package:nao_controller/presentation/widgets/apply_gradient.dart';
import 'package:nao_controller/utils/utils.dart';

class LedsDialog extends ConsumerWidget {
  
  const LedsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final size = screenSizeOf(context);
    final backgroundColor = colorSchemeOf(context).primary;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(40)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  ListTile(
                    title: const Text('Rasta Animation'),
                    leading: Radio<LedEvent>(
                      value: LedEvent.rastaEvent,
                      groupValue: null,
                      onChanged: (LedEvent? value) {
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Random eyes Animation'),
                    leading: Radio<LedEvent>(
                      value: LedEvent.randomEyesEvent,
                      groupValue: null,
                      onChanged: (LedEvent? value) {
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Off'),
                    leading: Radio<LedEvent>(
                      value: LedEvent.offEvent,
                      groupValue: null,
                      onChanged: (LedEvent? value) {
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('On'),
                    leading: Radio<LedEvent>(
                      value: LedEvent.onEvent,
                      groupValue: null,
                      onChanged: (LedEvent? value) {
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Reset'),
                    leading: Radio<LedEvent>(
                      value: LedEvent.resetEvent,
                      groupValue: null,
                      onChanged: (LedEvent? value) {
                      },
                    ),
                  ),
                ],
              ),
              ApplyGradient(
                width: size.width * 0.3,
                gradientColors: [
                  Colors.white,
                  backgroundColor
                ],
                child: TextButton(
                  onPressed: (){
                    // TODO: send event to nao
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Invia",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800
                    ),
                  )
                ), 
              )
            ]
          ),
        ),
      ),
    );
  }
}
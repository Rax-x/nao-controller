import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/domain/entities/led_mode.dart';
import 'package:nao_controller/presentation/providers/states/leds_dialog_state_notifier.dart';
import 'package:nao_controller/presentation/widgets/apply_gradient.dart';
import 'package:nao_controller/utils/utils.dart';

final _currentModeProvider = StateProvider<LedMode>((ref) => LedMode.rasta);

class LedsDialog extends ConsumerWidget {
  
  const LedsDialog({super.key});

  void _handleState(BuildContext context, LedsDialogState state){
    if(state.hadError){
      showErrorSnackBar(context, state.error!);
    }

    if(state.hadError || state.isSent){
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final size = screenSizeOf(context);
    final backgroundColor = colorSchemeOf(context).primary;

    final currentMode = ref.watch(_currentModeProvider);
    final modeNotifier = ref.read(_currentModeProvider.notifier);

    final state = ref.watch(ledsDialogStateNotifier);
    final notifier = ref.read(ledsDialogStateNotifier.notifier);

    ref.listen<LedsDialogState>(ledsDialogStateNotifier, (_, state){
      _handleState(context, state);
    });

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
                    leading: Radio<LedMode>(
                      value: LedMode.rasta,
                      groupValue: currentMode,
                      onChanged: (LedMode? value) {
                        modeNotifier.state = value ?? LedMode.randomEyes;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Random eyes Animation'),
                    leading: Radio<LedMode>(
                      value: LedMode.randomEyes,
                      groupValue: currentMode,
                      onChanged: (LedMode? value) {
                        modeNotifier.state = value ?? LedMode.randomEyes;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Off'),
                    leading: Radio<LedMode>(
                      value: LedMode.off,
                      groupValue: currentMode,
                      onChanged: (LedMode? value) {
                        modeNotifier.state = value ?? LedMode.randomEyes;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('On'),
                    leading: Radio<LedMode>(
                      value: LedMode.on,
                      groupValue: currentMode,
                      onChanged: (LedMode? value) {
                        modeNotifier.state = value ?? LedMode.randomEyes;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Reset'),
                    leading: Radio<LedMode>(
                      value: LedMode.reset,
                      groupValue: currentMode,
                      onChanged: (LedMode? value) {
                        modeNotifier.state = value ?? LedMode.randomEyes;
                      },
                    ),
                  ),
                ],
              ),
              (state.isLoading) 
                ? const CircularProgressIndicator() 
                : ApplyGradient(
                    width: size.width * 0.3,
                    gradientColors: [
                      Colors.white,
                      backgroundColor
                    ],
                    child: TextButton(
                      onPressed: () => notifier.sendLedsMode(currentMode),
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
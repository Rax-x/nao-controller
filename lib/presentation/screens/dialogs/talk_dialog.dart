import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/widgets/apply_gradient.dart';
import 'package:nao_controller/presentation/widgets/input_field.dart';
import 'package:nao_controller/utils/utils.dart';

class TalkDialog extends ConsumerStatefulWidget {
  const TalkDialog({super.key});

  @override
  ConsumerState<TalkDialog> createState() => _TalkDialogState();
}

class _TalkDialogState extends ConsumerState<TalkDialog> {
  
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();

    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
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
          height: size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: size.width * 0.8,
                child: InputField(
                  label: "Cosa deve dire Nao?", 
                  editingController: _editingController
                ),
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
import 'package:flutter/material.dart';

import 'package:nao_controller/colors.dart' as colors;

class InputField extends StatefulWidget {
  
  final TextEditingController editingController;
  final String label;
  
  const InputField({
    super.key,
    required this.label,
    required this.editingController
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(40)
          )
      ),
      child: TextField(
        controller: widget.editingController,
        decoration: InputDecoration(
          hintText: widget.label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: colors.seed
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(40)
            )
          )
        )
      )
    );
  }
}
import 'package:flutter/material.dart';

import 'package:nao_controller/colors.dart' as colors;

class InputField extends StatelessWidget {

  final String label;
  final TextEditingController editingController;
  final TextInputType type;

  const InputField({
    super.key,
    required this.label,
    required this.editingController,
    this.type = TextInputType.text
  });

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
        keyboardType: type,
        controller: editingController,
        decoration: InputDecoration(
          hintText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: colors.primary
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nao_controller/presentation/widgets/apply_gradient.dart';
import 'package:nao_controller/presentation/widgets/input_field.dart';
import 'package:nao_controller/utils/utils.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: size.height,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft:  Radius.circular(80),
                  bottomRight: Radius.circular(80)
                )
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.14,
              child: SvgPicture.asset(
                "assets/nao-icon.svg",
                width: size.width * 0.3,
              )
            ),
            Positioned(
              top: size.height * 0.45,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: size.width * 0.8,
                  child: InputField(
                    label: "Inserici l'IP di Nao", 
                    editingController: _editingController
                  )
                )
              )
            ),
            Positioned(
              bottom: size.height * 0.2,
              left: 0,
              right: 0,
              child: Center(
                child: ApplyGradient(
                  width: size.width * 0.4,
                  gradientColors: [
                    Colors.white,
                    backgroundColor
                  ],
                  child: TextButton(
                    child: Text(
                      "Connetti".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                      ),
                    ),
                    onPressed: () {},
                  )
                )
              )
            )
          ],
        )
      )
    );
  }
}
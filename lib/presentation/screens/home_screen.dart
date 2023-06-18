import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/utils/utils.dart';

import 'package:nao_controller/colors.dart' as colors;
import 'package:nao_controller/app_routes.dart' as routes;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final backgroundColor = colorSchemeOf(context).primary;
    final size = screenSizeOf(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text("Azioni"),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: Center(
        child: GridView.count(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20),
          children: [
            GestureDetector(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  color: colors.red,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: colors.dark.withOpacity(0.3),
                    )
                  ]
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.record_voice_over_rounded,
                  size: size.width * 0.2,
                  color: Colors.white,
                ),
              )
            ),
            GestureDetector(
              onTap: () => navigateTo(context, routes.walk),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.yellow,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: colors.dark.withOpacity(0.3),
                    )
                  ]
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.directions_run_rounded,
                  size: size.width * 0.2,
                  color: Colors.white,
                ),
              )
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  color: colors.lightBlue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: colors.dark.withOpacity(0.3),
                    )
                  ]
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.light_mode_rounded,
                  size: size.width * 0.2,
                  color: Colors.white,
                ),
              )
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  color: colors.green,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40)
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: colors.dark.withOpacity(0.3),
                    )
                  ]
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.battery_5_bar_rounded,
                  size: size.width * 0.2,
                  color: Colors.white,
                ),
              )
            )
          ],
        )
      ),
    );
  }
}
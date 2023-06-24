import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/providers/states/home_state_notifier.dart';
import 'package:nao_controller/presentation/screens/dialogs/battery_dialog.dart';
import 'package:nao_controller/presentation/screens/dialogs/leds_dialog.dart';
import 'package:nao_controller/presentation/screens/dialogs/talk_dialog.dart';
import 'package:nao_controller/presentation/widgets/icon_card.dart';
import 'package:nao_controller/utils/utils.dart';

import 'package:nao_controller/colors.dart' as colors;
import 'package:nao_controller/app_routes.dart' as routes;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final backgroundColor = colorSchemeOf(context).primary;
    final size = screenSizeOf(context);

    ref.listen(homeStateNotifierProvider, (_, state) {
      if(state is! HomeStateError) return;

      showErrorSnackBar(context, state.error);

      if(state.shoudReturnToConnectScreen){
        navigateTo(
          context, 
          routes.connect, 
          shouldPopOldRoutes: true
        );
      }
      
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text("Azioni"),
        actions: [
          IconButton(
            onPressed: (){
              ref.read(homeStateNotifierProvider.notifier)
                .disconnect()
                .whenComplete((){
                  navigateTo(
                    context, 
                    routes.connect, 
                    shouldPopOldRoutes: true
                  );
                });
            }, 
            icon: const Icon(Icons.logout_rounded)
          )
        ]
      ),
      body: Center(
        child: GridView.count(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(20),
          children: [
            IconCard(
              onClick: (){
                showDialog(
                  context: context, 
                  builder: (context)=> ProviderScope(
                    parent: ProviderScope.containerOf(context),
                    child: const TalkDialog()
                  )
                );
              },
              backgroundColor: colors.red,
              icon: Icon(
                Icons.record_voice_over_rounded,
                size: size.width * 0.2,
                color: Colors.white,
              )
            ),
            IconCard(
              onClick: () => navigateTo(context, routes.walk),
              backgroundColor: colors.yellow,
              icon: Icon(
                Icons.directions_run_rounded,
                size: size.width * 0.2,
                color: Colors.white,
              )
            ),
            IconCard(
              onClick: (){
                showDialog(
                  context: context, 
                  builder: (context) => ProviderScope(
                    parent: ProviderScope.containerOf(context),
                    child: const LedsDialog()
                  )
                );
              },
              backgroundColor: colors.lightBlue,
              icon: Icon(
                Icons.light_mode_rounded,
                size: size.width * 0.2,
                color: Colors.white,
              )
            ),
            IconCard(
              onClick: (){
                showDialog(
                  context: context, 
                  builder: (context) => ProviderScope(
                    parent: ProviderScope.containerOf(context),
                    child: const BatteryDialog()
                  )
                );
              },
              backgroundColor: colors.green,
              icon: Icon(
                Icons.battery_5_bar_rounded,
                size: size.width * 0.2,
                color: Colors.white,
              )
            )
          ]
        )
      )
    );
  }
}
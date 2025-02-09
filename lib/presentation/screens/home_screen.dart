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

  void _showErrorAndGoToConnectScreen(BuildContext context, String error){
    showErrorSnackBar(context, error);
    navigateTo(
      context, 
      routes.connect, 
      shouldPopOldRoutes: true
    );
  }

  void _handleState(BuildContext context, HomeState state){
    if(state.hadError){
      _showErrorAndGoToConnectScreen(context, state.error!);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final backgroundColor = colorSchemeOf(context).primary;
    final size = screenSizeOf(context);

    final notifier = ref.read(homeStateNotifierProvider.notifier);
    final state = ref.watch(homeStateNotifierProvider);

    ref.listen(homeStateNotifierProvider, (_, state) {
      _handleState(context, state);
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text("Azioni"),
        actions: [
          IconButton(
            onPressed: () {

              try{
                notifier.shutdownServer()
                  .whenComplete((){
                    
                    if(!context.mounted) return;

                    navigateTo(
                      context, 
                      routes.connect, 
                      shouldPopOldRoutes: true
                    );
                  });
              } on Exception catch(e){
                _showErrorAndGoToConnectScreen(
                  context, 
                  e.toString()
                );
              }
            },
            icon: const Icon(Icons.power_settings_new_rounded)
          ),
          IconButton(
            onPressed: (){
              try{
                notifier.disconnect()
                  .whenComplete((){
                    if(!context.mounted) return;
                    
                    navigateTo(
                      context, 
                      routes.connect, 
                      shouldPopOldRoutes: true
                    );
                  });
              } on Exception catch(e){
                _showErrorAndGoToConnectScreen(
                  context, 
                  e.toString()
                );
              }
            }, 
            icon: const Icon(Icons.logout_rounded)
          )
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
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
                      builder: (_) => const TalkDialog()
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
                      builder: (_) => const LedsDialog()
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
                      builder: (_) => const BatteryDialog()
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
          ),
          if(state.isLoading) SizedBox(
            height: size.height * 0.2,
            child: const Center(
              child: CircularProgressIndicator()
            ),
          )
        ]
      )
    );
  }
}
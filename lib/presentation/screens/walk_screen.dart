import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nao_controller/presentation/providers/states/walk_state_notifier.dart';
import 'package:nao_controller/presentation/widgets/apply_gradient.dart';
import 'package:nao_controller/presentation/widgets/controller_widget.dart';
import 'package:nao_controller/presentation/widgets/input_field.dart';
import 'package:nao_controller/utils/utils.dart';

final _customMomvementsProvider = StateProvider<bool>((ref) => false);

class WalkScreen extends ConsumerStatefulWidget {
  
  const WalkScreen({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalkScreenState();
}

class _WalkScreenState extends ConsumerState<WalkScreen> {

  late TextEditingController _xAxisEditingController;
  late TextEditingController _yAxisEditingController;

  @override
  void initState() {
    super.initState();

    _xAxisEditingController = TextEditingController(text: "1");
    _yAxisEditingController = TextEditingController(text: "0");
  }

  @override
  void dispose() {
    super.dispose();

    _xAxisEditingController.dispose();
    _yAxisEditingController.dispose();
  }

  void _handleErrorState(WalkState state){
    if(state.hadError){
      showErrorSnackBar(context, state.error!);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final bool isCustomMovmentsChecked = ref.watch(_customMomvementsProvider);

    final notifier = ref.read(walkStateNotifierProvider.notifier);
    final state = ref.watch(walkStateNotifierProvider);

    final backgroundColor = colorSchemeOf(context).primary;
    final width = screenSizeOf(context).width;

    ref.listen<WalkState>(walkStateNotifierProvider, (_, state){
      _handleErrorState(state);
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text("Movimenti"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ControllerWidget(
              disabled: isCustomMovmentsChecked || state.isLoading,
              onUpPressed: () => notifier.walkTo(1, 0), 
              onDownPressed: () => notifier.walkTo(-1, 0), 
              onLeftPressed: () => notifier.walkTo(0, 1), 
              onRightPressed: () => notifier.walkTo(0, -1)
            ),
            (!isCustomMovmentsChecked && state.isLoading) 
              ? const CircularProgressIndicator()
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Coordinate Personalizzate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Checkbox(
                    value: isCustomMovmentsChecked, 
                    onChanged: (isChecked){
                      ref.read(_customMomvementsProvider.notifier)
                        .state = isChecked ?? false;
                    }
                  )
                ],
              ),
            if(isCustomMovmentsChecked) Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.25,
                      child: InputField(
                        label: "Asse X",
                        type: TextInputType.number,
                        editingController: _xAxisEditingController,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                      child: InputField(
                        label: "Asse Y",
                        type: TextInputType.number,
                        editingController: _yAxisEditingController,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: (state.isLoading) 
                    ? const CircularProgressIndicator() 
                    : ApplyGradient(
                        width: width * 0.4,
                        gradientColors: [
                          Colors.white,
                          backgroundColor
                        ],
                        child: TextButton(
                          child: Text(
                            "Invia".toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              color: Colors.white
                            ),
                          ),
                          onPressed: () {

                            final x = double.tryParse(_xAxisEditingController.text) ?? 0;
                            final y = double.tryParse(_yAxisEditingController.text) ?? 0;

                            notifier.walkTo(x, y);
                          },
                        )
                      )
                )
              ],
            )
          ],
        ) 
      )
    );
  }


}
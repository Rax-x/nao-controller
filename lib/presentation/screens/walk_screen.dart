import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    _yAxisEditingController = TextEditingController(text: "1");
  }

  @override
  void dispose() {
    super.dispose();

    _xAxisEditingController.dispose();
    _yAxisEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    bool isCustomMovmentsChecked = ref.watch(_customMomvementsProvider);

    final backgroundColor = colorSchemeOf(context).primary;
    final width = screenSizeOf(context).width;

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
              onUpPressed: (){}, 
              onDownPressed: (){}, 
              onLeftPressed: (){}, 
              onRightPressed: (){}
            ),
            Row(
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
                        label: "X",
                        type: TextInputType.number,
                        editingController: _xAxisEditingController,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                      child: InputField(
                        label: "Y",
                        type: TextInputType.number,
                        editingController: _yAxisEditingController,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ApplyGradient(
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
                      onPressed: () {},
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
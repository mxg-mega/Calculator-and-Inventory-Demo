import "package:api_learn/providers/display_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class KeyPad extends StatelessWidget {
  const KeyPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildKeyRow(context, ['1', '2', '3', '+']),
        buildKeyRow(context, ['4', '5', '6', '-']),
        buildKeyRow(context, ['7', '8', '9', 'x']),
        buildKeyRow(context, ['0', '=', 'C'])
      ],
    );
  }

  Widget buildKeyRow(BuildContext context, List<String> buttons){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: buttons.map((button) {
      return NumButton(button: button);
    }).toList(),
    );
  }
}

class NumButton extends StatelessWidget{
  const NumButton({super.key, required this.button});
  final String button;
  
  @override
  Widget build (BuildContext context){
    var providerDisplay = Provider.of<DisplayProvider>(context);
    
    return ElevatedButton(
      onPressed: () {
        if (button == 'C'){
          providerDisplay.clear();
        }
        else if (button == '='){
          providerDisplay.calculate();
        }
        else if ((['+', '-', 'X', '/']).contains(button)) {
          providerDisplay.inputOperator(button);
        }
        else
        {
          providerDisplay.getInput(button);
        }
      },
      child: Text(button),
    );
  }
}


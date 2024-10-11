import "package:api_learn/providers/display_provider.dart";
import "package:api_learn/key_pad.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  Widget display(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepOrange),
      ),
      child: Consumer<DisplayProvider>(
        builder: (context, provider, child) {
          return Text(provider.display);
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          display(),
          const KeyPad(),
        ],
      ),
    );
  }
}

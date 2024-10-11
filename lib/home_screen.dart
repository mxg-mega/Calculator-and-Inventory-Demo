import "package:api_learn/providers/active_screen_provider.dart";
import "package:api_learn/providers/data_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "calculator_screen.dart";
import "inventory_screen.dart";

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String calculator = "Calculator Demo";
    String inventory = "Inventory Demo";
    var screenProvider = Provider.of<ActiveScreenProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text(calculator),
              onTap: () {
                screenProvider.changeTitle(calculator);
                screenProvider.changeActiveScreen(const CalculatorScreen());
              },
            ),
            ListTile(
              title: Text(inventory),
              onTap: () {
                screenProvider.changeTitle(inventory);
                screenProvider.changeActiveScreen(const InventoryScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(screenProvider.screenTitle),
      ),
      body: Center(
        child: Consumer<ActiveScreenProvider>(
          builder: (context, provider, child) {
            return provider.activeScreen;
          },
        ),
      ),
    );
  }
}

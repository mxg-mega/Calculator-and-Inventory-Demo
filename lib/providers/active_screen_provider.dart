import "package:api_learn/calculator_screen.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ActiveScreenProvider extends ChangeNotifier{
  String _screenTitle = 'Demos';
  Widget _activeScreen = const CalculatorScreen();

  Widget get activeScreen => _activeScreen;
  String get screenTitle => _screenTitle;

  void changeActiveScreen(Widget screen){
    _activeScreen = screen;
    notifyListeners();
  }
  void changeTitle(String title){
    _screenTitle = title;
    notifyListeners();
  }
}
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DisplayProvider extends ChangeNotifier {
  String _display = '0';
  String _firstNum = '';
  String _secNum = '';
  String _operator = '';
  double result = 0;

  String get display => _display;

  void getInput(String newNumber) {
    if (_firstNum.isEmpty) {
      _firstNum += newNumber;
      _display = _firstNum;
      notifyListeners();
    } else if (_operator.isNotEmpty) {
      _secNum += newNumber;
      _display += _secNum;
      notifyListeners();
    }
  }

  void inputOperator(String op) {
    if (_firstNum.isNotEmpty && _secNum.isNotEmpty && (result != 0)) {
      _firstNum = result.toString();
      _secNum = '';
    }
    _operator = op;
    _display += ' $op ';
    notifyListeners();
  }

  void clear() {
    _display = '0';
    _firstNum = '';
    _secNum = '';
    _operator = '';
    notifyListeners();
  }

  void calculate() {
    double num1 = 0;
    double num2 = 0;

    if (_firstNum.isNotEmpty && _secNum.isNotEmpty && _operator.isNotEmpty) {
      num1 = double.parse(_firstNum);
      num2 = double.parse(_secNum);
    }

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
    }
    _display = result.toString();
    notifyListeners();
  }
}

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  void Increment() {
    counter++;
    notifyListeners();
  }

  void decrement() {
    counter--;
    notifyListeners();
  }
}

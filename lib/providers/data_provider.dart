import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class DataProvider extends ChangeNotifier{
  bool _isLoading = false;
  String? _errorMessage = '';
  List<Map<String, dynamic>>? _data = [];
  String baseUrl = "http://127.0.0.1:5000/products";

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>>? get data => _data;

  Future<void> fetchInventory() async {
    _isLoading = true;
    notifyListeners();

    try{
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200){
        _data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        print(_data.runtimeType!);
        print(_data);
        _errorMessage = null;
      }
      else
      {
        _errorMessage = "Failed to Load Data";
      }
    }
    catch(e){
      _errorMessage = "An Error has occurred: $e";
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToInventory(String productName, double price) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'product': productName,
          'price': price,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _errorMessage = null;
        fetchInventory(); // Optionally fetch the updated list after adding
      } else {
        _errorMessage = 'Failed to add product';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }
    notifyListeners();
}
}
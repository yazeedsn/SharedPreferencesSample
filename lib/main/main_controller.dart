import 'package:flutter/material.dart';

class MainController extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  bool isSnakebarActive = false;

  String _result = '';
  String get result => _result;

  void setResult(String value) {
    _result = value;
    notifyListeners();
  }
}

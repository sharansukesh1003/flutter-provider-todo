import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<String> list = [];
  void addListItem(String task) {
    list.add(task);
    notifyListeners();
  }

  void deleteListItem(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}

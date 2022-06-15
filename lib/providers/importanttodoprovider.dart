import 'package:flutter/material.dart';

class ImportantTodoProvider with ChangeNotifier {
  List<String> list = [];
  void addListItem(String task) {
    list.add(task);
    notifyListeners();
  }

  void removeListItem(String task) {
    list.remove(task);
    notifyListeners();
  }
}

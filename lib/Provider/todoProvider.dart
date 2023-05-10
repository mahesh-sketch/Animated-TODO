import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:animatedtodolist/animatedtodo.dart';

class TodoProvider with ChangeNotifier {
  final List item = [];
  List get _item => item;

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  GlobalKey<AnimatedListState> get key => _key;

  void addItem(String title) {
    item.insert(0, title);
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
    notifyListeners();
  }
}

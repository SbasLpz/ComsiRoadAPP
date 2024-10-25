import 'package:flutter/cupertino.dart';

class NavigationManager extends ChangeNotifier {
  static final NavigationManager instancia = NavigationManager._internal();
  factory NavigationManager() {
    return instancia;
  }
  NavigationManager._internal();

  int currentPageIndexNavBar0 = 0;

  setIndex(int index){
    currentPageIndexNavBar0 = index;
    notifyListeners();
  }
}
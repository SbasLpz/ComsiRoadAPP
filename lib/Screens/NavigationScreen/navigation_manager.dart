import 'package:flutter/cupertino.dart';

class NavigationManager extends ChangeNotifier {
  /** Singleton para que en cualquier llamada se accedan a los mismos datos  */
  static final NavigationManager instancia = NavigationManager._internal();
  factory NavigationManager() {
    return instancia;
  }
  NavigationManager._internal();

  /** Variable que controla el indice de BottomNavigationBar, es decir la pantalla
   * en la que esta el usuario */
  int currentPageIndexNavBar0 = 0;

  /** Metodo que controla el cambio de indice del BottomNavigationBar */
  setIndex(int index){
    currentPageIndexNavBar0 = index;
    notifyListeners();
  }
}
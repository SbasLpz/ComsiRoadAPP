part of 'navigation_screen.dart';

/// Lista de Wdigets (Pantallas) que maneja el BottomNavigationBar.
/// Si se agrega alguna más esta debe crear su respectivo NavigationDestination
/// en el NavigationBar.
List<Widget>navbarOpciones = [
  const UnitsScreen(),
  const MapScreen(),
  const AlertasScreen(),
  const SettingsScreen(),
];
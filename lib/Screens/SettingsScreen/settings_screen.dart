import 'package:app_rutas_comsi/Screens/HistoryScreen/history_screen.dart';
import 'package:app_rutas_comsi/Styles/theme_manager.dart';
import 'package:flutter/material.dart';

import '../../Styles/theme.dart';

part 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool darkMode2 = themeManager.myAttrs.mode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80,),
          Center(
              child: Text("Ajustes", style: txtTheme.titleSmall!.copyWith(fontSize: 22),)
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: themeManager.isDarkMode ? COLOR_2 : Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  SwitchListTile(
                      title: Text("Modo oscuro", style: TextStyle(fontSize: 18)),
                      value: themeManager.isDarkMode,
                      onChanged: (newValue) {
                        themeManager.toggleTheme();
                        setState(() {
                          darkMode2 = newValue;
                        });
                      }
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                    child: Text("Cerrar sesión", style: TextStyle(fontSize: 18, )),
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                    child: Text("Terminos de acuerdos y condiciones.", style: TextStyle(fontSize: 18, )),
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

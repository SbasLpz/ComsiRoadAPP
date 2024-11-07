import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Text("Ajustes", style: TextStyle(fontSize: 20, ),)
          ),
          Text("Cerrar sesión"),
          SwitchListTile(
            title: Text("Modo oscuro "),
              value: false,
              onChanged: (newValue) {

              }
          )
        ],
      ),
    );
  }
}

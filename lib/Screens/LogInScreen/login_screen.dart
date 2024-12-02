
import 'package:app_rutas_comsi/Models/validation_model.dart';
import 'package:app_rutas_comsi/Screens/NavigationScreen/navigation_screen.dart';
import 'package:app_rutas_comsi/Service/comsi_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:session_manager/session_manager.dart';

part 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 35.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logoComsi.jpg'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: cuentaController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Cuenta"
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuario"
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Constraseña"
                    ),
                  ),
                  const SizedBox(height: 22,),
                  FilledButton(
                      onPressed: () {
                        //FirebaseCrashlytics.instance.crash();
                        ingresar(context);
                      },
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.redAccent)),
                      child: const Text("Ingresar")
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

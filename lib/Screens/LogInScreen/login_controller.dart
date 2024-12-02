part of 'login_screen.dart';

TextEditingController cuentaController = TextEditingController();
TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();

/// Metodo de ingresar que se encarga de validar que los campos de las credenciales no este vacios
/// antes de ejecutar el request de la API que se encarga de validar que las credenciales sean correctas.
///
ingresar (BuildContext context) {
  if(cuentaController.text.trim() != "" && userController.text.trim() != "" && passController.text.trim() != "") {

    try {
      /** request a la API para validar las credenciales */
      var res = postLogin(cuentaController.text, userController.text, passController.text);

      /** Aca se maneja la respuesta de la API si fue exitosa la consulta o no*/
      res.then((data) {
        if(data is ValidationModel) {
          if(data.success!) {
            SessionManager().setString("tokenUser", data.token.toString());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavigationScreen()),
            );
            print("Consulta EXITOSA: ${data.success}, ${data.msg}");
            SessionManager().setString("cc", passController.text.trim());
          } else {
            showInfoDialog(
                "Credenciales incorrectas",
                "El Usuario, Cuenta o Contraseña son incorrectos.",
                'Entendido',
                context, 'assets/images/problem.jpg');

            print("Consulta FALLIDA: ${data.success}, ${data.msg}, ${data.msg_vencido}");
          }
        } else {
          print("Data is not ValidationModel");
          showInfoDialog(
              "Algo salio mal",
              "Problema: ${data['error']}",
              'Entendido',
              context, 'assets/images/problem.jpg');
        }
      });
    } catch (e) {
      showInfoDialog(
          "Error al iniciar sesión",
          e.toString(),  // Muestra el mensaje de error devuelto
          'Entendido',
          context,
          'assets/images/problem.jpg'
      );
    }
  } else {
    showInfoDialog(
        "Ingrese sus credenciales completas",
        "No pueden ir los campos vacios",
        'Entendido',
        context, 'assets/images/problem.jpg');
  }
}

/// Metodo que se encarga de agregar a SharedPreferences de la app, para almcenar al ID del usuario
/// que se usara más adelante en otros request en diferentes partes de la app.
///
shared(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt("id_usr", id);
}

/// Metodo para crear Dialog, que recibe una serie de parametros con el cuerpo de los Dialog.
showInfoDialog (String mTitle, String content, String mButton, BuildContext context, String asset) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(mTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(content),
            const SizedBox(height: 15,),
            Image.asset(
              asset,
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, mButton),
              child: Text(mButton)
          ),
        ],
      )
  );
}
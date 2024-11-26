
import 'package:flutter/material.dart';

/** Light primary COLORS **/
const COLOR_1 = Colors.redAccent;
const COLOR_2 = Color(0xff6c97be);
const COLOR_3 = Color(0xff0c5fa8);

/** Dark primary COLORS **/

abstract class ThemeAttrs {
  ThemeMode get mode;
  ThemeData get myColors;
  Color get specialColor;
}

class LightThemeAttrs extends ThemeAttrs {
  @override
  ThemeMode get mode => ThemeMode.light;

  @override
  Color get specialColor => Colors.redAccent;

  @override
  ThemeData get myColors => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: Colors.white
      ),
      // bodySmall: TextStyle(
      //   color: Colors.white
      // )
    ),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: COLOR_1
    ),
    scaffoldBackgroundColor: Colors.redAccent,
    //colorScheme: ColorScheme.light(),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(iconColor: WidgetStatePropertyAll(COLOR_1)),
    // )
  );
}

class DarkThemeAttrs extends ThemeAttrs {
  @override
  ThemeMode get mode => ThemeMode.light;

  @override
  Color get specialColor => Color(0xff6c97be);

  @override
  ThemeData get myColors => ThemeData(
    useMaterial3: true,
    //brightness: Brightness.dark,
    textTheme: TextTheme(
      titleSmall: TextStyle(
          color: Colors.white
      ),
      // bodySmall: TextStyle(
      //   color: Colors.white
      // )
    ),
    expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: COLOR_1
    ),
    scaffoldBackgroundColor: COLOR_3,
    cardTheme: CardTheme(
      color: Color(0xff6c97be)
    ),
    dialogBackgroundColor: COLOR_2,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: COLOR_2,
    )
    //colorScheme: ColorScheme.light(),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(iconColor: WidgetStatePropertyAll(COLOR_1)),
    // )
  );
}
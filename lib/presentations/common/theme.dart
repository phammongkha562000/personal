import 'package:flutter/material.dart';
import 'package:personal_manager/presentations/common/colors.dart' as colors;

ThemeData theme() {
  return ThemeData(
      //Font chữ cho toàn bộ source
      fontFamily: "BeVietnamPro",
      textTheme: textTheme(),
      // brightness: Brightness.dark,  // Dùng cho dark theme
      // appBarTheme: appBarTheme(),
      inputDecorationTheme: inputDecorationTheme2(),
      // bottomNavigationBarTheme: bottomNavigationBarThemeData(),
      primaryColor: colors.defaultColor2,
      scaffoldBackgroundColor: colors.defaultColor1,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
              backgroundColor: MaterialStateProperty.all(colors.defaultColor2),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))))),
      primarySwatch: getMaterialColor(colors.defaultColor2));
}

// AppBarTheme appBarTheme() {
//   return AppBarTheme(
//     backgroundColor: MyColor.defaultColor,
//     // elevation: 0,
//     titleTextStyle: textStyleAppBar(),
//     actionsIconTheme: null,
//     centerTitle: true,

//     // titleSpacing: -40,
//   );
// }

TextStyle textStyleAppBar() {
  return const TextStyle(
    color: colors.defaultColor1,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
}

// BottomNavigationBarThemeData bottomNavigationBarThemeData() {
//   return BottomNavigationBarThemeData(
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: MyColor.defaultColor,
//     showUnselectedLabels: false,
//     selectedIconTheme: const IconThemeData(color: MyColor.defaultColor),
//     selectedLabelStyle: selectedLabelStyle(),
//   );
// }

TextStyle selectedLabelStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
}

InputDecorationTheme inputDecorationTheme1() {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32),
    borderSide: const BorderSide(color: colors.spanishLavender),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 15,
    ),
    enabledBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,

    errorStyle: const TextStyle(
      height: 0,
    ), //Dùng để khi error nhưng vẫn giữ nguyên layout
  );
}

InputDecorationTheme inputDecorationTheme2() {
  var border = OutlineInputBorder(
    borderSide: BorderSide(color: colors.spanishLavender),
    borderRadius: BorderRadius.circular(32),
  );
  var focusBorder = OutlineInputBorder(
    borderSide: BorderSide(color: colors.spanishLavender, width: 2),
    borderRadius: BorderRadius.circular(32),
  );
  return InputDecorationTheme(
    filled: true,
    fillColor: colors.defaultColor1,
    // contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
    focusedBorder: focusBorder,
    border: border,
    enabledBorder: border,
    errorBorder: border,
  );
}

TextTheme textTheme() {
  return const TextTheme(
      bodyLarge: TextStyle(
    fontSize: 18,
  ));
}

MaterialColor getMaterialColor(Color color) {
  const Map<int, Color> shades = {
    50: Color.fromRGBO(78, 78, 78, .1),
    100: Color.fromRGBO(78, 78, 78, .2),
    200: Color.fromRGBO(78, 78, 78, .3),
    300: Color.fromRGBO(78, 78, 78, .4),
    400: Color.fromRGBO(78, 78, 78, .5),
    500: Color.fromRGBO(78, 78, 78, .6),
    600: Color.fromRGBO(78, 78, 78, .7),
    700: Color.fromRGBO(78, 78, 78, .8),
    800: Color.fromRGBO(78, 78, 78, .9),
    900: Color.fromRGBO(78, 78, 78, 1),
  };
  return MaterialColor(color.value, shades);
}

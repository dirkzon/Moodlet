import 'package:bletest/settings/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeConfig {
  static config(SettingsManager manager) {
    return ThemeData(
      //font
      fontFamily: 'plus-jakarta-sans',
      textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          //editorial
          titleLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
          //headings
          headlineMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ), //semibold
          headlineLarge:
              TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400), //semibold
          //paragraphs
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
      //colors
      colorScheme: ColorScheme(
          brightness: manager.darkMode ? Brightness.dark : Brightness.light,
          primary: const Color(0xffF47918),
          onPrimary: const Color(0xffFFFFFF),
          secondary: const Color(0xff754DD1),
          onSecondary: const Color(0xffFFFFFF),
          error: const Color(0xffCA681C),
          onError: const Color(0xffFFFFFF),
          background: const Color(0xff5C5C5C),
          onBackground: const Color(0xff5C5C5C),
          surface: const Color(0xffFFFFFF),
          onSurface: const Color(0xff000000)),

      // buttons
      buttonTheme:
          const ButtonThemeData(buttonColor: Color(0xffFFFFFF), minWidth: 800),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(295, 55)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      )),

      //inputs
      // cannot edit width. width should be provided by parent object
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color.fromARGB(31, 118, 118, 128),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
      ),

      //chips
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xffF47918),
        labelStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        iconTheme: const IconThemeData(color: Colors.white),
        deleteIconColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      //text button
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(24.0)),
              textStyle: MaterialStateProperty.all(const TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.w400)))),

      //app bar
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: manager.darkMode ? Colors.white : Colors.black),
          toolbarHeight: 150,
          color: manager.darkMode
              ? const Color.fromARGB(211, 156, 74, 11)
              : const Color.fromARGB(25, 244, 119, 24),
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(
              color: manager.darkMode ? Colors.white : Colors.black)),
      listTileTheme:
          const ListTileThemeData(contentPadding: EdgeInsets.all(24)),
    );
  }
}

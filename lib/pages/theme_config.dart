import 'package:flutter/material.dart';

mixin ThemeConfig {
  static config() {
    return ThemeData(
        //font
        fontFamily: 'plus-jakarta-sans',
        textTheme: const TextTheme(
            labelLarge: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            //editorial
            titleLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            //headings
            headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ), //semibold
            headlineLarge: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.w400), //semibold
            //paragraphs
            bodyMedium:
                TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
        //colors
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xffF47918),
            onPrimary: Color(0xffFFFFFF),
            secondary: Color(0xff754DD1),
            onSecondary: Color(0xffFFFFFF),
            error: Color(0xffCA681C),
            onError: Color(0xffFFFFFF),
            background: Color(0xff5C5C5C),
            onBackground: Color(0xff5C5C5C),
            surface: Color(0xffFFFFFF),
            onSurface: Color(0xff000000)),

        // buttons
        buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xffFFFFFF), minWidth: 800),
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
        chipTheme: const ChipThemeData(
          backgroundColor: Color(0xffF47918),
          labelStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          deleteIconColor: Colors.white,
        )

        //dropdown

        );
  }
}

import 'package:flutter/material.dart';

//Project 3Modals
//SnackBar, Modal, TextField, Drop Down, date picker, alert dialog, context which shows relation between widgets
//Text Editing controller & disposing it
//Icon button & App Bar
//Theming for Dark & light mode

//Pointers & functions passing
//Listview & builder method





import 'package:expense_tracker/expenses.dart';

//Creaintg color scheme

var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

var KDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

void main(){
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: KDarkColorScheme,
         cardTheme: CardTheme().copyWith(
          color: KDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
            ),
        ),
        

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: KDarkColorScheme.primaryContainer,
            foregroundColor: KDarkColorScheme.onPrimaryContainer
          ),
        ),

      ),
      //theme data class can be used to create a new theme for the applicaiton
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,

        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
            ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),

        ),

        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16,
            ),
            

        ),

       // scaffoldBackgroundColor: const Color.fromARGB(255, 141, 173, 233)
      
        ),
         // themeMode: ThemeMode.system ,
      home: Expenses(),
    ),
  );
}
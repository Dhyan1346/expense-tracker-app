import 'package:expance_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';


var kColorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() => runApp(

    const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      darkTheme: ThemeData().copyWith(
        colorScheme: kDarkColorscheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorscheme.primary,
          foregroundColor: kDarkColorscheme.onPrimary,
        ),
        cardTheme: CardTheme(
          color: kDarkColorscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorscheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kDarkColorscheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
      ),

      theme: ThemeData().copyWith(
        colorScheme: kColorscheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorscheme.primary,
          foregroundColor: kColorscheme.onPrimary,
        ),
        cardTheme: CardTheme(
          color: kColorscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorscheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorscheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
      ),

      home: const Expenses(),
    );
  }
}

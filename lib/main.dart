import 'package:flutter/material.dart';
import 'package:expense_tracker/home_screen.dart';

void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        textTheme: const TextTheme().copyWith(
          bodySmall: const TextStyle(
            color: Color.fromARGB(255, 58, 103, 147),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 35, 85, 116)),
        iconTheme: const IconThemeData()
            .copyWith(color: const Color.fromARGB(255, 48, 116, 180))),
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 113, 72, 184)),
        iconTheme: const IconThemeData().copyWith(color: Colors.deepPurple)),
    themeMode: ThemeMode.light,
    home: const Home(),
  ));
}
